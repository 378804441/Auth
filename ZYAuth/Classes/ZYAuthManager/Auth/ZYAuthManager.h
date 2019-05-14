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


@interface ZYAuthManager : NSObject 


#pragma mark - 初始化方法

/** 单例初始化 */
+(ZYAuthManager *)shareInstance;

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application
                      openURL:(NSURL *)url
            sourceApplication:(NSString *)sourceApplication
                   annotation:(id)annotation;

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url;



#pragma mark - public method

/**
 进行登录
 type           : 登录类型
 viewController : 依附VC
 success        : 登录成功回调
 failure        : 登录失败
 */
-(void)authLoginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;

/**
 分享
 shareModel     : 分享模型
 viewController : 依附VC (可为空)
 success        : 成功block
 failure        : 失败block
 */
- (void)shareWithShareModel:(ZYShareModel *)shareModel viewController:(UIViewController * _Nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;


/** 检测app是否安装 */
-(BOOL)checkAppInstalledWithType:(ZYAuthManagerType)type;


/** 检查要打开的app版本是否支持 openApi */
-(BOOL)checkAppSupportApiWithType:(ZYAuthManagerType)type;


#pragma mark - test code

-(void)logOutGoogle;


@end

NS_ASSUME_NONNULL_END
