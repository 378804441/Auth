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

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

NS_ASSUME_NONNULL_END
