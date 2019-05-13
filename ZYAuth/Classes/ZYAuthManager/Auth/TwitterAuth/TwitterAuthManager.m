//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "TwitterAuthManager.h"
#import "TwitterAuthManager+Login.h"

@interface TwitterAuthManager()

@end

@implementation TwitterAuthManager


#pragma mark - manager Protocol

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    [[Twitter sharedInstance] startWithConsumerKey:appKey consumerSecret:appSecret];
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[Twitter sharedInstance] application:application openURL:url options:annotation];
}


/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}

@end
