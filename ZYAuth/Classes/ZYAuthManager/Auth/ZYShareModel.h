//
//  ZYShareModel.h
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/** model 类型 */
typedef NS_ENUM(NSInteger, ZYShareType){
    ZYShareTypeLink       = 0,   /** 链接类型 */
    ZYShareTypeImage      = 1,   /** 图片类型 */
    ZYShareTypeVideo      = 2,   /** 视频类型 */
    ZYShareTypeMusic      = 3,   /** 音乐类型 */
    ZYShareTypeMinprogram = 4    /** 小程序类型 */
};

/** 授权平台类型 */
typedef NS_ENUM(NSInteger, ZYAuthType){
    ZYAuthTypeWeChat    = 0,    // 微信
    ZYAuthTypeTencent   = 1,    // QQ
    ZYAuthTypeSinaWeibo = 2,    // 微博
    ZYAuthTypeGoogle    = 3,    // Google
    ZYAuthTypeFacebook  = 4,    // Facebook
    ZYAuthTypeTwitter   = 5,    // Twitter
    ZYAuthTypeWhatsapp  = 6,    // Whatsapp
};

/** 微信小程序状态 */
typedef NS_ENUM(NSUInteger, ZYMiniProgramType){
    ZYMiniProgramTypeRelease = 0,       /** 正式版  */
    ZYMiniProgramTypeTest    = 1,       /** 开发版  */
    ZYMiniProgramTypePreview = 2,       /** 体验版  */
};

/**
 分享目标
 注 : 该枚举只在国内平台生效，如Facebook twitter 等国外平台不生效, 无需赋值(赋值也不好使)
 */
typedef NS_ENUM(NSInteger, ZYShareSceneType){
    ZYShareSceneSession           = 0,   /** 聊天界面   */
    ZYShareSceneTimeline          = 1,   /** 朋友圈 / QQ空间 */
    ZYShareSceneFavorite          = 2,   /** 收藏      */
    ZYShareSceneSpecifiedSession  = 3,   /** 指定联系人 */
    ZYShareSceneMinprogram        = 4,   /** 小程序 : 微信独占*/
};


@interface ZYShareModel : NSObject

- (instancetype) init __attribute__((unavailable("此框架禁用init方法, 请使用提供的初始化方。")));
+ (instancetype) new  __attribute__((unavailable("此框架禁用new方法, 请使用提供的初始化方。")));


#pragma mark - 初始化

/** 初始化 指定分享model 类型 */
- (instancetype)initWithShareType:(ZYShareType)shareType authType:(ZYAuthType)authType;


#pragma mark - public property

/**
 分享文本
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

/** 分享到哪,目标(会话, 朋友圈 等) */
@property (nonatomic, assign) ZYShareSceneType shareScene;


/** 分享类型 */
@property (nonatomic, assign, readonly) ZYShareType shareType;

/** 授权平台类型 */
@property (nonatomic, assign, readonly) ZYAuthType  authType;


#pragma mark - 微信 音乐分享 专属 属性

/** 音乐数据url地址 长度不能超过10K */
@property (nonatomic, copy) NSString *musicUrl;


#pragma mark - 微信小程序 专属 属性

/** 微信小程序username */
@property (nonatomic, copy) NSString *minProgramUserName;

/** 微信小程序类型 */
@property (nonatomic, assign) ZYMiniProgramType miniProgramType;

/** 微信小程序页面的路径 */
@property (nonatomic, copy) NSString *miniProgramPath;



#pragma mark - Facebook 专属 属性

/** 本地视频资源地址 */
@property (nonatomic, strong) NSString *facebookVideoPath;

/** image 数组 */
@property (nonatomic, strong) NSArray <UIImage *>*facebookImages;



@end

NS_ASSUME_NONNULL_END
