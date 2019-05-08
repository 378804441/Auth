//
//  SinaAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "SinaAuthManager+Login.h"

@implementation SinaAuthManager (Login)


#pragma mark - Protocol

- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _sinaWbLoginWithSuccess:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _sinaWbLoginWithSuccess:success failure:failure];
}


#pragma mark - private method

-(void)_sinaWbLoginWithSuccess:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    self.successBlock = success;
    self.failureBlock = failure;
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = self.redirectURI;
    request.scope = @"follow_app_official_microblog";
    
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret && failure) {
        failure(@"登录失败", nil);
    }
}


@end
