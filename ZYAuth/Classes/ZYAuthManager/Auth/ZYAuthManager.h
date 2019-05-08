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


/** 单例初始化 */
+(ZYAuthManager *)shareInstance;

/** openURL */
-(BOOL)openURLWithApplication:(UIApplication *)application
                      openURL:(NSURL *)url
            sourceApplication:(NSString *)sourceApplication
                   annotation:(id)annotation;

/** handleOpenURL */
- (BOOL)openURLWithApplication:(UIApplication *)application handleOpenURL:(NSURL *)url;


/**
 进行登录
 type           : 登录类型
 viewController : 依附VC
 success        : 登录成功回调
 failure        : 登录失败
 */
-(void)authLoginWithType:(ZYAuthManagerType)type viewController:(UIViewController *)viewController success:(ZYAuthSuccessBlock)success failure:(ZYAuthFailureBlock)failure;

-(void)logOutGoogle;

@end

NS_ASSUME_NONNULL_END
