//
//  HTRefreshHeader.m
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

#import "HTRefreshHeader.h"

@interface HTRefreshHeader ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation HTRefreshHeader

- (UIImageView *)imageView {
	if (!_imageView) {
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.layer.masksToBounds = true;
		_imageView.image = [UIImage imageNamed:@"3f3192db2f017ad5203f01a16c79d772"];
		[_imageView sizeToFit];
	}
	return _imageView;
}

- (CABasicAnimation *)animation {
	if (!_animation) {
		_animation = [[CABasicAnimation alloc] init];
		_animation.keyPath = @"transform.rotation";
		_animation.fromValue = @(0);
		_animation.toValue = @(M_PI * 2);
		_animation.duration = 0.5;
		_animation.fillMode = kCAFillModeForwards;
		_animation.repeatCount = HUGE_VAL;
		_animation.autoreverses = false;
		_animation.removedOnCompletion = false;
		_animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	}
	return _animation;
}

- (void)prepare {
	[super prepare];
	[self addSubview:self.imageView];
	self.stateLabel.hidden = true;
	self.lastUpdatedTimeLabel.hidden = true;
}

- (void)placeSubviews {
	[super placeSubviews];
	CGSize superSize = self.bounds.size;
	self.imageView.center = CGPointMake(superSize.width / 2.0, superSize.height / 2.0);
}

- (void)setState:(MJRefreshState)state {
	[super setState:state];
	switch (state) {
		case MJRefreshStateRefreshing:
			[self.imageView.layer addAnimation:self.animation forKey:nil];
			break;
		default:
			[self.imageView.layer removeAllAnimations];
			break;
	}
}

@end
