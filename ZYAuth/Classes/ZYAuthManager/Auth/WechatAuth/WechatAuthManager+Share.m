//
//  WechatAuthManager+Share.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "WechatAuthManager+Share.h"
#import "WechatShareModel.h"

@implementation WechatAuthManager (Share)


#pragma mark - Protocol

- (void)shareWithType:(ZYAuthManagerType)type shareModel:(id)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{
    if (IsNull(shareModel)) {
        if(failure) failure(@"error : 分享model不能为空 (请初始化一个 WechatShareModel 对象扔进来)", nil);
        return;
    }
    if (![shareModel isKindOfClass:[WechatShareModel class]]) {
        if(failure) failure(@"error : 微信分享model --- WechatShareModel ", nil);
        return;
    }
    
    WechatShareModel *sModel = (WechatShareModel *)shareModel;
    [self sendLinkWithShareModel:sModel success:success failure:failure];
}

- (void)sendLinkWithShareModel:(WechatShareModel *)shareModel success:(ZYShareSuccessBlock)success failure:(ZYAuthFailureBlock)failure{

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareModel.urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = [self cutIfNeededWithText:shareModel.title length:512];
    message.description     = [self cutIfNeededWithText:shareModel.describe length:1024];
    message.mediaObject     = ext;
    message.thumbData       = [self wxThumbDataWithImageData:UIImageJPEGRepresentation(shareModel.previewImage, 0.5)];
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText   = NO;
    req.message = message;
    req.scene   = shareModel.shareScene;
    
    BOOL ret = [WXApi sendReq:req];
    if (!ret) {
        if (failure) failure(@"分享失败", nil);
        return;
    }
    if (success) success(@"分享成功");
}


/**
 *  根据长度截取字符串
 *  汉字算1，数字和英文字母算1
 *
 *  @param text   要截取的字符串
 *  @param length 长度
 *
 *  @return 截取后的字符串
 */
- (NSString *)cutIfNeededWithText:(NSString *)text length:(NSInteger)length {
    if (text.length > length) {
        text = [text substringToIndex:length];
    }
    return text;
}


- (NSData *)wxThumbDataWithImageData:(NSData *)imageData {
    // 微信缩略图最大32K
    
    // 如果图片长宽超过500，则先进行缩放
    UIImage *image = [UIImage imageWithData:imageData];
    if (image.size.height > 500 || image.size.width > 500) {
        
        CGSize newSize;
        if (image.size.height > image.size.width) {
            newSize.height = 500;
            newSize.width = ceil(newSize.height * image.size.width / image.size.height);
        }
        else {
            newSize.width = 500;
            newSize.height = ceil(newSize.width * image.size.height / image.size.width);
        }
        
        image = [self resizeImage:image toSize:newSize];
    }
    
    return [self imageDataWithImageData:UIImageJPEGRepresentation(image, 0.5) maxDataLength:32 * 1024];
}

- (NSData *)imageDataWithImageData:(NSData *)imageData maxDataLength:(NSUInteger)maxDataLength {
    if (imageData.length > maxDataLength) {
        imageData = UIImageJPEGRepresentation([UIImage imageWithData:imageData], 0.1f);
    }
    return imageData;
}

- (UIImage *)resizeImage:(UIImage *)image
                  toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
