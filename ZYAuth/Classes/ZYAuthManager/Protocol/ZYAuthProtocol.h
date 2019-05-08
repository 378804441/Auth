//
//  ZYAuthProtocol.h
//  FBSnapshotTestCase
//
//  Created by 丁巍 on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 空值判断相关
#define IsEmpty(str)            (str == nil || ![str respondsToSelector:@selector(isEqualToString:)] || [str isEqualToString:@""])
#define IsNull(obj)             (obj == nil || [obj isEqual:[NSNull null]])
#define IsArray(obj)            (obj && [obj isKindOfClass:[NSArray class]] && [obj count] > 0)
#define IsDictionary(obj)       (obj && [obj isKindOfClass:[NSDictionary class]] && [obj.allKeys count] > 0)


typedef NS_ENUM(NSInteger, ZYAuthManagerType){
    ZYAuthManagerWeChat = 0,       // 微信
    ZYAuthManagerTencent,          // QQ
    ZYAuthManagerSinaWeibo,        // 微博
    ZYAuthManagerGoogle,           // Google
    ZYAuthManagerFacebook,         // Facebook
    ZYAuthManagerTwitter,          // Twitter
};

@protocol ZYAuthProtocol <NSObject>
@optional

/** 回调block **/
typedef void (^ZYAuthSuccessBlock )(BOOL isSuccess, NSString * __nullable errorMsg);
typedef void (^ZYAuthFailureBlock) (BOOL isSuccess, NSString * __nullable errorMsg, NSString * __nullable openid, NSString * __nullable accessToken, NSString * __nullable appID, NSDictionary * __nullable dicProfile);


/**
 进行注册
 appId       : 对应平台 app id
 appKey      : 对应平台 app key
 appSecret   : 对应平台 secret
 redirectURI : 重定向URL
 */
- (void)registerAuthWithAppId:(NSString * __nullable)appId appKey:(NSString * __nullable)appKey  appSecret:(NSString * __nullable)appSecret redirectURI:(NSString * __nullable)redirectURI;

/**
 Facebook SDK跟别的有区别, 所以需要单独注册
 */
-(void)registerFacebookWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/** openURL facebook */
-(BOOL)openURLFacebookWithApplication:(UIApplication *)application
                              openURL:(NSURL *)url
                    sourceApplication:(NSString *)sourceApplication
                           annotation:(id)annotation;

/**
 登录
 type    : 登录类型
 success : 成功block
 failure : 失败block
 */
- (void)loginWithType:(ZYAuthManagerType)type success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;


/**
 登录 - 需要有模态窗口的
 type           : 登录类型
 viewController : 需要模态的依附ViewController
 success        : 成功block
 failure        : 失败block
 */
- (void)loginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;


- (void)logOut;

@end

NS_ASSUME_NONNULL_END
