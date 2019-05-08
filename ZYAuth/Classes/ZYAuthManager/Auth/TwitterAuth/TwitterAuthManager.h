//
//  ZYAuthManager.h
//  ZYAuthManager
//
//  Created by 丁巍 on 2019/5/5.
//  Copyright © 2019 丁巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYAuthProtocol.h"
#import <TwitterKit/TwitterKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TwitterAuthManager : NSObject<ZYAuthProtocol>

@end

NS_ASSUME_NONNULL_END
