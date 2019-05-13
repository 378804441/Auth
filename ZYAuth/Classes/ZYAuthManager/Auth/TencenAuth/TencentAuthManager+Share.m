//
//  TencentAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/9.
//

#import "TencentAuthManager+Share.h"
#import "ZYShareUtils.h"

@implementation TencentAuthManager (Share)


#pragma mark - Protocol

-(void)shareWithModel:(ZYShareModel *)shareModel viewController:(UIViewController * __nullable)viewController success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    self.shareSuccessBlock = success;
    self.failureBlock      = failure;
    if (shareModel.shareScene == ZYShareSceneSession ||
        shareModel.shareScene == ZYShareSceneTimeline) {
        if (shareModel.shareType == ZYShareTypeText || shareModel.shareType == ZYShareTypeLink) {
            [self sendWithShareModel:shareModel success:success failure:failure];
        }else if(shareModel.shareType == ZYShareTypeImage){
            [self sendImageWith:shareModel success:success failure:failure];
        }else{
            if (failure) failure(@"warning : 分享类型不支持", nil);
        }
        return;
    }
    
    if (failure) failure(@"warning : 分享目标不支持", nil);
}

-(void)shareWithModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    [self shareWithModel:shareModel viewController:nil success:success failure:failure];
}


#pragma mark - private method

/** 进行 链接文本 分享 */
- (void)sendWithShareModel:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    
    QQApiNewsObject *news = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareModel.urlString]
                                                     title:[ZYShareUtils cutIfNeededWithText:shareModel.title length:512]
                                               description:[ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024]
                                          previewImageData:[ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:news];
    news.shareDestType      = [self getShareDescType];
    QQApiSendResultCode sent;
    if (shareModel.shareScene == ZYShareSceneTimeline) {
        sent = [QQApiInterface SendReqToQZone:req];
    }else {
        sent = [QQApiInterface sendReq:req];
    }
    
    [self handleSendResult:sent success:success failure:failure];
}


/** 进行图片分享 */
- (void)sendImageWith:(ZYShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
  
    if (IsNull(shareModel.image)) {
        if(failure) failure(@"error : 图片资源不能为空, 请赋值 ZYShareModel : image 字段", nil);
        return;
    }
    
    QQApiImageObject *img = [QQApiImageObject objectWithData:[ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)]
                                            previewImageData:[ZYShareUtils thumbDataWithImageData:UIImageJPEGRepresentation(shareModel.image, 0.5)]
                                                       title:[ZYShareUtils cutIfNeededWithText:shareModel.title length:512]
                                                 description:[ZYShareUtils cutIfNeededWithText:shareModel.describe length:1024]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:img];
    img.shareDestType       = [self getShareDescType];
    QQApiSendResultCode sent;
    if (shareModel.shareScene == ZYShareSceneTimeline) {
        sent = [QQApiInterface SendReqToQZone:req];
    }else {
        sent = [QQApiInterface sendReq:req];
    }
    
    [self handleSendResult:sent success:success failure:failure];
}


/** 结果处理 */
- (void)handleSendResult:(QQApiSendResultCode)sendResult success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    NSString *msg = @"未知错误";
    
    if (sendResult == EQQAPISENDSUCESS) {
        return;
    }
    else if (sendResult == EQQAPIAPPNOTREGISTED) {
        msg = @"App未注册";
    }
    else if (sendResult == EQQAPIMESSAGECONTENTINVALID || sendResult == EQQAPIMESSAGECONTENTNULL || sendResult == EQQAPIMESSAGETYPEINVALID) {
        msg = @"发送参数错误";
    }
    else if (sendResult == EQQAPIQQNOTINSTALLED) {
        msg = @"未安装手Q";
    }
    else if (sendResult == EQQAPIQQNOTSUPPORTAPI) {
        msg = @"API接口不支持";
    }
    else if (sendResult == EQQAPISENDFAILD) {
        msg = @"发送失败";
    }
    
    if(failure) failure(msg, nil);
}


@end
