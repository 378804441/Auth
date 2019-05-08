//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "TwitterAuthManager.h"
#import "ZYAuthProtocol.h"
#import <TwitterKit/TwitterKit.h>


@interface TwitterAuthManager()<ZYAuthProtocol>

@end

@implementation TwitterAuthManager


#pragma mark - manager Protocol

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    [[Twitter sharedInstance] startWithConsumerKey:appKey consumerSecret:appSecret];
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
    [self _twitterLoginWithSuccess:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _twitterLoginWithSuccess:success failure:failure];
}


#pragma mark - private method

-(void)_twitterLoginWithSuccess:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        if(session){
            NSMutableDictionary *successDic = [NSMutableDictionary dictionary];
            [successDic setObject:session.authToken forKey:@"authToken"];
            [successDic setObject:session.authTokenSecret forKey:@"authTokenSecret"];
            [successDic setObject:session.userName forKey:@"userName"];
            [successDic setObject:session.userID forKey:@"userID"];
            if (success) success([successDic copy]);
        }else{
            if (failure) failure(error.localizedDescription, error);
        }
    }];
}


@end
