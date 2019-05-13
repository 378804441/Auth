//
//  ZYAppdelegateHook.h
//  Pods
//
//  Created by 丁巍 on 2019/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZYAppdelegateHook : NSObject

/** 根据class注册 appdelegate 的方法调用 推荐用这个 */
+ (void)registerAppDelegateClass:(nonnull Class)cla;

@end

NS_ASSUME_NONNULL_END
