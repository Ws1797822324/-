//
//  AppDelegate+Extension.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate+Extension.h"

#import "LoginViewController.h"

#import "CYLTabBarControllerConfig.h"

#import "NewFeatureController.h"

#import "YMNavgatinController.h"


#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]


@implementation AppDelegate (Extension)



-(void) settingIQKeyboard {
    
    
    [IQKeyboardManager sharedManager].enable = true;
    /**
     点击屏幕是否收起键盘
     */
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
    
    /**
     是否显示文本区域占位符
     */

    [IQKeyboardManager  sharedManager].shouldShowToolbarPlaceholder = YES;
    /**
     控制键盘上的工具条文字颜色是否用户自定义
     */
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = true;
    /**
     控制是否显示键盘上的工具条。
     */
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:false];
    
    [[IQKeyboardManager sharedManager] setToolbarTintColor:[UIColor darkGrayColor]];
    
    /**
     输入框距离键盘的距离
     */
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:20.f];
    
}


#pragma mark - 设置主控制器
-(void)setRootControllor {

    NewFeatureController * newFeatureC = [[NewFeatureController alloc]init];
    LoginViewController * loginVC = [LoginViewController viewControllerFromNib];

    YMNavgatinController * navLiginVC = [[YMNavgatinController alloc] initWithRootViewController:loginVC];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc]init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;


        NSDictionary *currentVersion = [NSBundle mainBundle].infoDictionary;
    UserInfo * userInfo = [UserInfoTool account];
    
    if ([[kUserDefaults objectForKey:@"skipActionComplete"] integerValue] != 10000) {
        self.window.rootViewController = newFeatureC;

    } else if (![userInfo.LoginType isEqualToString:@"096411"]) {
        self.window.rootViewController = navLiginVC;

    }
    else {

        self.window.rootViewController = tabBarControllerConfig.tabBarController;

    }
    tabBarController.delegate = self;

    
    [self.window makeKeyAndVisible];

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}





#pragma mark - -------------------------------------------------------











@end
