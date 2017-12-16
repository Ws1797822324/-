//
//  NewFeatureCell.m
//  Product
//
//  Created by Sen wang on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewFeatureCell.h"

#import "CYLTabBarControllerConfig.h"
#import "LoginViewController.h"

@implementation NewFeatureCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (IBAction)skipButtonAction:(UIButton *)sender {

    [kUserDefaults setObject:@"10000" forKey:@"skipActionComplete"];
    kUserData;
    if ([userInfo.LoginType isEqualToString:@"096411"]) {
        
        CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
        CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
        
        [UIView animateWithDuration:0.2f animations:^{
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
            
        }];
    } else {
        LoginViewController * loginVC = [LoginViewController viewControllerFromNib];
        YMNavgatinController * navLiginVC = [[YMNavgatinController alloc] initWithRootViewController:loginVC];

        [UIView animateWithDuration:0.2f animations:^{
            [UIApplication sharedApplication].keyWindow.rootViewController =navLiginVC ;
        }];
}
}


-(void)configImageView:(NSInteger) row {
    _image_View.image = kImageNamed(kString(@"bg_guide_%ld", row +1));
}
@end
