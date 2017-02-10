//
//  UINavigationItem+ZYGradient.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "UINavigationItem+ZYGradient.h"
#import <objc/runtime.h>

const NSString *GradientViewBackgroudColor;
@implementation UINavigationItem (ZYGradient)

- (void)setNavigationBarGradientViewBackgroudColor:(UIColor *)color {
    objc_setAssociatedObject(self,&GradientViewBackgroudColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)getNavigationBarGradientViewBackgroudColor {
    UIColor *color = objc_getAssociatedObject(self, &GradientViewBackgroudColor);
    if (!color) {
        color = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    }
    return color;
}

@end
