//
//  FacebookAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/12.
//

#import "FacebookAuthManager+Share.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface FacebookAuthManager()<FBSDKSharingDelegate>

@end

@interface FacebookAuthManager()

@end

@implementation FacebookAuthManager (Share)


#pragma mark - protocol

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController *)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    if (shareModel.shareType == ZYShareTypeLink) {
        [self shareLinkContentWithWithShareModel:shareModel success:success failure:failure];
    }else if(shareModel.shareType == ZYShareTypeImage){
        [self shareImagesContentWithShareModel:shareModel success:success failure:failure];
    }else if(shareModel.shareType == ZYShareTypeVideo){
        [self shareVideoContentWithWithShareModel:shareModel success:success failure:failure];
    }else{
        if (failure) failure(@"warning : 分享类型不支持", nil);
    }
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel success:success failure:failure];
}



#pragma mark - share public method

/** 分享链接 */
-(void)shareLinkContentWithWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL =  [NSURL URLWithString:shareModel.urlString];
    //    content.hashtag    = [FBSDKHashtag hashtagWithString:@"#MadeWithHackbook"];  // 话题
    content.quote      = shareModel.title;
    [FBSDKShareDialog showFromViewController:self.rootViewController withContent:content delegate:self];
}


/** 分享 video */
-(void)shareVideoContentWithWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    if (IsEmpty(shareModel.facebookVideoPath)) {
        if (failure) failure(@"error : video资源路径为空 - facebookVideoPath 字段", nil);
        return;
    }
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:shareModel.facebookVideoPath] completionBlock:^(NSURL *assetURL, NSError *error) {
        FBSDKShareVideo *video = [FBSDKShareVideo videoWithVideoURL:assetURL];
        FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
        content.video = video;
        [FBSDKShareDialog showFromViewController:self.rootViewController withContent:content delegate:self];
    }];
}


/** 分享图片 (组) */
-(void)shareImagesContentWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    if (IsNull(shareModel.facebookImages)) {
        if (failure) failure(@"error : 分享图片数组为空 - facebookImages 字段", nil);
        return;
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    for (UIImage *image in shareModel.facebookImages) {
        FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImage:image userGenerated:YES];
        [arrM addObject:photo];
    }
    content.photos = arrM.copy;
    [FBSDKShareDialog showFromViewController:self.rootViewController withContent:content delegate:self];
}


#pragma mark - Facebook private method

// 照片大小必须小于 12MB
-(id<FBSDKSharingContent>)shareImageContentWithImage:(UIImage *)image{
    FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImage:image userGenerated:YES];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    return content;
}

-(id<FBSDKSharingContent>)shareImageContentWithUrl:(NSURL *)url{
    FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImageURL:url userGenerated:YES];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    return content;
}

// 视频大小必须小于 50MB。
-(id<FBSDKSharingContent>)shareVideoContentWithUrl:(NSURL *)url{
    FBSDKShareVideo *video = [FBSDKShareVideo videoWithVideoURL:url];
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    return content;
}

-(id<FBSDKSharingContent>)shareVideoContentWithAssest:(PHAsset *)asset{
    FBSDKShareVideo *video = [FBSDKShareVideo videoWithVideoAsset:asset];
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    return content;
}

// 照片大小必须小于 12MB，视频大小必须小于 50MB。
// 用户最多可以分享 1 个视频加 29 张照片，或最多分享 30 张照片。
-(id<FBSDKSharingContent>)shareMediaContentWithVideoUrl:(NSURL *)url images:(NSArray <UIImage *>*)images{
    NSMutableArray *arrM = [NSMutableArray array];
    
    if (url.absoluteString.length >0) {
        FBSDKShareVideo *video = [FBSDKShareVideo videoWithVideoURL:url];
        [arrM addObject:video];
    }
    for (UIImage *image in images) {
        FBSDKSharePhoto *photo = [FBSDKSharePhoto photoWithImage:image userGenerated:YES];
        [arrM addObject:photo];
    }
    FBSDKShareMediaContent *content = [[FBSDKShareMediaContent alloc] init];
    content.media = arrM.copy;
    return content;
}

-(void)shareDialogFromController:(UIViewController *)controller content:(id<FBSDKSharingContent>)content{
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.mode = FBSDKShareDialogModeShareSheet;
    dialog.fromViewController = controller;
    dialog.shareContent = content;
    [dialog show];
    //    [FBSDKShareDialog showFromViewController:controller withContent:content delegate:[ThirdShareService defaultService]];
}


@end
