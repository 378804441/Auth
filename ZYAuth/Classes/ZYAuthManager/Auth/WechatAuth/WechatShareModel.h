//
//  WechatShareModel.h
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 分享目标 */
typedef NS_ENUM(NSInteger, WechatShareScene){
    WechatSceneSession          = 0,   /** 聊天界面   */
    WechatSceneTimeline         = 1,   /** 朋友圈    */
    WechatSceneFavorite         = 2,   /** 收藏      */
    WechatSceneSpecifiedSession = 3,   /** 指定联系人 */
};

@interface WechatShareModel : NSObject

/**
 分享文本(例如分享纯文本就传这个)
 */
@property (nonatomic, copy) NSString *text;

/**
 分享内容标题
 */
@property (nonatomic, copy) NSString *title;

/**
 分享内容描述
 */
@property (nonatomic, copy) NSString *describe;

/**
 分享目标图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 分享预览图(微信中不得超过32K)
 */
@property (nonatomic, strong) UIImage *previewImage;

/**
 分享目标链接(字符串,统一下就不提供NSURL类型的了)
 */
@property (nonatomic, copy) NSString *urlString;

/**
 分享目标链接的预览图链接地址(字符串,统一下就不提供NSURL类型的了)
 */
@property (nonatomic, copy) NSString *previewUrlString;

/** 分享目标 */
@property (nonatomic, assign) WechatShareScene shareScene;


@end

NS_ASSUME_NONNULL_END
