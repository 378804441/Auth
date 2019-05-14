//
//  TwitterAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/12.
//

#import "TwitterAuthManager+Share.h"

@implementation TwitterAuthManager (Share)


#pragma mark - protocol

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController *)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    if (shareModel.shareType == ZYShareTypeLink) {
        [self shareLinkContentWithWithShareModel:shareModel viewController:viewController success:success failure:failure];
        return;
    }
    if (failure) failure(@"该类型分享不支持", nil);
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    if (failure) failure(@"Twitter 不支持 空VC依附分享", nil);
}


#pragma mark - private method

-(void)shareLinkContentWithWithShareModel:(ZYShareModel *)shareModel viewController:(UIViewController *)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    [[Twitter sharedInstance] logInWithViewController:viewController completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        if (session) {
            TWTRComposer *composer = [[TWTRComposer alloc] init];
            [composer setText:shareModel.title];
            //带图片方法
            if (!IsNull(shareModel.previewImage)) {
                [composer setImage:shareModel.previewImage];
            }
            [composer setURL:[NSURL URLWithString:shareModel.urlString]];
            [composer showFromViewController:viewController completion:^(TWTRComposerResult result){
                if(result == TWTRComposerResultCancelled) {
                    //分享失败
                }else{
                    //分享成功
                }
            }];
            NSLog(@"signed in as %@", [session userName]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    
    return;
    
    
    
    if ([[Twitter sharedInstance].sessionStore existingUserSessions].count >0) {
        TWTRComposer *composer = [[TWTRComposer alloc] init];
        [composer setText:shareModel.title];
        //带图片方法
        if (!IsNull(shareModel.previewImage)) {
            [composer setImage:shareModel.previewImage];
        }
        [composer setURL:[NSURL URLWithString:shareModel.urlString]];
        [composer showFromViewController:viewController completion:^(TWTRComposerResult result){
            if(result == TWTRComposerResultCancelled) {
                //分享失败
            }else{
                //分享成功
            }
        }];
    }else{
        [[Twitter sharedInstance] logInWithViewController:viewController completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
            if (session) {
                TWTRComposer *composer = [[TWTRComposer alloc] init];
                [composer setText:shareModel.title];
                //带图片方法
                if (!IsNull(shareModel.previewImage)) {
                    [composer setImage:shareModel.previewImage];
                }
                [composer setURL:[NSURL URLWithString:shareModel.urlString]];
                [composer showFromViewController:viewController completion:^(TWTRComposerResult result){
                    if(result == TWTRComposerResultCancelled) {
                        //分享失败
                    }else{
                        //分享成功
                    }
                }];
                NSLog(@"signed in as %@", [session userName]);
            } else {
                NSLog(@"error: %@", [error localizedDescription]);
            }
        }];
        
    }
}



@end
