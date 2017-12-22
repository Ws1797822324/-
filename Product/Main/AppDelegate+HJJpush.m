///     ec0454d60d2e714e303de6fd
//  Ap

//

#import "AppDelegate+HJJpush.h"

#define jpush_appKey @"a5465ddddbb9126eed461852"

#define jpush_channel_AppStore @"App Store"
#import "PeopleDetailsViewController.h"


#import "MyPartner_VC.h"
#import "PeopleDetailsViewController.h"
#import "IntegralMall_VC.h"
#import "MyExchange_VC.h"
#import "NewStayparticularsViewController.h"
#import "MessagesTVC.h"
#import "WorkType_VC.h"


@implementation AppDelegate (HJJpush)
-(void)setupJpush:(nullable NSDictionary *)launchOptions
{
    //    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];   // 收到消息(非APNS)  后台单推

    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];



    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions
                           appKey:jpush_appKey
                          channel:jpush_channel_AppStore
                 apsForProduction:NO
            advertisingIdentifier:nil];

    //    [JPUSHService setLogOFF];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark ------- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];

    }
    NSLog(@"前台userInfo = %@",userInfo);


    [[NSNotificationCenter defaultCenter] postNotificationName:@"发送通知" object:nil];
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);

}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {

    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self pushControllerWithuserinfo:userInfo];

    }

    NSLog(@"后台userInfo = %@",userInfo);
    completionHandler();  // 系统要求执行这个方法
}


- (void)pushControllerWithuserinfo:(NSDictionary *)userinfo
{
    int kkk = [userinfo[@"type"] intValue];
    NSString * ID = userinfo[@"clickid"];

    //
    //    1    已成交        ->    客户详情
    //    2    已结佣        ->    佣金详情
    //    3    兑换成功    ->    我的兑换记录
    //    4    已报备        ->    客户详情
    //    5    积分提醒     ->    礼品商城
    //    6    邀请完成    ->    我的伙伴
    //    7   通知
    //    8   成交详情

    if (kkk == 8) {
        WorkType_VC * vc = [[WorkType_VC alloc]init];
        vc.navigationItem.title = @"成交详情";
        vc.type_vc = @"1";
        vc.kh_ID = ID;
        [[self topViewController:kkk].navigationController  pushViewController:vc animated:YES];
    }
if ( kkk == 7) {
    MessagesTVC * vc = [[MessagesTVC alloc]init];
    [(YMNavgatinController *)[self topViewController:kkk].navigationController  pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];

    }
    if (kkk == 6) {
        MyPartner_VC * vc = [[MyPartner_VC alloc]init];
        [(YMNavgatinController *)[self topViewController:kkk].navigationController  pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];
    }
    if (kkk == 5) {
        IntegralMall_VC * vc = [[IntegralMall_VC alloc]init];
        [(YMNavgatinController *)[self topViewController:kkk].navigationController  pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];
    }
    if (kkk == 4) {
        PeopleDetailsViewController * vc = [[PeopleDetailsViewController alloc]init];
        vc.ids = ID;
        [[self topViewController:kkk].navigationController  pushViewController:vc animated:YES];
    }
    if (kkk == 3) {
        MyExchange_VC * vc = [[MyExchange_VC alloc]init];

        [(YMNavgatinController *)[self topViewController:kkk].navigationController  pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];

    }
    if (kkk == 2) {
        NewStayparticularsViewController * vc = [[NewStayparticularsViewController alloc]init];
        vc.ids = ID;
        vc.type = @"1";
        vc.wsType = @"0";
        [[self topViewController:kkk].navigationController  pushViewController:vc animated:YES];
    }
    if (kkk == 1) {
        PeopleDetailsViewController *vc = [[PeopleDetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ids = ID;
        [[self topViewController:kkk].navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark ----------- 当注册了Backgroud Modes -> Remote notifications 后，notification 处理函数一律切换到下面函数，后台推送代码也在此函数中调用。后台需加 content-available: 1
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    [JPUSHService handleRemoteNotification:userInfo];

    NSLog(@"userInfo = %@",userInfo);


    completionHandler(UIBackgroundFetchResultNewData);

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [JPUSHService handleRemoteNotification:userInfo];
}


-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#pragma mark ---------- 收到消息(非APNS)
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //jpush回调响应方法
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = userInfo[@"content"];
    NSLog(@"content %@ = %@",userInfo,content);

    //    UIAlertView*alterView=[[UIAlertView alloc] initWithTitle:@"" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alterView show];

}


/** 切换根视图 */
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };

    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

#pragma mark -  topViewController
- (UIViewController*)topViewController:(int) index
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController Index:index];
}
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController Index:(int)index
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController Index:index];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        if (index == 1 || index == 4  || index == 2) {
            MainNavViewController* navigationController = (MainNavViewController*)rootViewController;
            return [self topViewControllerWithRootViewController:navigationController.visibleViewController Index:index];
        }
        else {
            YMNavgatinController* navigationController = (YMNavgatinController*)rootViewController;
            return [self topViewControllerWithRootViewController:navigationController.visibleViewController Index:index];

        }
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController Index:index];
    }
    else
    {
        return rootViewController;
    }
}

@end

