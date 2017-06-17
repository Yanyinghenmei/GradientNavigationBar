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
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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
                            
                            id panDelegate = _navigationController.interactivePopGestureRecognizer.delegate;
                            long long interactionState = [[panDelegate valueForKey:@"_interactionState"] longLongValue];
                            
                            
                            // 中途取消 滑动返回 不设置颜色
                            /*
                             # interactivePopGestureRecognizer 触发, 栈顶的控制器会立即出栈
                             
                             interactionState == 0 :
                                interactivePopGestureRecognizer结束, 动画结束
                             interactionState == 1 :
                                手指未离开屏幕 或者 手指从屏幕右侧离开动画未结束
                                这里会控制此时栈顶的控制器导航栏的颜色
                             interactionState == 2 :
                                从当前页面第一次滑动返回时出现
                                基本和 interactionState == 1 相似
                             interactionState == 3 :
                                手指从屏幕左侧离开, 动画未结束
                                此时栈顶的控制器并不是我想要控制导航颜色的控制器
                             */
                            if (interactionState != 3) {
                                view2.backgroundColor = [_navigationController.viewControllers.lastObject.navigationItem getNavigationBarGradientViewBackgroudColor];
                            }
                        }
                    }
                }
            }
        }
    }
}

@end
