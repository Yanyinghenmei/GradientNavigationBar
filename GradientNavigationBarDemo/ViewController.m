//
//  ViewController.m
//  GradientNavigationBarDemo
//
//  Created by Daniel on 17/2/10.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

#import "UINavigationItem+ZYGradient.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"first";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    // 设置渐变颜色
    [self.navigationItem setNavigationBarGradientViewBackgroudColor:[UIColor colorWithRed:54/255.00 green:176/255.00 blue:237/255.00 alpha:1]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClick:(id)sender {
    [self.navigationController pushViewController:[SecondViewController new] animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
