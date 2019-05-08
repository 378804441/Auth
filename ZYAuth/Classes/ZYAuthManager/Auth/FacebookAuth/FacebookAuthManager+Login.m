//
//  FacebookAuthManager+Login.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "FacebookAuthManager+Login.h"

@implementation FacebookAuthManager (Login)

#pragma mark - Protocol

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
            
            if (result.isCancelled) {
                if (failure) failure(@"取消登录", nil);
                return ;
            }
            
            NSMutableDictionary *successDic = [NSMutableDictionary dictionary];
            
            NSString *appid = IsEmpty(result.token.appID) ? @"" : result.token.appID;
            NSString *userid = IsEmpty(result.token.userID) ? @"" : result.token.userID;
            NSString *token = IsEmpty(result.token.tokenString) ? @"" : result.token.tokenString;
            
            [successDic setObject:appid forKey:@"appID"];
            [successDic setObject:userid forKey:@"userID"];
            [successDic setObject:token forKey:@"tokenString"];
            
            if (!IsNull(result.token.refreshDate)) {
                [successDic setObject:result.token.refreshDate forKey:@"refreshDate"];
            }
            if (!IsNull(result.token.expirationDate)) {
                [successDic setObject:result.token.expirationDate forKey:@"expirationDate"];
            }
            if (!IsNull(result.token.dataAccessExpirationDate)) {
                [successDic setObject:result.token.dataAccessExpirationDate forKey:@"dataAccessExpirationDate"];
            }
            if(success) success([successDic copy]);
        }
    }];
}

@end
