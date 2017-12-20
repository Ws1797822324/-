//
//  MoneyDetails_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MoneyDetails_VC.h"

#import "MoneyDetailsA_VC.h"
#import "MoneyDetailsB_VC.h"

@interface MoneyDetails_VC ()

@end

@implementation MoneyDetails_VC

- (void)viewDidLoad {
    self.selectIndex = (int)_vcType -1;
    NSLog(@"--- %ld",self.vcType);
    
    self.viewFrame = CGRectMake(0,kNavHeight, kScreenWidth, kScreenHeight - kNavHeight );


    self.menuHeight = 60;
    self.menuBGColor = kRGB_HEX(0x61a1d7);
    self.progressViewCornerRadius = 6;
    self.menuViewBottomSpace = 0;
    self.menuViewStyle = WMMenuViewStyleSegmented;
    self.titleSizeSelected = 15;
    self.titleColorSelected = kRGB_HEX(0x61a1d7);
    self.titleColorNormal = [UIColor whiteColor];

    self.progressColor = [UIColor whiteColor];
    self.itemsWidths = @[@(([UIScreen mainScreen].bounds.size.width)/ 3),@(([UIScreen mainScreen].bounds.size.width)/ 3)]; // 这里可以设置不同的宽度
    self.progressHeight = 35;

    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.navigationItem.title = @"还款详情";


[super viewDidLoad];

}

- (NSArray *)titles
{
    return @[@"等额本息", @"等额本金"];
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            MoneyDetailsA_VC *vc = [[MoneyDetailsA_VC alloc] init];
            vc.str1 = self.str1;
            vc.str2 = self.str2;
            vc.str3 = self.str3;
            vc.str4 = self.str4;

            vc.DKType = _DKType;

            return vc;
        }
            break;
        case 1: {


            MoneyDetailsB_VC *vc = [[MoneyDetailsB_VC alloc] init];
            vc.str1 = self.str1;
            vc.str2 = self.str2;
            vc.str3 = self.str3;
            vc.str4 = self.str4;
            vc.DKType = _DKType;
            
            return vc;

        }
            break;

        default: {
            UIViewController *vc = [[UIViewController alloc] init];

            return vc;
        }
    }
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
