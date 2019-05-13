//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "FacebookAuthManager.h"
#import "FacebookAuthManager+Login.h"

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


#pragma mark - Facebook delegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    if (!sharer.shouldFailOnDataError) {
        if(self.shareSuccessBlock) self.shareSuccessBlock([NSString stringWithFormat:@"%@", sharer.shareContent.shareUUID]);
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    if (sharer.shouldFailOnDataError) {
        if(self.failureBlock) self.failureBlock(error.localizedDescription, error);
    }
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    if(self.failureBlock) self.failureBlock(@"取消分享", nil);
}




@end
