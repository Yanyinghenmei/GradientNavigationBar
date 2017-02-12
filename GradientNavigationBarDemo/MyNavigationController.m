//
//  MyNavigationController.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "MyNavigationController.h"
#import "ZYGradientNavigationBar.h"

@interface MyNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MyNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
        ZYGradientNavigationBar *navigationBar = [ZYGradientNavigationBar new];
        navigationBar.navigationController = self;
        [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self setValue:navigationBar forKey:@"navigationBar"];
        
        self.delegate = self;
    }
    return self;
}


// 解决navigationBar连续点击多次跳转bug
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.navigationBar.userInteractionEnabled = false;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.navigationBar.userInteractionEnabled = false;
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    self.navigationBar.userInteractionEnabled = false;
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.navigationBar.userInteractionEnabled = true;
}

@end
