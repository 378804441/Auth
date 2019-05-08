//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "WechatAuthManager.h"
#import "ZYAuthProtocol.h"
#import <WechatOpenSDK/WXApi.h>


@interface WechatAuthManager()<WXApiDelegate, ZYAuthProtocol>

@property (nonatomic, strong) NSString *appID;

@property (nonatomic, strong) NSString *appSecret;

@property (nonatomic, strong) NSString *random;

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

@implementation WechatAuthManager


+(void)load{
    //执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __block id observer =
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
//            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }];
    });
}

#pragma mark - manager Protocol

/** 向微信注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.appID     = appId;
    self.appSecret = appSecret;
    [WXApi registerApp:appKey];
}

-(BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    // 如果是微信支付，不在这里处理回调
    NSRange range = [[url absoluteString] rangeOfString:@"//pay/?"];
    if (range.location == NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return NO;
    }
}

- (BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果是微信支付，不在这里处理回调
    NSRange range = [[url absoluteString] rangeOfString:@"//pay/?"];
    if (range.location == NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return NO;
    }
}

/** 登录 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _wxLoginWithViewControl:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _wxLoginWithViewControl:nil success:success failure:failure];
}


#pragma mark - private method

-(void)_wxLoginWithViewControl:(UIViewController *)viewcontrol success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    NSString *random = [NSString stringWithFormat:@"%@", @(arc4random())];
    self.successBlock = success;
    self.failureBlock = failure;
    self.random = random;
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope   = @"snsapi_userinfo"; // @"snsapi_message,snsapi_friend,snsapi_contact,post_timeline,sns"
    req.state   = random;
    BOOL ret;
    
    // 有控制器传入 优先走 不依赖客户端注册方法
    if (viewcontrol) {
        ret = [WXApi sendAuthReq:req viewController:viewcontrol delegate:self];
    // 依赖微信客户端注册方法
    }else{
        ret = [WXApi sendReq:req];
    }

    if (!ret && failure) {
        failure(@"调起微信失败", nil);
    }
}




/**************** 微信 delegate *************/
/** 发送一个sendReq后，收到微信的回应 */
-(void)onResp:(BaseResp *)resp{

    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (resp.errCode == WXSuccess) {
            if(self.successBlock) self.successBlock(nil);
        } else if (resp.errCode == WXErrCodeUserCancel) {
            if (self.failureBlock) self.failureBlock(@"失败 : 用户点击取消并返回", nil);
        } else {
            if (self.failureBlock) self.failureBlock(resp.errStr, nil);
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        if (temp.errCode == WXSuccess && [temp.state isEqualToString:self.random]) {
            NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", self.appID, self.appSecret, temp.code];
            __weak __typeof(self) weakSelf = self;
            NSURLSession * session = [NSURLSession sharedSession];
            NSURLSessionDataTask * task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                
                if (!IsNull(error) || IsNull(data)) {
                    if (strongSelf.failureBlock) {
                        strongSelf.failureBlock(@"登录失败", error);
                    }
                }else{
                    NSDictionary * disResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    if (strongSelf.successBlock) {
                        strongSelf.successBlock(disResponse);
                    }
                }
                
            }];
            [task resume];
        } else if (temp.errCode == WXErrCodeUserCancel) {
            if (self.failureBlock) self.failureBlock(@"登录失败", nil);
        } else {
            if (self.failureBlock) self.failureBlock(@"登录失败", nil);
        }
    }
    
}

-(void)onReq:(BaseReq *)req{
    
}

@end
