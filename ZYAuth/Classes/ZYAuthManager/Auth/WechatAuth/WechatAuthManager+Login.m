//
//  WechatAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "WechatAuthManager+Login.h"

@implementation WechatAuthManager (Login)


#pragma mark - Protocol

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
    req.scope   = @"snsapi_userinfo";
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

@end
