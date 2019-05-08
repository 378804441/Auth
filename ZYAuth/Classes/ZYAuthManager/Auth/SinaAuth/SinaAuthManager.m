//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "SinaAuthManager.h"
#import "ZYAuthProtocol.h"
#import <Weibo_SDK/WeiboSDK.h>

@interface SinaAuthManager()<ZYAuthProtocol, WeiboSDKDelegate>

@property (nonatomic, strong) NSString *redirectURI;

@end

@implementation SinaAuthManager


#pragma mark - manager Protocol

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.redirectURI = redirectURI;
    [WeiboSDK registerApp:appKey];
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}


/** 登录 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _sinaWbLoginWithSuccess:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _sinaWbLoginWithSuccess:success failure:failure];
}


#pragma mark - private method

-(void)_sinaWbLoginWithSuccess:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = self.redirectURI;
    request.scope = @"follow_app_official_microblog";
    
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret && failure) {
        failure(@"登录失败", nil);
    }
}


#pragma mark - 微博 delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}



@end
