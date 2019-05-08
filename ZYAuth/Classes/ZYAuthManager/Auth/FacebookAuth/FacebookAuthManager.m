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

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication]
                             didFinishLaunchingWithOptions:@{}];
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}


/** 登录 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _facebookLoginWithViewController:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    NSLog(@"error : 不支持 非VC下唤起登录");
}


#pragma mark - private method

-(void)_facebookLoginWithViewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPermissions:@[@"public_profile"] fromViewController:(id)viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            if(failure) failure(error.localizedDescription, error);
        }else{
            NSMutableDictionary *successDic = [NSMutableDictionary dictionary];
            [successDic setObject:result.token.appID forKey:@"appID"];
            [successDic setObject:result.token.userID forKey:@"userID"];
            [successDic setObject:result.token.tokenString forKey:@"tokenString"];
            [successDic setObject:result.token.refreshDate forKey:@"refreshDate"];
            [successDic setObject:result.token.expirationDate forKey:@"expirationDate"];
            [successDic setObject:result.token.dataAccessExpirationDate forKey:@"dataAccessExpirationDate"];
            if(success) success([successDic copy]);
        }
    }];
}


#pragma mark - Facebook delegate




@end
