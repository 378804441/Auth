//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "WechatAuthManager.h"
#import "WechatAuthManager+Login.h"
#import "WechatAuthManager+Share.h"


@interface WechatAuthManager()

@end

@implementation WechatAuthManager


#pragma mark - manager Protocol

/** 向微信注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.appID     = appId;
    self.appSecret = appSecret;
    [WXApi registerApp:appId];
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

/** 检测是否安装app */
-(BOOL)checkAppInstalled{
    return [WXApi isWXAppInstalled];
}

-(BOOL)checkAppSupportApi{
    return [WXApi isWXAppSupportApi];
}


#pragma mark - 微信 delegate

/** 发送一个sendReq后，收到微信的回应 */
-(void)onResp:(BaseResp *)resp{
    
    // 分享时的回调
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (resp.errCode == WXSuccess) {
            if(self.shareSuccessBlock) self.shareSuccessBlock(@"分享成功");
        } else if (resp.errCode == WXErrCodeUserCancel) {
            if(self.failureBlock) self.failureBlock(@"取消分享", nil);
        } else {
            if(self.failureBlock) self.failureBlock(resp.errStr, nil);
        }
    }

    
    // 三方登录时的回调
    else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
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
