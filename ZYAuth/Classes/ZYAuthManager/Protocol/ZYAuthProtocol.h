//
//  ZYAuthProtocol.h
//  FBSnapshotTestCase
//
//  Created by 丁巍 on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ZYAuthProtocol <NSObject>
@optional

/** 进行注册 */
- (void)registerAuthWithAppId:(NSString *)appid appsecret:(NSString *)appsecret;

@end


NS_ASSUME_NONNULL_END
