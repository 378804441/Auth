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

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

@implementation SinaAuthManager


#pragma mark - manager Protocol

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.redirectURI = redirectURI;
    [WeiboSDK registerApp:appKey];
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([WeiboSDK handleOpenURL:url delegate:self]) {
        return YES;
    }
    return NO;
}

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([WeiboSDK handleOpenURL:url delegate:self]) {
        return YES;
    }
    return NO;
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


#pragma mark - 微博 delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    /** 授权登录 */
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        
        // 授权成功
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (!IsNull(response.userInfo)) {
                [dic setObject:response.userInfo forKey:@"userInfo"];
            }
            if(self.successBlock) self.successBlock([dic copy]);
        }else{
            if (self.failureBlock) self.failureBlock(@"授权失败", nil);
        }
        
    }
    
}



@end
