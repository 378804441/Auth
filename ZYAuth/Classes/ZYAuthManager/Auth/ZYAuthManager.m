//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "ZYAuthManager.h"

//#import <WechatOpenSDK/WXApi.h>
#import <Weibo_SDK/WeiboSDK.h>


@interface ZYAuthManager()<WeiboSDKDelegate>

@property (nonatomic, strong) ZYAuthSuccessBlock successBlock;
@property (nonatomic, strong) ZYAuthFailureBlock failureBlock;

@end

@implementation ZYAuthManager


#pragma mark - init

/** 尝试创建各个平台对象, 排查是否引入进来 */
+(void)initialize{
    
    Class wxClass = NSClassFromString(@"WXApi");
    Class sinaWbClass = NSClassFromString(@"WeiboSDK");
    
    
    if (wxClass) {
        NSLog(@"~~~~~~~  创建成功");
    }
    
    
    // 微信注册授权
//    [WXApi registerApp:WECHAT_APPID];
    
    // 微博注册
//    [WeiboSDK registerApp:SINA_APPKEY];
    
}

+(ZYAuthManager *)shareInstance {
    static ZYAuthManager *instance = nil;
    static dispatch_once_t obj;
    dispatch_once(&obj, ^{
        instance = [[self class] new];
    });
    return instance;
}


#pragma mark - public method

/**
 进行登录
 type           : 登录类型
 viewController : 依附VC
 success        : 登录成功回调
 failure        : 登录失败
 */
-(void)authLoginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.successBlock = success;
    self.failureBlock = failure;
    switch (type) {
        case ZYAuthManager_wx:
            [self _wxLoginWithViewControl:viewController];
            break;
        case ZYAuthManager_qq:
            
            break;
        case ZYAuthManager_wb:
            [self _sinaWbLogin];
            break;
    }
}


#pragma mark - private method

+ (BOOL)handleOpenURL:(NSURL *)url {
//    if ([XCSocialWeChatHelper handleOpenURL:url]) {
//        return YES;
//    } else if ([XCSocialQQHelper handleOpenURL:url]) {
//        return YES;
//    } else if ([XCSocialSinaWeiboHelper handleOpenURL:url]) {
//        return YES;
//    }
    
    return YES;
}


#pragma mark - ********************** 微信相关方法 **************************

-(void)_wxLoginWithViewControl:(UIViewController *)viewcontrol{
//    NSString *random = [NSString stringWithFormat:@"%@", @(arc4random())];
//    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo"; // @"snsapi_message,snsapi_friend,snsapi_contact,post_timeline,sns"
//    req.state = random;
//
//    // 有控制器传入 优先走 不依赖客户端注册方法
//    if (viewcontrol) {
//        BOOL ret = [WXApi sendAuthReq:req viewController:viewcontrol delegate:[ZYAuthManager shareInstance]];
//        if (!ret) {
//            self.failureBlock(NO, @"登录失败", nil, nil, nil, nil);
//        }
//        return;
//    }
//
//    // 依赖微信客户端注册方法
//    [WXApi sendReq:req];
}

/**************** 微信 delegate *************/
/** 发送一个sendReq后，收到微信的回应 */
//-(void)onResp:(BaseResp *)resp{
//
//}



#pragma mark - ********************** 微博相关方法 **************************

-(void)_sinaWbLogin{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = SINA_REDIRECTURI;
    request.scope = @"follow_app_official_microblog";
    
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
        self.failureBlock(NO, @"登录失败", nil, nil, nil, nil);
    }
}



- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}

@end
