//
//  ZYShareModel.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//



#import "ZYShareModel.h"

#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ![_ref isEqual: @""] && ![_ref isEqual: @"<null>"])
#define DefaultVar @"\n可能需要的字段 : \n text\n title\n describe\n image\n previewImage\n urlString\n previewUrlString\n"

@interface ZYShareModel()

@property (nonatomic, assign, readwrite) ZYShareType shareType;

@property (nonatomic, assign, readwrite) ZYAuthType  authType;

@end


@implementation ZYShareModel


- (instancetype)initWithShareType:(ZYShareType)shareType authType:(ZYAuthType)authType{
    self = [super init];
    if (self) {
        self.authType  = authType;
        self.shareType = shareType;
    }
    return self;
}


// 预览图如果没有的话就用分享图作为预览图
- (UIImage *)previewImage {
    if(NotNilAndNull(_previewImage)) {
        return _previewImage;
    }
    return _image;
}

- (NSString *)text {
    if(NotNilAndNull(_text)) {
        return _text;
    }
    return @"";
}

- (NSString *)title {
    if(NotNilAndNull(_title)) {
        return _title;
    }
    return @"";
}

- (NSString *)describe {
    if(NotNilAndNull(_describe)) {
        return _describe;
    }
    return @"";
}

- (NSString *)urlString {
    if(NotNilAndNull(_urlString)) {
        return _urlString;
    }
    return @"";
}

- (NSString *)previewUrlString {
    if(NotNilAndNull(_previewUrlString)) {
        return _previewUrlString;
    }
    return @"";
}

- (NSString *)musicUrl{
    if(NotNilAndNull(_musicUrl)) {
        return _musicUrl;
    }
    return @"";
}


#pragma mark - Facebook 专属 属性

-(NSString *)facebookVideoPath{
    if(NotNilAndNull(_facebookVideoPath)) {
        return _facebookVideoPath;
    }
    return @"";
}


/** 做一些降级处理  facebookImages -> image -> previewImage */
- (NSArray <UIImage *>*)facebookImages {
    if(NotNilAndNull(_facebookImages)) {
        return _facebookImages;
    }
    
    if (NotNilAndNull(_image)) {
        return @[_image];
    }
    
    if (NotNilAndNull(_previewImage)) {
        return @[_previewImage];
    }
    return nil;
}


@end
