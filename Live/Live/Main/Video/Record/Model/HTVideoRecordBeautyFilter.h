//
//  HTVideoRecordBeautyFilter.h
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

#import <GPUImage/GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTVideoRecordBeautyFilter : GPUImageFilter

@property (nonatomic, assign) CGFloat beautyLevel;

@property (nonatomic, assign) CGFloat brightLevel;

@property (nonatomic, assign) CGFloat toneLevel;

@end

NS_ASSUME_NONNULL_END
