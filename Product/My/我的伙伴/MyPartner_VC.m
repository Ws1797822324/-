//
//  MyPartner_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyPartner_VC.h"

@interface MyPartner_VC ()

@end

@implementation MyPartner_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewFrame = CGRectMake(0, 0, kScreenWidth , kScreenHeight );
    
    self.menuHeight = 35; //导航栏高度

    self.menuBGColor = kRGBA_HEX(0x66a8fc, 0.9);

    self.automaticallyCalculatesItemWidths = true;
    self.menuViewStyle = WMMenuViewStyleSegmented;


    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.progressColor = [UIColor whiteColor];//设置下划线(或者边框)颜色
    self.titleSizeSelected = 15;//设置选中文字大小
    self.titleColorNormal = [UIColor whiteColor];
    self.progressViewBottomSpace = 10;
    self.titleColorSelected = kRGBA_HEX(0x66a8fc, 1);//设置选中文字颜色
    self.progressViewCornerRadius = 5;
    self.titleSizeNormal = 14;
    self.selectIndex = 0;
   self.showOnNavigationBar = YES;

    
    self.itemMargin = 20;
    
}


- (NSArray *)titles
{
    return @[@"A级伙伴", @"B级伙伴"];
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
            ApartnerViewController *vc = [[ApartnerViewController alloc] init];
            
            return vc;
        }
            break;
        case 1: {
            BpartnerViewController *vc = [[BpartnerViewController alloc] init];
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
