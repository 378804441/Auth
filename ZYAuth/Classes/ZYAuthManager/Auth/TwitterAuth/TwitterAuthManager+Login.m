//
//  TwitterAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "TwitterAuthManager+Login.h"

@implementation TwitterAuthManager (Login)


#pragma mark - Protocol

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
