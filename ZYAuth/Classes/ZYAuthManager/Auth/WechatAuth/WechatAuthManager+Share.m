//
//  WechatAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "WechatAuthManager+Share.h"
#import "ZYShareUtils.h"

@implementation WechatAuthManager (Share)


#pragma mark - Protocol

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController * __nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    if (shareModel.shareScene == ZYShareSceneSession          ||
        shareModel.shareScene == ZYShareSceneTimeline         ||
        shareModel.shareScene == ZYShareSceneFavorite         ||
        shareModel.shareScene == ZYShareSceneSpecifiedSession) {
        
        if (shareModel.shareType == ZYShareTypeLink) {
            [self sendLinkWithShareModel:shareModel success:success failure:failure];
        }else if(shareModel.shareType == ZYShareTypeImage){
            [self sendImageWithShareModel:shareModel success:success failure:failure];
        }else if(shareModel.shareType == ZYShareTypeVideo){
            [self sendVideoLinkWithShareModel:shareModel success:success failure:failure];
        }else if(shareModel.shareType == ZYShareTypeMusic){
            [self sendMusicLinkWithShareModel:shareModel success:success failure:failure];
        }else{
            if (failure) failure(@"error : 指定分享类型不支持", nil);
        }
        
    }else if(shareModel.shareScene == ZYShareSceneMinprogram){
        [self sendMiniProgramTo:shareModel success:success failure:failure];
    }
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}


#pragma mark - private method

/** 分享链接类型 */
- (void)sendLinkWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl       = shareModel.urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = ext;
    if (!IsNull(shareModel.previewImage)) {
        message.thumbData   = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText   = NO;
    req.message = message;
    req.scene   = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
        return;
    }
}


/** 分享图片 */
- (void)sendImageWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    if (IsNull(shareModel.image)) {
        if(failure) failure(@"error : image 字段不能为空, 请赋值", nil);
        return;
    }
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData      = [ZYShareUtils imageDataWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.thumbData       = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)];
    message.mediaObject     = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;
    req.scene               = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
    }
}

 
/** 分享视频 */
- (void)sendVideoLinkWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl       = shareModel.urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = ext;
    if (!IsNull(shareModel.previewImage)) {
        message.thumbData   = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;
    req.scene               = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
    }
}


/** 分享音乐 */
- (void)sendMusicLinkWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl       = shareModel.urlString;
    ext.musicDataUrl   = shareModel.musicUrl;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = ext;
    if (!IsNull(shareModel.previewImage)) {
        message.thumbData   = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;
    req.scene               = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
    }
}


/** 分享小程序 */
-(void)sendMiniProgramTo:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    WXMiniProgramObject *miniProgramObject = [WXMiniProgramObject object];
    miniProgramObject.webpageUrl           = shareModel.urlString;
    miniProgramObject.userName             = shareModel.minProgramUserName;
    miniProgramObject.path                 = shareModel.miniProgramPath;
    miniProgramObject.miniProgramType      = (WXMiniProgramType)shareModel.miniProgramType;
    if (!IsNull(shareModel.previewImage)) {
        miniProgramObject.hdImageData      = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = miniProgramObject;
    if (!IsNull(shareModel.previewImage)) {
        message.thumbData   = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;
    req.scene               = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
        return;
    }
}

@end
