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
        [self sendLinkWithShareModel:shareModel success:success failure:failure];
        
    }else if(shareModel.shareScene == ZYShareSceneMinprogram){
        [self sendMiniProgramTo:shareModel success:success failure:failure];
    }
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}


#pragma mark - private method

- (void)sendLinkWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareModel.urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = ext;
    message.thumbData       = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    
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


-(void)sendMiniProgramTo:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    WXMiniProgramObject *miniProgramObject = [WXMiniProgramObject object];
    miniProgramObject.webpageUrl           = shareModel.urlString;
    miniProgramObject.userName             = shareModel.minProgramUserName;
    miniProgramObject.path                 = shareModel.miniProgramPath;
    miniProgramObject.miniProgramType      = (WXMiniProgramType)shareModel.miniProgramType;
    miniProgramObject.hdImageData          = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [ZYShareUtils cutIfNeededWithText:shareModel.title length:512];
    message.description     = [ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = miniProgramObject;
    message.thumbData       = nil;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
        return;
    }
}

@end
