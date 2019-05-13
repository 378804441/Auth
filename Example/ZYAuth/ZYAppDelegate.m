//
//  ZYAppDelegate.m
//  ZYAuth
//
//  Created by 378804441@qq.com on 05/06/2019.
//  Copyright (c) 2019 378804441@qq.com. All rights reserved.
//

#import "ZYAppDelegate.h"
#import "ZYAuthManager.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZYAppDelegate()<WXApiDelegate>

@end

@implementation ZYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
}

- (void)applicationWillTerminate:(UIApplication *)application{
}

@end
