//
//  ZYAuthProtocol.h
//  FBSnapshotTestCase
//
//  Created by 丁巍 on 2019/5/6.
//

#import <Foundation/Foundation.h>
#import "ZYShareModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 空值判断相关
#define IsEmpty(str)            (str == nil || ![str respondsToSelector:@selector(isEqualToString:)] || [str isEqualToString:@""])
#define IsNull(obj)             (obj == nil || [obj isEqual:[NSNull null]])
#define IsArray(obj)            (obj && [obj isKindOfClass:[NSArray class]] && [obj count] > 0)
#define IsDictionary(obj)       (obj && [obj isKindOfClass:[NSDictionary class]] && [obj.allKeys count] > 0)

#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self
#define SS(strongSelf)  __strong __typeof__(weakSelf) strongSelf = weakSelf

typedef NS_ENUM(NSInteger, ZYAuthManagerType){
    ZYAuthManagerWeChat    = 0,    // 微信
    ZYAuthManagerTencent   = 1,    // QQ
    ZYAuthManagerSinaWeibo = 2,    // 微博
    ZYAuthManagerGoogle    = 3,    // Google
    ZYAuthManagerFacebook  = 4,    // Facebook
    ZYAuthManagerTwitter   = 5,    // Twitter
    ZYAuthManagerWhatsapp  = 6,    // Whatsapp
};

@protocol ZYAuthProtocol <NSObject>
@optional

/** 回调block **/
typedef void (^ZYAuthSuccessBlock)  (NSDictionary * __nullable dataDic);
typedef void (^ZYAuthFailureBlock)  (NSString * __nullable errorMsg, NSError *__nullable error);
typedef void (^ZYShareSuccessBlock) (NSString * __nullable succeMsg);

/**
 进行注册
 appId       : 对应平台 app id
 appKey      : 对应平台 app key
 appSecret   : 对应平台 secret
 redirectURI : 重定向URL
 */
- (void)registerAuthWithAppId:(NSString * __nullable)appId appKey:(NSString * __nullable)appKey  appSecret:(NSString * __nullable)appSecret redirectURI:(NSString * __nullable)redirectURI;

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url;


/**
 登录
 type    : 登录类型
 success : 成功block
 failure : 失败block
 */
- (void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;

/** 带依附vc的 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *__nullable)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;


/**
 分享
 type       : 登录类型
 shareModel : 分享模型
 success    : 成功block
 failure    : 失败block
 */
-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;

/** 带依附vc的 */
-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController *__nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;


/** 检测APP是否安装 */
- (BOOL)checkAppInstalled;

/** 检查要打开的app版本是否支持 openApi */
- (BOOL)checkAppSupportApi;



- (void)logOut;

@end

NS_ASSUME_NONNULL_END
