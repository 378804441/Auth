//
//  ZYShareUtils.h
//  Pods
//
//  Created by 丁巍 on 2019/5/9.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZYShareUtils : NSObject

/**
 *  根据长度截取字符串
 *  汉字算1，数字和英文字母算1
 *
 *  @param text   要截取的字符串
 *  @param length 长度
 *
 *  @return 截取后的字符串
 */
+ (NSString *)cutIfNeededWithText:(NSString *)text length:(NSInteger)length;


/** 压缩图片 */
+ (NSData *)thumbDataWithImageData:(NSData *)imageData;


#pragma mark - 新浪微博

+ (NSString *)sinaTextWithText:(NSString *)tex;
+ (NSData   *)sinaImageData5MWithImageData:(NSData *)imageData;
+ (NSData   *)sinaImageData10MWithImageData:(NSData *)imageData;

@end

NS_ASSUME_NONNULL_END
