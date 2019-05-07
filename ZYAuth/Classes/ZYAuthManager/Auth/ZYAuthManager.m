//
//  ZYAuthManager.m
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import "ZYAuthManager.h"
#import "ZYThreadSafeDictionary.h"

static NSString *const APP_ID           = @"AppID";
static NSString *const APP_KEY          = @"AppKey";
static NSString *const APP_SECRET       = @"AppSecret";
static NSString *const APP_REDIRECT_URL = @"RedirectUrl";

static NSString *const TENCENT_KEY  = @"QQ";
static NSString *const WECHAT_KEY   = @"Wechat";
static NSString *const SINA_KEY     = @"SinaWeibo";

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
        Class wxClass      = NSClassFromString(@"WXApi");
        Class sinaWbClass  = NSClassFromString(@"WeiboSDK");
        Class tencentClass = NSClassFromString(@"TencentOAuth");
        
        // 读取 key 配置文件
        NSString *dicPath  = [[NSBundle mainBundle] pathForResource:@"ZYSDKConfig.bundle/Keys" ofType:@"plist"];
        NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        
        // 微信
        if (wxClass) {
            NSString *wechatKey    = [[keys objectForKey:WECHAT_KEY] objectForKey:APP_KEY];
            NSString *wechatSecret = [[keys objectForKey:WECHAT_KEY] objectForKey:APP_SECRET];
            if (!IsEmpty(wechatKey) && !IsEmpty(wechatSecret)) {
                id <ZYAuthProtocol>wechatObj = [[NSClassFromString(@"WechatAuthManager") alloc] init];
                [wechatObj registerAuthWithAppId:nil appKey:wechatKey appSecret:wechatSecret redirectURI:nil];
                [self.objcDic setObject:wechatObj forKey:[self mappingKeyWithType:ZYAuthManager_wx]];
            }
        }
        
        // 新浪微博
        if (sinaWbClass) {
            NSString *sinaKey         = [[keys objectForKey:SINA_KEY] objectForKey:APP_KEY];
            NSString *sinaSecret      = [[keys objectForKey:SINA_KEY] objectForKey:APP_SECRET];
            NSString *sinaRedirectURI = [[keys objectForKey:SINA_KEY] objectForKey:APP_REDIRECT_URL];
            if (!IsEmpty(sinaKey) && !IsEmpty(sinaSecret)) {
                id <ZYAuthProtocol>sinaObj = [[NSClassFromString(@"SinaAuthManager") alloc] init];;
                [sinaObj registerAuthWithAppId:nil appKey:sinaKey appSecret:sinaSecret redirectURI:sinaRedirectURI];
                [self.objcDic setObject:sinaObj forKey:[self mappingKeyWithType:ZYAuthManager_wb]];
            }
        }
        
        // 腾讯旗下 (QQ, TIM)
        if (tencentClass) {
            NSString *tencentID  = [[keys objectForKey:TENCENT_KEY] objectForKey:APP_ID];
            NSString *tencentKey = [[keys objectForKey:TENCENT_KEY] objectForKey:APP_KEY];
            if (!IsEmpty(tencentID)) {
                id <ZYAuthProtocol>sinaObj = [[NSClassFromString(@"TencenAuthManager") alloc] init];;
                [sinaObj registerAuthWithAppId:tencentID appKey:tencentKey appSecret:nil redirectURI:nil];
                [self.objcDic setObject:sinaObj forKey:[self mappingKeyWithType:ZYAuthManager_qq]];
            }
        }
        
    }
    return self;
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
    if (![self checkObjcDicWithType:type]) return;
    
    // 初始化完成的SDK Manager对象
    id <ZYAuthProtocol>sdkManagerObjc = [self.objcDic objectForKey:[self mappingKeyWithType:type]];
    
    // 向下转发
    [sdkManagerObjc loginWithType:type viewController:viewController success:success failure:failure];
}


#pragma mark - private method

/** 检查需要的类型 是否初始化成功 */
-(BOOL)checkObjcDicWithType:(ZYAuthManagerType)type{
    
    if ([self.objcDic objectForKey:[self mappingKeyWithType:type]]) {
        return YES;
    }
    
    NSLog(@"warning : 索要的类型并没有初始化成功");
    return NO;
}

/** 映射字符串 */
-(NSString *)mappingKeyWithType:(ZYAuthManagerType)type{
    return [NSString stringWithFormat:@"zy_%ld", type];
}


#pragma mark - 懒加载

-(ZYThreadSafeDictionary *)objcDic{
    if (!_objcDic) {
        _objcDic = [ZYThreadSafeDictionary dictionary];
    }
    return _objcDic;
}


@end
