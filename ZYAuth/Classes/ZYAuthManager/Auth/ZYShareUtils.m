//
//  ZYShareUtils.m
//  Pods
//
//  Created by 丁巍 on 2019/5/9.
//

#import "ZYShareUtils.h"

@implementation ZYShareUtils


/**
 *  根据长度截取字符串
 *  汉字算1，数字和英文字母算1
 *
 *  @param text   要截取的字符串
 *  @param length 长度
 *
 *  @return 截取后的字符串
 */
+ (NSString *)cutIfNeededWithText:(NSString *)text length:(NSInteger)length {
    if (text.length > length) {
        text = [text substringToIndex:length];
    }
    return text;
}


+ (NSData *)thumbDataWithImageData:(NSData *)imageData {
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



+ (NSData *)imageDataWithImageData:(NSData *)imageData maxDataLength:(NSUInteger)maxDataLength {
    if (imageData.length > maxDataLength) {
        imageData = UIImageJPEGRepresentation([UIImage imageWithData:imageData], 0.1f);
    }
    return imageData;
}



+ (UIImage *)resizeImage:(UIImage *)image
                  toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


#pragma mark - 新浪微博

+ (NSString *)sinaTextWithText:(NSString *)text {
    return [self cutIfNeededWithText:text length:140];
}

+ (NSData *)sinaImageData5MWithImageData:(NSData *)imageData {
    // 如果是gif，则不能压缩，直接返回
    if ([[self xc_contentTypeForImageData:imageData] isEqualToString:@"image/gif"]) {
        return imageData;
    }else {
        // sina分享图片最大5M
        return [self imageDataWithImageData:imageData maxDataLength:5 * 1024 * 1024];
    }
}

+ (NSData *)sinaImageData10MWithImageData:(NSData *)imageData {
    // 如果是gif，则不能压缩，直接返回
    if ([[self xc_contentTypeForImageData:imageData] isEqualToString:@"image/gif"]) {
        return imageData;
    }
    else {
        // sina分享图片最大10M
        return [[self class] imageDataWithImageData:imageData maxDataLength:10 * 1024 * 1024];
    }
}


+ (NSString *)xc_contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}



@end
