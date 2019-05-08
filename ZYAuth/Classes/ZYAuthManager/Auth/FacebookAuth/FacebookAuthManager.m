//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "FacebookAuthManager.h"
#import "ZYAuthProtocol.h"
#import  <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookAuthManager()<ZYAuthProtocol>

@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation FacebookAuthManager


#pragma mark - manager Protocol

-(void)registerFacebookWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

-(BOOL)openURLFacebookWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

/** 登录 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _facebookLoginWithViewController:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    NSLog(@"error : 不支持 非VC下唤起登录");
}

- (void)logOut{
    
}


#pragma mark - private method

-(void)_facebookLoginWithViewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPermissions:@[@"public_profile"] fromViewController:(id)viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
    }];
}


#pragma mark - Facebook delegate




@end
