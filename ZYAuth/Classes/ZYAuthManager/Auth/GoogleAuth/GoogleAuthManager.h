//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
@import GoogleSignIn;


NS_ASSUME_NONNULL_BEGIN

@interface GoogleAuthManager : NSObject<ZYAuthProtocol, GIDSignInDelegate, GIDSignInUIDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

@property (nonatomic, strong) NSString *redirectURI;

@property (nonatomic, copy)   ZYAuthSuccessBlock successBlock;

@property (nonatomic, copy)   ZYAuthFailureBlock failureBlock;

@end

NS_ASSUME_NONNULL_END
