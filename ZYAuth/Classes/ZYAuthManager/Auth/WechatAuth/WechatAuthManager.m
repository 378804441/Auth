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

@end

@implementation WechatAuthManager

#pragma mark - manager Protocol

/** 向微信注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    [WXApi registerApp:appKey];
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
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; // @"snsapi_message,snsapi_friend,snsapi_contact,post_timeline,sns"
    req.state = random;
    BOOL ret;
    
    // 有控制器传入 优先走 不依赖客户端注册方法
    if (viewcontrol) {
        ret = [WXApi sendAuthReq:req viewController:viewcontrol delegate:self];
    // 依赖微信客户端注册方法
    }else{
        ret = [WXApi sendReq:req];
    }

    
    if (!ret) {
        failure(NO, @"登录失败", nil, nil, nil, nil);
    }
}

/**************** 微信 delegate *************/
/** 发送一个sendReq后，收到微信的回应 */
-(void)onResp:(BaseResp *)resp{

}


@end
