//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZYAuthProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/************************ all key *************************/
static NSString *const QQ_APPID         = @"1103537147";
static NSString *const QQ_APPKEY        = @"o4vzBP6z5Ip4FUbK";
/**********************************************************/


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
