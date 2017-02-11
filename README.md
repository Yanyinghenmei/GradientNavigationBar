# GradientNavigationBar
![image](https://github.com/Yanyinghenmei/GradientNavigationBar/raw/master/image.gif)

模仿QQ空间侧滑返回渐变导航栏

MyNavigationController.m
```objc
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
        ZYGradientNavigationBar *navigationBar = [ZYGradientNavigationBar new];
        navigationBar.navigationController = self;
        [self setValue:navigationBar forKey:@"navigationBar"];
    }
    return self;
}
```

ViewController.m
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏颜色
    [self.navigationItem setNavigationBarGradientViewBackgroudColor:
     [UIColor colorWithRed:54/255.00 green:176/255.00 blue:237/255.00 alpha:1]];
}
```