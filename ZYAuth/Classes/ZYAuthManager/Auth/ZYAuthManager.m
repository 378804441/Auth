//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "ZYAuthManager.h"
#import "ZYAuthProtocol.h"

@interface ZYAuthManager()

@property (nonatomic, strong) ZYAuthSuccessBlock successBlock;
@property (nonatomic, strong) ZYAuthFailureBlock failureBlock;

@end

@implementation ZYAuthManager


#pragma mark - init

/** 尝试创建各个平台对象, 排查是否引入进来 */
+(void)initialize{
    
    Class wxClass = NSClassFromString(@"WXApi");
    Class sinaWbClass = NSClassFromString(@"WeiboSDK");
    
    if (wxClass) {
        id <ZYAuthProtocol>wechatObj = [[NSClassFromString(@"WechatAuthManager") alloc] init];
        [wechatObj registerAuthWithAppId:WECHAT_APPID appsecret:@""];
    }
    
    if (sinaWbClass) {
        id <ZYAuthProtocol>sinaObj = [[NSClassFromString(@"SinaAuthManager") alloc] init];;
        [sinaObj registerAuthWithAppId:SINA_APPKEY appsecret:@""];
    }
    
}

+(ZYAuthManager *)shareInstance {
    static ZYAuthManager *instance = nil;
    static dispatch_once_t obj;
    dispatch_once(&obj, ^{
        instance = [[self class] new];
    });
    return instance;
}


#pragma mark - public method

/**
 进行登录
 type           : 登录类型
 viewController : 依附VC
 success        : 登录成功回调
 failure        : 登录失败
 */
-(void)authLoginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.successBlock = success;
    self.failureBlock = failure;
    switch (type) {
        case ZYAuthManager_wx:
            break;
        case ZYAuthManager_qq:
            
            break;
        case ZYAuthManager_wb:
            break;
    }
}


#pragma mark - private method

+ (BOOL)handleOpenURL:(NSURL *)url {
//    if ([XCSocialWeChatHelper handleOpenURL:url]) {
//        return YES;
//    } else if ([XCSocialQQHelper handleOpenURL:url]) {
//        return YES;
//    } else if ([XCSocialSinaWeiboHelper handleOpenURL:url]) {
//        return YES;
//    }
    
    return YES;
}



@end
