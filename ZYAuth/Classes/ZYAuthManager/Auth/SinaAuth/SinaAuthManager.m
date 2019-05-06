//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "SinaAuthManager.h"
#import "ZYAuthProtocol.h"
#import <Weibo_SDK/WeiboSDK.h>

@interface SinaAuthManager()<ZYAuthProtocol, WeiboSDKDelegate>

@property (nonatomic, strong) NSString *redirectURI;

@end

@implementation SinaAuthManager

-(void)registerAuthWithAppId:(NSString *)appid appsecret:(NSString *)appsecret{
    self.redirectURI = appsecret;
    [WeiboSDK registerApp:appid];
}


-(void)_sinaWbLogin{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = self.redirectURI;
    request.scope = @"follow_app_official_microblog";
    
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
//        self.failureBlock(NO, @"登录失败", nil, nil, nil, nil);
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}



@end
