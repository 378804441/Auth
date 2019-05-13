//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "WhatsappAuthManager.h"


@interface WhatsappAuthManager()

@end

@implementation WhatsappAuthManager


#pragma mark - manager Protocol

/** 向微信注册 */
-(void)registerAuthWithAppId:(NSString *)appId appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURI:(NSString *)redirectURI{
}

-(BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return NO;
}

- (BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return NO;
}


/** 登录 */
-(void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController * __nullable)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    if(failure) failure(@"Whatsapp 不支持三方登录", nil);
}

-(void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self loginWithType:type viewController:nil success:success failure:failure];
}


/** 分享 */
-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController * __nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    if (shareModel.shareType == ZYShareTypeLink) {
        [self shareMessageWithWithModel:shareModel success:success failure:failure];
        return;
    }
    if (failure) failure(@"warning : 分享目标不支持.\nWhatsapp 仅支持 ZYShareTypeLink 类型分享", nil);
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}


#pragma mark - private method

-(void)shareMessageWithWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    if (IsEmpty(shareModel.urlString)) {
        if(failure) failure(@"分享链接为空", nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"whatsapp://send?text=%@", [shareModel.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    NSURL *whatsappURL = [NSURL URLWithString: url];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}

@end
