//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import "iOS_OpenSDK_V3.2.0_lite/TencentOpenAPI.framework/Headers/QQApiInterface.h"
#import "iOS_OpenSDK_V3.2.0_lite/TencentOpenAPI.framework/Headers/TencentOAuth.h"



NS_ASSUME_NONNULL_BEGIN

@interface TencentAuthManager : NSObject<ZYAuthProtocol, QQApiInterfaceDelegate, TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oauth;

/** 登录成功block */
@property (nonatomic, copy)   ZYAuthSuccessBlock  successBlock;

/** 分享成功block */
@property (nonatomic, copy)   ZYShareSuccessBlock shareSuccessBlock;

/** 发生错误block */
@property (nonatomic, copy)   ZYAuthFailureBlock  failureBlock;


/** 获取 授权/分享 方式 */
- (TencentAuthShareType)getAuthShareType;

/** 分享到QQ 或 TIM */
- (ShareDestType)getShareDescType;

@end

NS_ASSUME_NONNULL_END
