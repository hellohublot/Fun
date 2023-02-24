//
//  HTMaskView.h
//  HTMaskView
//
//  Created by hublot on 2018/3/27.
//

#import <UIKit/UIKit.h>

@class HTMaskView;
typedef void(^HTMaskComplete)(HTMaskView *);

@interface HTMaskView: UIView

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithContentView:(UIView *)contentView;

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, assign) CGFloat usingSpringWithDamping;

@property (nonatomic, assign) CGFloat initialSpringVelocity;

- (void)presentMaskViewAnimated:(BOOL)animated
			 ifpresentTransform:(CGAffineTransform)ifpresentTransform
			 ifdismissTransform:(CGAffineTransform)ifdismissTransform
					   complete:(HTMaskComplete)complete
		  backgroundTouchInside:(HTMaskComplete)backgroundTouchInside;

- (void)dismissWithAnimated:(BOOL)animated complete:(HTMaskComplete)complete;

@end
