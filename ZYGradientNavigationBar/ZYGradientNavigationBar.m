//
//  ZYGradientNavigationBar.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ZYGradientNavigationBar.h"
#import "UINavigationItem+ZYGradient.h"

@implementation ZYGradientNavigationBar {
    UIGestureRecognizerState lastInteractivePopGestureRecognizerState;
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint velocity;
}

- (void)setNavigationController:(UINavigationController *)navigationController {
    _navigationController = navigationController;
    
    [_navigationController.interactivePopGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    UIScreenEdgePanGestureRecognizer *pan = (UIScreenEdgePanGestureRecognizer *)_navigationController.interactivePopGestureRecognizer;
    // 起点
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPoint = [_navigationController.interactivePopGestureRecognizer locationInView:_navigationController.view];
    }
    // 终点
    if (pan.state == UIGestureRecognizerStateEnded) {
        endPoint = [_navigationController.interactivePopGestureRecognizer locationInView:_navigationController.view];
        //  手指离开时的滑动速度
        velocity = [pan velocityInView:_navigationController.view];
        NSLog(@"%lf", velocity.x);
    }
    
}
- (void)dealloc {
    [_navigationController.interactivePopGestureRecognizer removeObserver:self forKeyPath:@"state"];
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
                            
                            // 是否是刚刚结束手势
                            BOOL isJustStop = lastInteractivePopGestureRecognizerState == UIGestureRecognizerStateBegan &&
                            _navigationController.interactivePopGestureRecognizer.state == UIGestureRecognizerStatePossible;
                            CGFloat ratio = (endPoint.x - startPoint.x)/_navigationController.view.bounds.size.width;
                            
                            // 是否中止滑动返回
                            BOOL isStopBack = isJustStop && ratio < 0.5 && velocity.x < 500;
                            
                            if (!isStopBack) {
                                view2.backgroundColor = [_navigationController.viewControllers.lastObject.navigationItem getNavigationBarGradientViewBackgroudColor];
                            }
                            
                            // 记录上次手势状态
                            lastInteractivePopGestureRecognizerState = _navigationController.interactivePopGestureRecognizer.state;
                        }
                    }
                }
            }
        }
    }
}


/*
 由于滑动返回触发时顶部控制器会立即出栈, 而不是滑动返回结束时在进行出栈操作,
 在中止滑动返回的时候的瞬间栈顶的控制器并不是'当前'控制器
 这个时候回调'layoutSubviews'设置的颜色就会不对应造成导航条闪动
 
 解决办法:
 通过手势结束时的滑动距离和速度判断是否中途中止了滑动返回
 
 问题:
 模拟器测试, 有时候velocity.x大于500仍然没有返回 已发现最大值为785
 由于不知道interactivePopGestureRecognizer滑动返回的判定条件,
 暂时以500为阈值
 */

@end
