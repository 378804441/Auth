//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




typedef NS_ENUM(NSInteger, ZYAuthManagerType){
    ZYAuthManager_wx = 0,       // 微信
    ZYAuthManager_qq,           // QQ
    ZYAuthManager_wb,           // 微博
};

/************************ all key *************************/
static NSString *const QQ_APPID         = @"";
static NSString *const QQ_APPKEY        = @"";

static NSString *const WECHAT_APPID     = @"";
static NSString *const WECHAT_APPSECRET = @"";

static NSString *const SINA_APPKEY      = @"";
static NSString *const SINA_APPSECRET   = @"";
static NSString *const SINA_REDIRECTURI = @"";
static NSString *const SINA_OBJECTID    = @""; // 用于多媒体分享时必填参数，为你的应用bundle id
/**********************************************************/


/************************ 回调block *************************/
typedef void (^ZYAuthSuccessBlock )(BOOL isSuccess, NSString * __nullable errorMsg);
typedef void (^ZYAuthFailureBlock) (BOOL isSuccess, NSString * __nullable errorMsg, NSString * __nullable openid, NSString * __nullable accessToken, NSString * __nullable appID, NSDictionary * __nullable dicProfile);


@interface ZYAuthManager : NSObject 


/** 单例初始化 */
+(ZYAuthManager *)shareInstance;

/**
 进行登录
 type           : 登录类型
 viewController : 依附VC
 success        : 登录成功回调
 failure        : 登录失败
 */
-(void)authLoginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
