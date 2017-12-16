//
//  MainNavViewController.m
//  HJProjectTemplate
//
//  Created by HJ on 2017/6/1.
//  Copyright © 2017年 HYS. All rights reserved.
//

#import "MainNavViewController.h"



@interface MainNavViewController ()

@end

@implementation MainNavViewController

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}


- (void)viewDidLoad {
   
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = kRGB_HEX(0x66a8fc);
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
     [super viewDidLoad];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self  action:@selector(popToPre) withTitle:@""];
    self.navigationBar.tintColor = [UIColor whiteColor];
    if (kIOS11) {

    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    }

    }
    
    [super pushViewController:viewController animated:animated];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
    [XXProgressHUD hideHUD];
    
    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
