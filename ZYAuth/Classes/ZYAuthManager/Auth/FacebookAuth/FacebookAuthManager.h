//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import  <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FacebookAuthManager : NSObject<ZYAuthProtocol>

@property (nonatomic, strong) UIViewController *rootViewController;

@end

NS_ASSUME_NONNULL_END
