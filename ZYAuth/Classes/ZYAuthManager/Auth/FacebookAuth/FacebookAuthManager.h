//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FacebookAuthManager : NSObject<ZYAuthProtocol>

@property (nonatomic, strong) UIViewController *rootViewController;

/** 登录成功block */
@property (nonatomic, copy)   ZYAuthSuccessBlock  successBlock;

/** 分享成功block */
@property (nonatomic, copy)   ZYShareSuccessBlock shareSuccessBlock;

/** 发生错误block */
@property (nonatomic, copy)   ZYAuthFailureBlock  failureBlock;


#pragma mark - public share method

///** 分享链接 */
//-(void)shareLinkContentWithWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;
//
///** 分享 video */
//-(void)shareVideoContentWithWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;
//
///** 分享图片 (组) */
//-(void)shareImagesContentWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure;
//
//-(void)shareLinkContentWithLinkToMessager:(NSURL *)url fromController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
