//
//  ChooseDredgeBankViewController.m
//  Product
//
//  Created by HJ on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChooseDredgeBankViewController.h"

@interface ChooseDredgeBankViewController ()

@end
static CGFloat height_VC = 200;

@implementation ChooseDredgeBankViewController
- (void)viewWillLayoutSubviews
{
    self.view.frame = CGRectMake(20, (kHeight-height_VC)/2, kWidth-40, height_VC);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * topLabel = [[UILabel alloc] init];
    [self.view addSubview:topLabel];
    topLabel.font = [UIFont systemFontOfSize:14];
    topLabel.text = @"温馨提示";
    topLabel.textColor = kRGB_HEX(0x66a8fc);
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * lineLabel = [[UILabel alloc] init];
    [self.view addSubview:lineLabel];
    lineLabel.backgroundColor = kRGB_HEX(0x66a8fc);
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLabel.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView * img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    img.backgroundColor = [UIColor yellowColor];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kRGB_HEX(0x575757);
    titleLabel.text = @"该功能需要开通实名银行卡认证才能使用！";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(img.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat width_btn = (kWidth-40-20-20)/2;
    
    UIButton * noBtn = [[UIButton alloc] init];
    [self.view addSubview:noBtn];
    [noBtn setBackgroundColor:kColor(230, 230, 230)];
    [noBtn setTitle:@"取消" forState:0];
    kViewRadius(noBtn, 6);
    [noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(width_btn);
        make.height.mas_equalTo(40);
    }];
    [noBtn addTarget:self action:@selector(noClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * yesBtn = [[UIButton alloc] init];
    [self.view addSubview:yesBtn];
    [yesBtn setBackgroundColor:kRGB_HEX(0x66a8fc)];
    [yesBtn setTitle:@"去认证" forState:0];
    kViewRadius(yesBtn, 6);
    [yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(width_btn);
        make.height.mas_equalTo(40);
    }];
    [yesBtn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)noClick
{
    self.clickNoOrYes(@"no");
}
- (void)yesClick
{
    self.clickNoOrYes(@"yes");
}

@end
