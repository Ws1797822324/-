//
//  MyBrokerageViewController.m
//  Product
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//
#define colorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "MyBrokerageViewController.h"
#import "NewStayaccountsViewController.h"
#import "NewAlreadyaccondViewController.h"
#import "TitleView.h"
@interface MyBrokerageViewController ()
@property (nonatomic ,strong) NSArray * titlearray;
@property (nonatomic, strong) TitleView * titleview;
@end

@implementation MyBrokerageViewController

- (NSArray * )titles
{
    return  @[@"",@""];
}

- (void)loadRequest
{
    kUserData;

    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"Commission",@"opt",@"2",@"type",userInfo.token,@"token", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"Commission" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            self.titleview.dMoney_L.text = [NSString stringWithFormat:@"%@",data[@"nodeal"]];
            self.titleview.yMoney_L.text = [NSString stringWithFormat:@"%@",data[@"deal"]];
        }else{
            kShowMessage;
        }
        
    } withFailuerBlock:^(id error) {
        
    }];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self loadRequest];
    TitleView * titleview = [TitleView viewFromXib];
    self.titleview = titleview;
    titleview.frame = CGRectMake(0, 0, kWidth, kNavHeight + 80);
    [self.view addSubview:titleview];

    [[titleview.right_Button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.selectIndex = 1;
        XXLog(@"111111111");
    }];
    [[titleview.left_Button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.selectIndex = 0;
        XXLog(@"000000000");

    }];
    self.viewFrame = CGRectMake(0, 80, kScreenWidth, kScreenHeight - 80 );

    self.title = @"我的分佣";
    self.menuHeight = 3;
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = 15;
    self.titleColorSelected = [UIColor blackColor];
    self.titleColorNormal = [UIColor blackColor];
    self.progressColor = colorWithRGB(105, 170, 249);
    self.itemsWidths = @[@(kWidth / 2),@((kWidth)/ 2)]; // 这里可以设置不同的宽度
    self.progressHeight = 2;
    self.progressWidth =(kWidth)/2;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    [super viewDidLoad];
    
    
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController * _Nonnull)pageController
{
    
    return  self.titles.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        NewStayaccountsViewController *vc = [[NewStayaccountsViewController alloc] init];
        return vc;
        
    }else{
        NewAlreadyaccondViewController *vc=[[NewAlreadyaccondViewController alloc]init];
        return vc;
    }
    
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}


@end
