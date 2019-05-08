//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "GoogleAuthManager.h"
#import "GoogleAuthManager+Login.h"


@interface GoogleAuthManager()

@end

@implementation GoogleAuthManager


#pragma mark - manager Protocol

-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    [GIDSignIn sharedInstance].clientID = appId;
    [GIDSignIn sharedInstance].delegate = self;
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}


#pragma mark - google delegate

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    if (IsNull(error)) {
        NSString *userId     = IsEmpty(user.userID) ? @"" : user.userID;
        NSString *idToken    = IsEmpty(user.authentication.idToken) ? @"" : user.authentication.idToken;
        NSString *fullName   = IsEmpty(user.profile.name) ? @"" : user.profile.name;
        NSString *givenName  = IsEmpty(user.profile.givenName) ? @"" : user.profile.givenName;
        NSString *familyName = IsEmpty(user.profile.familyName) ? @"" : user.profile.familyName;
        NSString *email      = IsEmpty(user.profile.email) ? @"" : user.profile.email;
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        [dataDic setObject:userId forKey:@"userId"];
        [dataDic setObject:idToken forKey:@"idToken"];
        [dataDic setObject:fullName forKey:@"fullName"];
        [dataDic setObject:givenName forKey:@"givenName"];
        [dataDic setObject:familyName forKey:@"familyName"];
        [dataDic setObject:email forKey:@"email"];
        
        if(self.successBlock) self.successBlock([dataDic copy]);
    }else{
        if (self.failureBlock) self.failureBlock(error.localizedDescription, error);
    }
    
}


// This callback is triggered after the disconnect call that revokes data
// access to the user's resources has completed.
// [START disconnect_handler]
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // [START_EXCLUDE]
    NSDictionary *statusText = @{@"statusText": @"Disconnected user" };
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ToggleAuthUINotification"
     object:nil
     userInfo:statusText];
    // [END_EXCLUDE]
}




@end
