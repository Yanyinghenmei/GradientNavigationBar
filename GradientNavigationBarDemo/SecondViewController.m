//
//  SecondViewController.m
//  MapKitDemo
//
//  Created by Daniel on 17/2/9.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "UINavigationItem+ZYGradient.h"



@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"second";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    [self.navigationItem setNavigationBarGradientViewBackgroudColor:[UIColor clearColor]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)next {
    [self.navigationController pushViewController:[ThirdViewController new] animated:true];
}

@end
