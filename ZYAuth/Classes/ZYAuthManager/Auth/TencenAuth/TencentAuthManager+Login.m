//
//  TencentAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "TencentAuthManager+Login.h"

@implementation TencentAuthManager (Login)


#pragma mark - Protocol

-(void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _qqLoginWithViewController:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _qqLoginWithViewController:nil success:success failure:failure];
}


#pragma mark - private method

/** 进行登录呼起 */
-(void)_qqLoginWithViewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.successBlock = success;
    self.failureBlock = failure;
    BOOL ret = [self.oauth authorize:@[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_GET_INFO]];
    if (!ret && failure) {
        failure(@"登录失败", nil);
    }
}


@end
