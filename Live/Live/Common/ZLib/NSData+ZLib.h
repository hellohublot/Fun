//
//  NSData+ZLib.h
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZLib)

- (NSData *)zlibInflate;
- (NSData *)zlibDeflate;

@end

NS_ASSUME_NONNULL_END
