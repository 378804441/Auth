//
//  GoogleAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/12.
//

#import "GoogleAuthManager+Share.h"

@implementation GoogleAuthManager (Share)

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController *)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    if (failure) failure(@"google 不提供分享服务", nil);
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}

@end
