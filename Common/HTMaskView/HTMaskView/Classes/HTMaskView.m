//
//  HTMaskView.m
//  HTMaskView
//
//  Created by hublot on 2018/3/27.
//

#import "HTMaskView.h"

@interface HTMaskView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGAffineTransform ifpresentTransform;

@property (nonatomic, assign) CGAffineTransform ifdismissTransform;

@property (nonatomic, copy) HTMaskComplete backgroundTouchInside;

@end

@implementation HTMaskView

- (instancetype)initWithContentView:(UIView *)contentView {
	if (self = [super init]) {
		[self addSubview:contentView];
		self.contentView = contentView;
		self.duration = 0.25;
		self.usingSpringWithDamping = 1;
		self.initialSpringVelocity = 0;
		self.translatesAutoresizingMaskIntoConstraints = false;
		self.layer.masksToBounds = true;
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	}
	return self;
}

- (void)presentMaskViewAnimated:(BOOL)animated
			 ifpresentTransform:(CGAffineTransform)ifpresentTransform
			 ifdismissTransform:(CGAffineTransform)ifdismissTransform
					   complete:(HTMaskComplete)complete
		  backgroundTouchInside:(HTMaskComplete)backgroundTouchInside {
	[self removeFromSuperview];
	for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
		[self removeGestureRecognizer:gesture];
	}
	
	self.ifpresentTransform = ifpresentTransform;
	self.ifdismissTransform = ifdismissTransform;
	UIView *superView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
	[superView addSubview:self];
	[self addSubview:self.contentView];
	[NSLayoutConstraint activateConstraints:@[
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]
	]];
	
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewActionGesture:)];
	gesture.delegate = self;
	[self addGestureRecognizer:gesture];
	gesture.enabled = backgroundTouchInside != nil;
	self.backgroundTouchInside = backgroundTouchInside;
	
	[self switchContentViewAnimated:animated tohidden:false complete:complete isWillPresent:true];
}

- (void)dismissWithAnimated:(BOOL)animated complete:(HTMaskComplete)complete {
	HTMaskComplete recomplete = ^(HTMaskView *maskView) {
		[maskView.contentView removeFromSuperview];
		[self removeFromSuperview];
		if (complete) {
			complete(maskView);
		}
	};
	[self switchContentViewAnimated:animated tohidden:true complete:recomplete isWillPresent:false];
}

- (BOOL)shouldReceiveUserInterface:(UIView *)view {
	if (view == self) {
		return true;
	}
	return false;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return [self shouldReceiveUserInterface:touch.view];
}

- (void)maskViewActionGesture:(UITapGestureRecognizer *)gesture {
	if (self.backgroundTouchInside) {
		self.backgroundTouchInside(self);
	}
}

- (void)switchContentViewToHidden:(BOOL)tohidden isWillPresent:(BOOL)isWillPresent {
	if (tohidden) {
		self.contentView.transform = isWillPresent ? self.ifpresentTransform : self.ifdismissTransform;
		self.alpha = 0;
	} else {
		self.contentView.transform = CGAffineTransformIdentity;
		self.alpha = 1;
	}
}

- (void)switchContentViewAnimated:(BOOL)animated tohidden:(BOOL)tohidden complete:(HTMaskComplete)complete isWillPresent:(BOOL)isWillPresent {
	[self switchContentViewToHidden:!tohidden isWillPresent:isWillPresent];
	[UIView animateWithDuration:animated ? self.duration : 0 delay:0 usingSpringWithDamping:self.usingSpringWithDamping initialSpringVelocity:self.initialSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self switchContentViewToHidden:tohidden isWillPresent:isWillPresent];
	} completion:^(BOOL finished) {
		if (complete) {
			complete(self);
		}
	}];
}

@end
