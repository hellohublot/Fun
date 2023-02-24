//
//  UIViewController+HTNavigationBarButtonItem.m
//  Music163
//
//  Created by hublot on 2018/12/21.
//  Copyright © 2018 hublot. All rights reserved.
//

#import "UIViewController+HTNavigationBarButtonItem.h"

@implementation UIViewController (HTNavigationBarButtonItem)

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
	return [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"98c1e876c72d8b6ece5fec12b18993fd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
}

@end
