//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import <WechatOpenSDK/WXApi.h>


NS_ASSUME_NONNULL_BEGIN

@interface WechatAuthManager : NSObject<WXApiDelegate, ZYAuthProtocol>

@property (nonatomic, strong) NSString *appID;

@property (nonatomic, strong) NSString *appSecret;

@property (nonatomic, strong) NSString *random;

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

NS_ASSUME_NONNULL_END
