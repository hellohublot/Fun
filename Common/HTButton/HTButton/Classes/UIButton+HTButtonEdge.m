//
//  UIButton+HTButtonEdge.m
//  HTButton
//
//  Created by hublot on 2018/3/28.
//

#import "UIButton+HTButtonEdge.h"
#import <objc/runtime.h>

@implementation NSObject (HTRuntime)

- (void)ht_setValue:(id)value forSelector:(SEL)selector {
	objc_setAssociatedObject(self, selector, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ht_valueForSelector:(SEL)selector {
	return objc_getAssociatedObject(self, selector);
}


+ (void)ht_swizzInstanceNativeSelector:(SEL)nativeSelector customSelector:(SEL)customSelector {
	Method nativeMethod = class_getInstanceMethod(self, nativeSelector);
	Method customMethod = class_getInstanceMethod(self, customSelector);
	if (!(nativeMethod || customMethod)) {
		return;
	}
    if (class_addMethod(self, nativeSelector, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))) {
        class_replaceMethod(self, customSelector, method_getImplementation(nativeMethod), method_getTypeEncoding(nativeMethod));
    } else {
        method_exchangeImplementations(class_getInstanceMethod(self, nativeSelector),
                                       class_getInstanceMethod(self, customSelector));
    }
}

+ (void)ht_swizzleClassNativeSelector:(SEL)nativeSelector customSelector:(SEL)customSelector {
	Method nativeMethod = class_getClassMethod(self, nativeSelector);
	Method customMethod = class_getClassMethod(self, customSelector);
	method_exchangeImplementations(nativeMethod, customMethod);
}

@end








@interface UIButton ()

@property (nonatomic, assign) CGSize imageToTitleOffsetSize;

@end


@implementation UIButton (HTButtonEdge)







+ (void)load {
	[self ht_swizzInstanceNativeSelector:@selector(intrinsicContentSize) customSelector:@selector(ht_intrinsicContentSize)];
    [self ht_swizzInstanceNativeSelector:@selector(_deriveTitleRect:imageRect:fromContentRect:calculatePositionForEmptyTitle:) customSelector:@selector(ht__deriveTitleRect:imageRect:fromContentRect:calculatePositionForEmptyTitle:)];
}

- (CGSize)imageToTitleOffsetSize {
	return [[self ht_valueForSelector:@selector(imageToTitleOffsetSize)] CGSizeValue];
}

- (void)setImageToTitleOffsetSize:(CGSize)imageToTitleOffsetSize {
	[self ht_setValue:[NSValue valueWithCGSize:imageToTitleOffsetSize] forSelector:@selector(imageToTitleOffsetSize)];
}

- (void)ht_makeEdgeWithDirection:(HTButtonEdgeDirection)direction imageToTitleaOffset:(CGFloat)imageToTitleOffset {
	CGSize imageToTitleOffsetSize = CGSizeZero;
	switch (direction) {
		case HTButtonEdgeDirectionHorizontal: {
			imageToTitleOffsetSize.width += imageToTitleOffset;
			break;
		}
		case HTButtonEdgeDirectionVertical: {
			imageToTitleOffsetSize.height += imageToTitleOffset;
			break;
		}
		default:
			break;
	}
	self.imageToTitleOffsetSize = imageToTitleOffsetSize;
	[self invalidateIntrinsicContentSize];
}

- (CGSize)ht_intrinsicContentSize {
	CGSize imageToTitleOffsetSize = self.imageToTitleOffsetSize;
	if (CGSizeEqualToSize(imageToTitleOffsetSize, CGSizeZero)) {
		return [self ht_intrinsicContentSize];
	}
	CGSize imageViewSize = self.imageView.intrinsicContentSize;
	CGSize titleLabelSize = self.titleLabel.intrinsicContentSize;

    if ([[UIFont systemFontOfSize:1].fontName containsString:@"bold"]) {
        titleLabelSize.width += 1.3;
    }

	if (imageToTitleOffsetSize.width != 0) {

		CGFloat imageToTitleOffset = imageToTitleOffsetSize.width;

		CGFloat contentWidth = self.contentEdgeInsets.left + imageViewSize.width + fabs(imageToTitleOffset) + titleLabelSize.width + self.contentEdgeInsets.right;
		CGFloat contentHeight = self.contentEdgeInsets.top + MAX(imageViewSize.height, titleLabelSize.height) + self.contentEdgeInsets.bottom;
		return CGSizeMake(contentWidth, contentHeight);
	} else {
		CGFloat imageToTitleOffset = imageToTitleOffsetSize.height;

		CGFloat contentWidth = self.contentEdgeInsets.left + MAX(imageViewSize.width, titleLabelSize.width) + self.contentEdgeInsets.right;
		CGFloat contentHeight = self.contentEdgeInsets.top + imageViewSize.height + fabs(imageToTitleOffset) + titleLabelSize.height + self.contentEdgeInsets.bottom;
		return CGSizeMake(contentWidth, contentHeight);
	}
}

- (void)ht__deriveTitleRect:(struct CGRect *)titleRectPoint imageRect:(struct CGRect *)imageRectPoint fromContentRect:(struct CGRect)contentRect calculatePositionForEmptyTitle:(BOOL)emptyTitle {
    CGSize imageToTitleOffsetSize = self.imageToTitleOffsetSize;
    BOOL shouldReturn = CGSizeEqualToSize(imageToTitleOffsetSize, CGSizeZero);
    [self ht__deriveTitleRect:titleRectPoint imageRect:imageRectPoint fromContentRect:shouldReturn ? contentRect : self.bounds calculatePositionForEmptyTitle:emptyTitle];
    if (shouldReturn) {
        return;
    }


    if (titleRectPoint == NULL || imageRectPoint == NULL) {
        return;
    }
    CGRect titleRect = *titleRectPoint;
    CGRect imageRect = *imageRectPoint;
    if (imageToTitleOffsetSize.width != 0) {
        if (imageToTitleOffsetSize.width < 0) {
            titleRect.origin.x -= imageRect.size.width;
            imageRect.origin.x += titleRect.size.width;
        }
        titleRect.origin.x += imageToTitleOffsetSize.width / 2;
        imageRect.origin.x -= imageToTitleOffsetSize.width / 2;
    } else {
        titleRect.size.width = MIN(contentRect.size.width, self.titleLabel.intrinsicContentSize.width);
        imageRect.size.width = MIN(contentRect.size.width, imageRect.size.width);

        titleRect.origin.x = (contentRect.size.width - titleRect.size.width) / 2;
        imageRect.origin.x = (contentRect.size.width - imageRect.size.width) / 2;
        titleRect.origin.y += imageToTitleOffsetSize.height / 2;
        imageRect.origin.y -= imageToTitleOffsetSize.height / 2;
        if (imageToTitleOffsetSize.height > 0) {
            titleRect.origin.y += imageRect.size.height / 2;
            imageRect.origin.y -= titleRect.size.height / 2;
        } else {
            titleRect.origin.y -= imageRect.size.height / 2;
            imageRect.origin.y += titleRect.size.height / 2;
        }

    }
    *titleRectPoint = titleRect;
    *imageRectPoint = imageRect;

}

@end

