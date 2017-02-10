//
//  MyNavigationController.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "MyNavigationController.h"
#import "ZYGradientNavigationBar.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
        ZYGradientNavigationBar *navigationBar = [ZYGradientNavigationBar new];
        navigationBar.navigationController = self;
        [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self setValue:navigationBar forKey:@"navigationBar"];
    }
    return self;
}

@end
