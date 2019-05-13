//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import <TwitterKit/TwitterKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TwitterAuthManager : NSObject<ZYAuthProtocol>

/** 登录成功block */
@property (nonatomic, copy)   ZYAuthSuccessBlock  successBlock;

/** 分享成功block */
@property (nonatomic, copy)   ZYShareSuccessBlock shareSuccessBlock;

/** 发生错误block */
@property (nonatomic, copy)   ZYAuthFailureBlock  failureBlock;

@end

NS_ASSUME_NONNULL_END
