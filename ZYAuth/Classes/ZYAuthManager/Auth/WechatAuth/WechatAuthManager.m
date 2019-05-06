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


/** 注册 */
-(void)registerAuthWithAppId:(NSString *)appid appsecret:(NSString *)appsecret{
    [WXApi registerApp:appid];
}

-(void)_wxLoginWithViewControl:(UIViewController *)viewcontrol{
    NSString *random = [NSString stringWithFormat:@"%@", @(arc4random())];
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; // @"snsapi_message,snsapi_friend,snsapi_contact,post_timeline,sns"
    req.state = random;

    // 有控制器传入 优先走 不依赖客户端注册方法
    if (viewcontrol) {
        BOOL ret = [WXApi sendAuthReq:req viewController:viewcontrol delegate:self];
        if (!ret) {
//            self.failureBlock(NO, @"登录失败", nil, nil, nil, nil);
        }
        return;
    }

    // 依赖微信客户端注册方法
    [WXApi sendReq:req];
}

/**************** 微信 delegate *************/
/** 发送一个sendReq后，收到微信的回应 */
-(void)onResp:(BaseResp *)resp{

}


@end
