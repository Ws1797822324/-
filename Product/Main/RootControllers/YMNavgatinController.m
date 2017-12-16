//
//  YMNavgatinController.m
//  YMMY
//
//  Created by apple on 2017/3/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YMNavgatinController.h"
#import "PropertiesDetailsBBBB_VC.h"


@interface YMNavgatinController () <UINavigationControllerDelegate>
@property (nonatomic,assign)YMNavgatinControllerType pushType;
@property (nonatomic,assign)YMNavgatinControllerType popType;

@end

@implementation YMNavgatinController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    if(self.pushType == YMNavgatinControllerTypeBlue){
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_Nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        [self.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithColor:kRGB_HEX(0x66a8fc)]]];
        self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_Nav"]];
    }else{
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageWithColor:[UIColor clearColor]]];

    }
//    self.navigationBar.translucent = NO;
    self.delegate = self;
    
    self.navigationBar.shadowImage = [UIImage new];
}
-(void)pushViewController:(UIViewController *)viewController type:(YMNavgatinControllerType)type animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self  action:@selector(popToPre) withTitle:@""];

        self.navigationBar.tintColor = [UIColor whiteColor];

    }
    [super pushViewController:viewController animated:animated];
    
    self.pushType = type;
    
    if(self.pushType == YMNavgatinControllerTypeBlue){
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_Nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_Nav"]];
    }
    else{
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageWithColor:[UIColor clearColor]]];
    }

}

- (void)popToPre
{
    [self popViewControllerAnimated:YES];
    [XXProgressHUD hideHUD];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [XXProgressHUD hideHUD];
    if(self.pushType == YMNavgatinControllerTypeBlue  ){

        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_Nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];

    }
    else{
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }


    return [super popViewControllerAnimated:animated];
}
#pragma mark -  hhhhhhhhhhhh

-(UIViewController *)popViewControllerAnimated:(BOOL)animated type:(YMNavgatinControllerType)type{
    _popType = type;
    [XXProgressHUD hideHUD];

    if(self.popType == YMNavgatinControllerTypeBlue  ){

        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_Nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else{
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }


    return [super popViewControllerAnimated:animated];

}

-(void)navigationController:(UINavigationController *)navigationController
     willShowViewController:(UIViewController *)viewController
                   animated:(BOOL)animated{
    
    if (viewController != self.childViewControllers[0]){
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:kImageNamed(@"navigationbar_back") highImage:kImageNamed(@"navigationbar_back") target:self action:@selector(back) withTitle:@""];
    }
}

-(void)back{
    [self popViewControllerAnimated:YES];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            /* 自动显示和隐藏tabbar */
            viewController.hidesBottomBarWhenPushed = YES;
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self  action:@selector(back) withTitle:@""];
            self.navigationBar.tintColor = [UIColor whiteColor];

            if (kIOS11) {

                }else{
                    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
                }

        }
        
        [super pushViewController:viewController animated:animated];
    }

@end
