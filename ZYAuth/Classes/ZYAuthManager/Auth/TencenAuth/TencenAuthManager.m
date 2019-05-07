//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "TencenAuthManager.h"
#import "iOS_OpenSDK_V3.2.0_lite/TencentOpenAPI.framework/Headers/QQApiInterface.h"
#import "iOS_OpenSDK_V3.2.0_lite/TencentOpenAPI.framework/Headers/TencentOAuth.h"


@interface TencenAuthManager()<QQApiInterfaceDelegate, TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oauth;

@end

@implementation TencenAuthManager


#pragma mark - manager Protocol

/** 向qq注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.oauth = [[TencentOAuth alloc] initWithAppId:appKey andDelegate:self];
    [self.oauth setAuthShareType:[self getAuthShareType]];
}

/** 登录 */
-(void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _qqLoginWithViewController:viewController success:success failure:failure];
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self _qqLoginWithViewController:nil success:success failure:failure];
}


#pragma mark - private method

/** 进行登录呼起 */
-(void)_qqLoginWithViewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    BOOL ret = [self.oauth authorize:@[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_GET_INFO]];
    if (!ret) {
        failure(NO, @"登录失败", nil, nil, nil, nil);
    }
}

/** 获取 授权/分享 方式 */
- (TencentAuthShareType)getAuthShareType {
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        return AuthShareType_QQ;
    }
    
    if ([QQApiInterface isTIMInstalled] && [QQApiInterface isTIMSupportApi]) {
        return AuthShareType_TIM;
    }
    
    return AuthShareType_TIM;
}

/** 分享到QQ 或 TIM */
- (ShareDestType)getShareDescType {
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        return ShareDestTypeQQ;
    }
    
    if ([QQApiInterface isTIMInstalled] && [QQApiInterface isTIMSupportApi]) {
        return ShareDestTypeTIM;
    }
    
    return ShareDestTypeTIM;
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}

- (void)onReq:(QQBaseReq *)req {
    
}

- (void)onResp:(QQBaseResp *)resp {
    
}

- (void)tencentDidLogin {
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

- (void)tencentDidNotNetWork {
    
}

@end
