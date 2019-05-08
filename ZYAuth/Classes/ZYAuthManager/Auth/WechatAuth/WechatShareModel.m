//
//  WechatShareModel.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "WechatShareModel.h"

#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ![_ref isEqual: @""] && ![_ref isEqual: @"<null>"])

@implementation WechatShareModel


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


@end
