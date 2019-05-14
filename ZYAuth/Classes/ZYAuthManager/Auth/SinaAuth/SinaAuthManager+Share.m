//
//  SinaAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/9.
//

#import "SinaAuthManager+Share.h"
#import "ZYShareUtils.h"

@implementation SinaAuthManager (Share)


#pragma mark - Protocol

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController *)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    
    if (shareModel.shareType == ZYShareTypeText) {
        [self sendTextWithShareModel:shareModel success:success failure:failure];
    }else if(shareModel.shareType == ZYShareTypeLink){
        [self sendLinkWithShareModel:shareModel success:success failure:failure];
    }else if(shareModel.shareType == ZYShareTypeImage){
        [self sendImageWithShareModel:shareModel success:success failure:failure];
    }else if(shareModel.shareType == ZYShareTypeTextAndImage){
        [self sendTextAndImgWithShareModel:shareModel success:success failure:failure];
    }else{
        if (failure) failure(@"error : 指定分享类型不支持", nil);
    }
    
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}


#pragma mark - private Method

/**
 *  分享图文到新浪微博，需要授权
 *  如果授权过，则不再跳转到新浪微博，直接分享，因此没有修改内容的机会
 *  分享过程时间可能比较长，最好在finish之前有loading界面
 */
- (void)sendTextAndImgNeedAuthWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
   
    WS(weakSelf);
    self.shareNeedAuthBlock = ^{
        SS(strongSelf);
        WBMessageObject * messageObj = [WBMessageObject message];
        messageObj.text              = shareModel.text;
        
        if (!IsNull(shareModel.image)) {
            WBImageObject *image = [WBImageObject object];
            image.imageData = [ZYShareUtils sinaImageData5MWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)];
            messageObj.imageObject       = image;
        }
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = strongSelf.redirectURI;
        authRequest.scope = @"";
        
        WBSendMessageToWeiboRequest * messageRequest = [WBSendMessageToWeiboRequest requestWithMessage:messageObj
                                                                                              authInfo:authRequest
                                                                                          access_token:nil];
        
        BOOL ret = [WeiboSDK sendRequest:messageRequest];
        if (!ret) {
            if (failure) failure(@"分享失败", nil);
        };
    };
    
    // 先执行一次分享，如果失败是由于没有授权导致的，则进行授权，之后再次分享
    self.shareNeedAuthBlock();
}


/** 分享文本 */
- (void)sendTextWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    WBMessageObject *message = [WBMessageObject message];
    message.text = [ZYShareUtils sinaTextWithText:shareModel.text];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = self.redirectURI;
    authRequest.scope = @"";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:nil];
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
        if(failure) failure(@"分享失败", nil);
    }
}


/** 分享图片 */
- (void)sendImageWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    if (IsNull(shareModel.image)) {
        if (failure) failure (@"error : 图片资源为空。请赋值 image 字段", nil);
        return;
    }
    
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image     = [WBImageObject object];
    image.imageData          = [ZYShareUtils sinaImageData10MWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)];
    message.imageObject      = image;
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = self.redirectURI;
    authRequest.scope = @"";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:nil];
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
        if(failure) failure(@"分享失败", nil);
    }
}


/**
 *  分享图文到新浪微博，无需授权
 *  跳转到新浪微博后还有修改内容的机会
 */
- (void)sendTextAndImgWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    //用于当分享没有授权时使用，防止在deleget中回调走第三方登录的授权
    self.isShareWithAuth = YES;
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = [ZYShareUtils sinaTextWithText:shareModel.text];
    
    if (!IsNull(shareModel.image)) {
        WBImageObject *image = [WBImageObject object];
        image.imageData      = [ZYShareUtils sinaImageData10MWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)];
        message.imageObject  = image;
        
    }
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = self.redirectURI;
    authRequest.scope = @"";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:nil];
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
        if(failure) failure(@"分享失败", nil);
    }
    
}


/**
 *  分享文字和web资源到新浪微博，无需授权
 *  跳转到新浪微博后还有修改内容的机会
 */
- (void)sendLinkWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    //用于当分享没有授权时使用，防止在deleget中回调走第三方登录的授权
    self.isShareWithAuth = YES;
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = [ZYShareUtils sinaTextWithText:shareModel.text];
    WBWebpageObject *webpage  = [WBWebpageObject object];
    webpage.objectID          = shareModel.urlString;
    webpage.title             = shareModel.title;
    webpage.description       = shareModel.describe;
    if (!IsNull(shareModel.previewImage)) {
        webpage.thumbnailData = [ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    }
    webpage.webpageUrl       = shareModel.urlString;
    message.mediaObject      = webpage;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = self.redirectURI;
    authRequest.scope = @"";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:nil];
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret) {
        if(self.failureBlock) self.failureBlock(@"分享失败", nil);
    }
    
}

@end
