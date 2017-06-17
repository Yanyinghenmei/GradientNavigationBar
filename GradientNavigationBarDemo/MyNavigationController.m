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
        [self setValue:navigationBar forKey:@"navigationBar"];
        
        self.delegate = self;
        [self setTheme];
    }
    return self;
}

- (void)setTheme {
    // title属性
    UINavigationBar *bar = [UINavigationBar appearance];
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [bar setTitleTextAttributes:attr];
    
    
    // 按钮图片渲染
    [bar setTintColor:[UIColor whiteColor]];
    
    // 按钮属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *itemAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [item setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    [item setTintColor:[UIColor whiteColor]];
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
