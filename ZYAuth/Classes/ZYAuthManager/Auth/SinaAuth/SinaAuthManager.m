//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "SinaAuthManager.h"
#import "SinaAuthManager+Login.h"

@interface SinaAuthManager()

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
