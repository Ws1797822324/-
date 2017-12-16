//
//  AppDelegate+HJJpush.h
//  EasyCarToBuy
//
//  Created by HJ on 2017/8/28.
//  Copyright © 2017年 HYS. All rights reserved.
//

#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (HJJpush)<JPUSHRegisterDelegate>

//初始化jpush
-(void)setupJpush:(nullable NSDictionary *)launchOptions;

@end
