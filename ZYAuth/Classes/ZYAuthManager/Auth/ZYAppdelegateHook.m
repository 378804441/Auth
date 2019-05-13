//
//  ZYAppdelegateHook.h
//  Pods
//
//  Created by 丁巍 on 2019/5/13.
//


#import "ZYAppdelegateHook.h"
#import <stdarg.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "ZYAuthManager.h"

#define ADD_SELECTOR_PREFIX(__SELECTOR__) @selector(hook_##__SELECTOR__)

#define SWIZZLE_DELEGATE_METHOD(__SELECTORSTRING__) \
Swizzle([delegate class], @selector(__SELECTORSTRING__), class_getClassMethod([ZYAppdelegateHook class], ADD_SELECTOR_PREFIX(__SELECTORSTRING__))); \

#define ZY_APPDELEGATE_CALL_ORTHER( _cmd_, _application_, _args1_, _args2_, _args3_) \
for (Class cla in ZYModuleClass) { \
    if ([cla respondsToSelector:_cmd_]) { \
            ((void (*)(id, SEL, id , id , id , id))(void *)objc_msgSend)(cla,_cmd_,_application_,_args1_,_args2_,_args3_); \
        } \
    } \

static NSMutableSet<Class> * ZYModuleClass;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"


BOOL ZY_Appdelegate_method_return(id _self_, SEL _cmd_, id _application_, id _args1_, id _args2_, id _args3_) {
    BOOL returnValue = NO;
    SEL ty_selector = NSSelectorFromString([NSString stringWithFormat:@"hook_%@", NSStringFromSelector(_cmd_)]);
    Method m = class_getClassMethod([ZYAppdelegateHook class], ty_selector);
    IMP method = method_getImplementation(m);
    if (![NSStringFromSelector(_cmd_) hasPrefix:@"hook_"]) {
        BOOL (* callMethod)(id,SEL,id,id,id,id) = (void *)method;
        returnValue = callMethod(_self_,ty_selector,_application_,_args1_,_args2_,_args3_);
    }
    ZY_APPDELEGATE_CALL_ORTHER(_cmd_, _application_, _args1_, _args2_, _args3_)
    return returnValue;
}


/** hook 方法 */
void Swizzle(Class class, SEL originalSelector, Method swizzledMethod){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    SEL swizzledSelector = method_getName(swizzledMethod);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod && originalMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIApplication (DCX)

- (void)hook_setDelegate:(id <UIApplicationDelegate>)delegate {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SWIZZLE_DELEGATE_METHOD(application:handleOpenURL:)
        SWIZZLE_DELEGATE_METHOD(application:openURL:sourceApplication:annotation:)
    });
    [self hook_setDelegate:delegate];
}

@end

@implementation ZYAppdelegateHook

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Swizzle([UIApplication class], @selector(setDelegate:), class_getInstanceMethod([UIApplication class], @selector(hook_setDelegate:)));
    });
}

+ (void)registerAppDelegateClass:(nonnull Class)cla {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ZYModuleClass = [NSMutableSet new];
    });
    [ZYModuleClass addObject:cla];
}


#pragma mark - private method

+ (BOOL)hook_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation  {
    BOOL openURL = NO;
    // 1) 插入auth openURL授权
    openURL = [[ZYAuthManager shareInstance] openURLWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    // 2) 调用原有方法
    openURL = ZY_Appdelegate_method_return(self,_cmd,application,url,sourceApplication,annotation);
    return openURL;
}


+ (BOOL)hook_application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL openURL = NO;
    // 1) 插入auth openURL授权
    openURL = [[ZYAuthManager shareInstance] openURLWithApplication:application handleOpenURL:url];
    // 2) 调用原有方法
    openURL = ZY_Appdelegate_method_return(self,_cmd,application,url,nil,nil);
    return openURL;
}


@end


