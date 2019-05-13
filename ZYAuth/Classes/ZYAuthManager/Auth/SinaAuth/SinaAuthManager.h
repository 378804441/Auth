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

@property (nonatomic, copy)   ZYAuthSuccessBlock  successBlock;

@property (nonatomic, copy)   ZYShareSuccessBlock shareSuccessBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock  failureBlock;

/** 解决微博授权问题 block */
@property (nonatomic, copy)   void (^shareNeedAuthBlock)(void);

/** 如果是第三方登录设置为NO，如果是需要授权的分享设置为YES
    需要授权的分享在分享时如果没有预先授权，则需要先进行授权，授权成功后再进行分享
    授权成功后通过isShareWithAuth来判断是第三方登录还是分享  */
@property (nonatomic, assign) BOOL isShareWithAuth;

/** 如果已经授权之后分享还失败则不再重新授权 */
@property (nonatomic, assign) BOOL isAlreadyAuth;

@end

NS_ASSUME_NONNULL_END
