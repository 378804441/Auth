//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "TencentAuthManager.h"
#import "TencentAuthManager+Login.h"

@interface TencentAuthManager()

@end

@implementation TencentAuthManager


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

/** 检测是否安装app */
-(BOOL)checkAppInstalled{
    return [QQApiInterface isQQInstalled];
}

-(BOOL)checkAppSupportApi{
    return [QQApiInterface isQQSupportApi];
}


#pragma mark - private method

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
    if (resp.type == ESENDMESSAGETOQQRESPTYPE) {
        SendMessageToQQResp *sendResp = (SendMessageToQQResp *)resp;
        if ([sendResp.result isEqualToString:@"0"]) {
            if(self.shareSuccessBlock) self.shareSuccessBlock(@"分享成功");
        }else if ([sendResp.result isEqualToString:@"-4"]) {
            if (self.failureBlock) self.failureBlock(@"取消分享", nil);
        }else {
            if (self.failureBlock) self.failureBlock(sendResp.errorDescription, nil);
        }
    }
}

- (void)onReq:(QQBaseReq *)req {
    
}

- (void)isOnlineResponse:(NSDictionary *)response {
}


#pragma mark - 获取用户信息

- (void)getUserInfoResponse:(APIResponse *)response {
    if (0 == response.retCode) {
        __block NSMutableDictionary *responseDic = [NSMutableDictionary dictionary];
        [responseDic setValue:self.oauth.accessToken forKey:@"accessToken"];
        [responseDic setValue:self.oauth.appId forKey:@"appId"];
        [responseDic setValue:response.jsonResponse forKey:@"userInfo"];
        
        WS(weakSelf);
        [self getQQUnionIDFromAccessToken:self.oauth.accessToken result:^(NSDictionary *dic) {
            SS(strongSelf);
            if (dic) {
                [responseDic addEntriesFromDictionary:dic];
            }else{
                [responseDic setValue:strongSelf.oauth.openId forKey:@"openid"];
            }
            if(strongSelf.successBlock) strongSelf.successBlock([responseDic copy]);
        }];
        
    }else {
        if (self.failureBlock) self.failureBlock(response.errorMsg, nil);
    }
}


/** 获取unionid 等信息 */
- (void)getQQUnionIDFromAccessToken:(NSString *)strAccessToken
                             result:(void(^)(NSDictionary *dic))result {
    
    NSString * strUrl = [NSString stringWithFormat:@"https://graph.qq.com/oauth2.0/me?access_token=%@&unionid=1", strAccessToken];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                NSString * strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                if (strData.length < 20) {
                                                    if (result) {
                                                        result(nil);
                                                    }
                                                    return;
                                                }
                                                
                                                NSRange startRange = [strData rangeOfString:@"{"];
                                                if (startRange.location == NSNotFound) {
                                                    if (result) {
                                                        result(nil);
                                                    }
                                                    return;
                                                }
                                                
                                                NSRange endRange = [strData rangeOfString:@"}"];
                                                if (endRange.location == NSNotFound) {
                                                    if (result) {
                                                        result(nil);
                                                    }
                                                    return;
                                                }
                                                
                                                NSRange allRange = NSMakeRange(startRange.location, endRange.location - startRange.location + 1);
                                                
                                                if (strData.length < allRange.location + allRange.length) {
                                                    if (result) {
                                                        result(nil);
                                                    }
                                                    return;
                                                }
                                                
                                                NSString * strJson = [strData substringWithRange:allRange];
                                                if (strJson) {
                                                    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[strJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                    
                                                    if (dic) {
                                                        if (result) {
                                                            result(dic);
                                                        }
                                                        return;
                                                    }
                                                }
                                                
                                                if (result) {
                                                    result(nil);
                                                }
                                            }];
    
    [task resume];
}






@end
