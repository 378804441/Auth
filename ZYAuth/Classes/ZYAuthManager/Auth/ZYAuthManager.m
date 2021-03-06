//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "ZYAuthManager.h"
#import "ZYThreadSafeDictionary.h"
#import "ZYAppdelegateHook.h"

static NSString *const APP_ID           = @"AppID";
static NSString *const APP_KEY          = @"AppKey";
static NSString *const APP_SECRET       = @"AppSecret";
static NSString *const APP_REDIRECT_URL = @"RedirectUrl";

static NSString *const TENCENT_KEY  = @"QQ";
static NSString *const WECHAT_KEY   = @"Wechat";
static NSString *const SINA_KEY     = @"SinaWeibo";
static NSString *const GOOGLE_KEY   = @"Google";
static NSString *const TWITTER_KEY  = @"Twitter";


@interface ZYAuthManager()

/** 注册成功生成的对象 dic(线程安全) */
@property (nonatomic, strong) ZYThreadSafeDictionary *objcDic;

@end

@implementation ZYAuthManager


#pragma mark - init

+(ZYAuthManager *)shareInstance {
    static ZYAuthManager *instance = nil;
    static dispatch_once_t obj;
    dispatch_once(&obj, ^{
        instance = [[ZYAuthManager alloc] init];
    });
    return instance;
}

/** 初始化时候尝试创建各个平台对象, 排查是否引入进来 */
- (instancetype)init{
    self = [super init];
    if (self) {
        
        [ZYAppdelegateHook registerAppDelegateClass:[self class]];
        
        self.objcDic             = [ZYThreadSafeDictionary dictionary];
        Class wxClass            = NSClassFromString(@"WXApi");
        Class sinaWbClass        = NSClassFromString(@"WeiboSDK");
        Class tencentClass       = NSClassFromString(@"TencentOAuth");
        Class googleSigninClass  = NSClassFromString(@"GIDSignIn");
        Class facebookClass      = NSClassFromString(@"FBSDKApplicationDelegate");
        Class twitterSigninClass = NSClassFromString(@"Twitter");
        
        // 读取 key 配置文件
        NSString *dicPath  = [[NSBundle mainBundle] pathForResource:@"ZYSDKConfig.bundle/Keys" ofType:@"plist"];
        NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        
        // 微信
        if (wxClass) {
            NSString *wechatId            = [[keys objectForKey:WECHAT_KEY] objectForKey:APP_ID];
            NSString *wechatSecret        = [[keys objectForKey:WECHAT_KEY] objectForKey:APP_SECRET];
            ZYAuthManagerType managerType = ZYAuthManagerWeChat;
            if (!IsEmpty(wechatId) && !IsEmpty(wechatSecret)) {
                // 初始化
                id <ZYAuthProtocol>wechatObj = [[NSClassFromString(@"WechatAuthManager") alloc] init];
                [wechatObj registerAuthWithAppId:wechatId appKey:nil appSecret:wechatSecret redirectURI:nil];
                [self.objcDic setObject:wechatObj forKey:[self mappingKeyWithType:managerType]];
            }
        }
        
        // 新浪微博
        if (sinaWbClass) {
            NSString *sinaKey             = [[keys objectForKey:SINA_KEY] objectForKey:APP_KEY];
            NSString *sinaSecret          = [[keys objectForKey:SINA_KEY] objectForKey:APP_SECRET];
            NSString *sinaRedirectURI     = [[keys objectForKey:SINA_KEY] objectForKey:APP_REDIRECT_URL];
            ZYAuthManagerType managerType = ZYAuthManagerSinaWeibo;
            if (!IsEmpty(sinaKey) && !IsEmpty(sinaSecret)) {
                id <ZYAuthProtocol>sinaObj = [[NSClassFromString(@"SinaAuthManager") alloc] init];;
                [sinaObj registerAuthWithAppId:nil appKey:sinaKey appSecret:sinaSecret redirectURI:sinaRedirectURI];
                [self.objcDic setObject:sinaObj forKey:[self mappingKeyWithType:managerType]];
            }
        }
        
        // 腾讯旗下 (QQ, TIM)
        if (tencentClass) {
            NSString *tencentID           = [[keys objectForKey:TENCENT_KEY] objectForKey:APP_ID];
            NSString *tencentKey          = [[keys objectForKey:TENCENT_KEY] objectForKey:APP_KEY];
            ZYAuthManagerType managerType = ZYAuthManagerTencent;
            if (!IsEmpty(tencentID)) {
                id <ZYAuthProtocol>tencentObj = [[NSClassFromString(@"TencentAuthManager") alloc] init];;
                [tencentObj registerAuthWithAppId:tencentID appKey:tencentKey appSecret:nil redirectURI:nil];
                [self.objcDic setObject:tencentObj forKey:[self mappingKeyWithType:managerType]];
            }
        }
        
        // google
        if (googleSigninClass) {
            NSString *googleID            = [[keys objectForKey:GOOGLE_KEY] objectForKey:APP_ID];
            ZYAuthManagerType managerType = ZYAuthManagerGoogle;
            if (!IsEmpty(googleID)) {
                id <ZYAuthProtocol>googleObj = [[NSClassFromString(@"GoogleAuthManager") alloc] init];;
                [googleObj registerAuthWithAppId:googleID appKey:nil appSecret:nil redirectURI:nil];
                [self.objcDic setObject:googleObj forKey:[self mappingKeyWithType:managerType]];
            }
        }
        
        // Twitter
        if (twitterSigninClass) {
            NSString *twitterKey          = [[keys objectForKey:TWITTER_KEY] objectForKey:APP_KEY];
            NSString *twitterSecret       = [[keys objectForKey:TWITTER_KEY] objectForKey:APP_SECRET];
            ZYAuthManagerType managerType = ZYAuthManagerTwitter;
            if (!IsEmpty(twitterKey) && !IsEmpty(twitterSecret)) {
                id <ZYAuthProtocol>twitterObj = [[NSClassFromString(@"TwitterAuthManager") alloc] init];;
                [twitterObj registerAuthWithAppId:nil appKey:twitterKey appSecret:twitterSecret redirectURI:nil];
                [self.objcDic setObject:twitterObj forKey:[self mappingKeyWithType:managerType]];
            }
        }
        
        // Facebook
        if (facebookClass) {
            ZYAuthManagerType managerType  = ZYAuthManagerFacebook;
            
            id <ZYAuthProtocol>facebookObj = [[NSClassFromString(@"FacebookAuthManager") alloc] init];
            [facebookObj registerAuthWithAppId:nil appKey:nil appSecret:nil redirectURI:nil];
            [self.objcDic setObject:facebookObj forKey:[self mappingKeyWithType:managerType]];
        }
        
        // whatsapp
        {
            ZYAuthManagerType managerType  = ZYAuthManagerWhatsapp;
            id <ZYAuthProtocol>whatsappObj = [[NSClassFromString(@"WhatsappAuthManager") alloc] init];
            [whatsappObj registerAuthWithAppId:nil appKey:nil appSecret:nil redirectURI:nil];
            [self.objcDic setObject:whatsappObj forKey:[self mappingKeyWithType:managerType]];
        }
    }
    return self;
}

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application
                      openURL:(NSURL *)url
            sourceApplication:(NSString *)sourceApplication
                   annotation:(id)annotation{
    BOOL openB = NO;
    for (NSString *objcKey in self.objcDic.allKeys) {
        id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:objcKey];
        openB = [sdkManagerObjc openURLWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    return openB;
}
    
/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL openB = NO;
    for (NSString *objcKey in self.objcDic.allKeys) {
        id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:objcKey];
        openB = [sdkManagerObjc openURLWithApplication:application handleOpenURL:url];
    }
    return openB;
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
    
    // 检查是否可以继续往下走
    if (![self checkLoginObjcWithType:type failure:failure]) return;
    
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:type]];
    
    // 向下转发
    [sdkManagerObjc loginWithType:type viewController:viewController success:success failure:failure];
}

/**
 分享
 shareModel     : 分享模型
 viewController : 依附VC (可为空)
 success        : 成功block
 failure        : 失败block
 */
- (void)shareWithShareModel:(ZYShareModel *)shareModel viewController:(UIViewController * _Nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
   
    if (IsNull(shareModel)) {
        if(failure) failure(@"error : 分享model不能为空 (请初始化一个 ZYShareModel 对象扔进来)", nil);
        return;
    }
    if (![shareModel isKindOfClass:[ZYShareModel class]]) {
        if(failure) failure(@"error : 分享model类型 --- ZYShareModel ", nil);
        return;
    }
    
    if (![self checkLoginObjcWithType:shareModel.authType failure:failure]) return;
    
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:shareModel.authType]];
    
    if (IsNull(viewController)) {
        [sdkManagerObjc shareWithModel:shareModel success:success failure:failure];
    }else if(!IsNull(viewController)){
        [sdkManagerObjc shareWithModel:shareModel viewController:viewController success:success failure:failure];
    }
    
}

/** 检测app是否安装 */
-(BOOL)checkAppInstalledWithType:(ZYAuthManagerType)type{
    // 检查是否可以继续往下走
    if (![self checkLoginObjcWithType:type failure:nil]) {
        NSLog(@"error : 索要的类型并没有初始化成功");
        return NO;
    }
    
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:type]];
    
    if(![sdkManagerObjc respondsToSelector:@selector(checkAppInstalled)]){
        NSLog(@"warning : 当前类型 可能不支持检测是否安装功能");
        return NO;
    }
    return [sdkManagerObjc checkAppInstalled];
}

/** 检查要打开的app版本是否支持 openApi */
-(BOOL)checkAppSupportApiWithType:(ZYAuthManagerType)type{
    // 检查是否可以继续往下走
    if (![self checkLoginObjcWithType:type failure:nil]) {
        NSLog(@"error : 索要的类型并没有初始化成功");
        return NO;
    }
    
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:type]];
    
    if(![sdkManagerObjc respondsToSelector:@selector(checkAppSupportApi)]){
        NSLog(@"warning : 当前类型 可能不支持检测 是否支持openApi功能");
        return NO;
    }
    return [sdkManagerObjc checkAppSupportApi];
}


#pragma mark - private method

/** 检查登录类型对象 是否初始化成功 */
-(BOOL)checkLoginObjcWithType:(NSInteger)type failure:(ZYAuthFailureBlock)failure{
    
    if ([self.objcDic objectForKey:[self mappingKeyWithType:type]]) {
        return YES;
    }
    
    if (failure) failure(@"error : 索要的类型并没有初始化成功", nil);
    return NO;
}

/**
 映射字符串
 type  : 类型
 class : base->basemanager  login->登录模块  share->分享模块
 */
-(NSString *)mappingKeyWithType:(NSInteger)type{
    return [NSString stringWithFormat:@"zy_%ld", (long)type];
}


#pragma mark - test

-(void)logOutGoogle{
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:ZYAuthManagerGoogle]];
    [sdkManagerObjc logOut];
}


@end
