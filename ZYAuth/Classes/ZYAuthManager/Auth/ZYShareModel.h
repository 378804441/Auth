//
//  ZYShareModel.h
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, ZYShareType){
    ZYShareTypeText = 0,     /** 文本类型 */
    ZYShareTypeLink,         /** 链接类型 */
    ZYShareTypeImage,        /** 图片类型 */
    ZYShareTypeVideo,        /** 视频类型 */
    ZYShareTypeMusic,        /** 音乐类型 */
    ZYShareTypeMinprogram    /** 小程序类型 */
};

/** 分享目标 */
typedef NS_ENUM(NSInteger, ZYShareSceneType){
    ZYShareSceneSession          = 0, /** 聊天界面   */
    ZYShareSceneTimeline,             /** 朋友圈    */
    ZYShareSceneFavorite,             /** 收藏      */
    ZYShareSceneSpecifiedSession,     /** 指定联系人 */
    ZYShareSceneMinprogram,           /** 小程序 : 微信独占*/
    
};

/** 微信小程序状态 */
typedef NS_ENUM(NSUInteger, ZYMiniProgramType){
    ZYMiniProgramTypeRelease = 0,       //**< 正式版  */
    ZYMiniProgramTypeTest = 1,          //**< 开发版  */
    ZYMiniProgramTypePreview = 2,       //**< 体验版  */
};


@interface ZYShareModel : NSObject

/** 初始化 指定 分享平台目标 */
- (instancetype)initWithShareScene:(ZYShareSceneType)sceneType;


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



/** 微信小程序username */
@property (nonatomic, copy) NSString *minProgramUserName;

/** 微信小程序类型 */
@property (nonatomic, assign) ZYMiniProgramType miniProgramType;

/** 微信小程序页面的路径 */
@property (nonatomic, copy) NSString *miniProgramPath;



/** 分享目标 */
@property (nonatomic, assign) ZYShareSceneType shareScene;


@end

NS_ASSUME_NONNULL_END
