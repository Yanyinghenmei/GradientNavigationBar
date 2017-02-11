//
//  ThirdViewController.m
//  MapKitDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ThirdViewController.h"
#import "UINavigationItem+ZYGradient.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"Third";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3"]];
    [self.navigationItem setNavigationBarGradientViewBackgroudColor:[UIColor colorWithRed:178/255.00 green:45/255.00 blue:18/255.00 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
