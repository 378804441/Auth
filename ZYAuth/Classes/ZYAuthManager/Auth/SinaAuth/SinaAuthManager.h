//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import <Weibo_SDK/WeiboSDK.h>


NS_ASSUME_NONNULL_BEGIN

@interface SinaAuthManager : NSObject<ZYAuthProtocol, WeiboSDKDelegate>

@property (nonatomic, strong) NSString *redirectURI;

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

NS_ASSUME_NONNULL_END
