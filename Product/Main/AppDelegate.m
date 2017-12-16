//
//  AppDelegate.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+HJJpush.h"
#import "AppDelegate+Extension.h"
#import "CYLTabBarController.h"

#define RCAppKey @"0vnjpoad0g8fz"
#define RCtoken @"AJLfRM5IBMwb8gajqjil3yaS4WJX8IK1A/g1cn5DAsx1HxHCQHzGWEhRKJ7an6HMs6mkFZZreMCic+MsIPorVQHm8hFZ2dxo"

#define kWeChatKey @"wx41f5052f1ad6876b"
#define kQQKey @"1106560932"

#define UMAPPKEY @"5a1cdb8ca40fa35b7d000129"//友盟AppKey

@interface AppDelegate () <TencentSessionDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupJpush:launchOptions];
    
    [self setRootControllor];
    [self settingIQKeyboard]; 

    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAPPKEY];
    [self configUSharePlatforms];

    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];

    return YES;
}


-(void)configUSharePlatforms{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWeChatKey appSecret:UMAPPKEY redirectURL:@"http://mobile.umeng.com/social"];


    /* 设置朋友圈的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:kWeChatKey  appSecret:UMAPPKEY redirectURL:@"http://mobile.umeng.com/social"];


    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106560932"  appSecret:UMAPPKEY redirectURL:@"www.healthme100.com/"];
    

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
