//
//  GoogleAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "GoogleAuthManager+Login.h"

@implementation GoogleAuthManager (Login)


#pragma mark - Protocol

/** 登录 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.rootViewController = viewController;
    [self _googleLoginWithViewController:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    NSLog(@"error : 不支持 非VC下唤起登录");
}

- (void)logOut{
    [[GIDSignIn sharedInstance] signOut];
}


#pragma mark - private method

-(void)_googleLoginWithViewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.successBlock = success;
    self.failureBlock = failure;
    [GIDSignIn sharedInstance].uiDelegate = (id)self.rootViewController;
    [[GIDSignIn sharedInstance] signIn];
}


@end
