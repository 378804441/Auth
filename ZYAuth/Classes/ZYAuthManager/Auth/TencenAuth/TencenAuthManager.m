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

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

@implementation TencenAuthManager


#pragma mark - manager Protocol

/** 向qq注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
    self.oauth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
    [self.oauth setAuthShareType:[self getAuthShareType]];
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([QQApiInterface handleOpenURL:url delegate:self]) {
        return YES;
    }else if ([TencentOAuth HandleOpenURL:url]) {
        return YES;
    }
    return NO;
}

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([QQApiInterface handleOpenURL:url delegate:self]) {
        return YES;
    }else if ([TencentOAuth HandleOpenURL:url]) {
        return YES;
    }
    return NO;
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
    self.successBlock = success;
    self.failureBlock = failure;
    BOOL ret = [self.oauth authorize:@[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_GET_INFO]];
    if (!ret && failure) {
        failure(@"登录失败", nil);
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


#pragma mark - tencent delegate

- (void)tencentDidLogin {
    if (self.oauth.accessToken.length > 0) {
        // 调用获取用户信息
        BOOL ret = [self.oauth getUserInfo];
        if (!ret) {  //未获取到用户身份信息，重新登录
            if (self.failureBlock) self.failureBlock(@"登录失败", nil);
        }
    }else{
        if (self.failureBlock) self.failureBlock(@"登录失败", nil);
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        if (self.failureBlock) self.failureBlock(@"取消登录", nil);
    }else{
        if (self.failureBlock) self.failureBlock(@"登录失败", nil);
    }
}

- (void)tencentDidNotNetWork {
    if (self.failureBlock) self.failureBlock(@"无网络连接", nil);
}

- (void)onResp:(QQBaseResp *)resp {
}

- (void)onReq:(QQBaseReq *)req {
}

- (void)isOnlineResponse:(NSDictionary *)response {
}


#pragma mark - 获取用户信息
- (void)getUserInfoResponse:(APIResponse *)response {
    if (0 == response.retCode) {
        NSMutableDictionary *responseDic = [NSMutableDictionary dictionary];
        [responseDic setValue:self.oauth.openId forKey:@"openId"];
        [responseDic setValue:self.oauth.accessToken forKey:@"accessToken"];
        [responseDic setValue:self.oauth.appId forKey:@"appId"];
        [responseDic setValue:response.jsonResponse forKey:@"userInfo"];
        if(self.successBlock) self.successBlock([responseDic copy]);
    }else {
        if (self.failureBlock) self.failureBlock(response.errorMsg, nil);
    }
}


@end
