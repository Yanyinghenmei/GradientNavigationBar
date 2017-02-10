//
//  ZYGradientNavigationBar.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ZYGradientNavigationBar.h"
#import "UINavigationItem+ZYGradient.h"

@implementation ZYGradientNavigationBar

- (void)setNavigationController:(UINavigationController *)navigationController {
    _navigationController = navigationController;
}

- (void)setTranslucent:(BOOL)translucent {
    NSAssert(translucent, @"渐变导航栏不能设置translucent属性为false");
    [super setTranslucent:translucent];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    NSAssert(!backgroundImage, @"渐变导航栏不能设置backgroundImage属性");
    [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            view.backgroundColor = [UIColor clearColor];
            
            for (UIView *view1 in view.subviews) {
                
                // 去掉导航栏黑线
                if ([view1 isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    view1.hidden = true;
                }
                
                if ([view1 isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
                    view1.backgroundColor = [UIColor clearColor];
                    
                    for (UIView *view2 in view1.subviews) {
                        // 去掉毛玻璃效果
                        if ([view2 isKindOfClass:NSClassFromString(@"_UIVisualEffectBackdropView")]) {
                            view2.hidden = true;
                        }
                        
                        // 导航栏可渐变的颜色
                        if ([view2 isKindOfClass:NSClassFromString(@"_UIVisualEffectFilterView")]) {
                            view2.backgroundColor = [_navigationController.visibleViewController.navigationItem getNavigationBarGradientViewBackgroudColor];
                        }
                    }
                }
            }
        }
    }
}


@end
