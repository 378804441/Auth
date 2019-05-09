//
//  ZYShareModel.m
//  Pods
//
//  Created by 丁巍 on 2019/5/8.
//

#import "ZYShareModel.h"

#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ![_ref isEqual: @""] && ![_ref isEqual: @"<null>"])
#define DefaultVar @"\n可能需要的字段 : \n text\n title\n describe\n image\n previewImage\n urlString\n previewUrlString\n"


@implementation ZYShareModel


- (instancetype)initWithShareScene:(ZYShareSceneType)sceneType{
    self = [super init];
    if (self) {
        
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


-(void)setShareScene:(ZYShareSceneType)shareScene{
    _shareScene = shareScene;
    switch (shareScene) {
        case ZYShareSceneSession:
            NSLog(@"%@", DefaultVar);
            break;
        case ZYShareSceneTimeline:
            NSLog(@"%@", DefaultVar);
            break;
        case ZYShareSceneFavorite:
            NSLog(@"%@", DefaultVar);
            break;
        case ZYShareSceneSpecifiedSession:
            NSLog(@"%@", DefaultVar);
            break;
        case ZYShareSceneMinprogram:
            NSLog(@"%@", [NSString stringWithFormat:@"%@独占字段:\n minProgramUserName\n miniProgramType\n miniProgramPath\n", DefaultVar]);
            break;
        default:
            break;
    }
    
}


@end
