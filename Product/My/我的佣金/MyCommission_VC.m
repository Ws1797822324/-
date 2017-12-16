//
//  MyCommissionViewController.m
//  经纪人
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyCommission_VC.h"
#import "MyReflectionViewController.h"
#import "MyBrokerageViewController.h"
@interface MyCommission_VC ()

@end

@implementation MyCommission_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setTitle:@"我的佣金"];
    [self setUI];
    
}
-(void)setUI{
   
    
    UIButton* iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconButton setImage:[UIImage imageNamed:@"组4"] forState:UIControlStateNormal];
    [iconButton addTarget:self action:@selector(positioningClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:iconButton];
    iconButton.layer.masksToBounds=YES;
    iconButton.layer.borderColor=[[UIColor whiteColor] CGColor];
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(40);
    }];
    
    UILabel *mimaLB=[[UILabel alloc]init];
    mimaLB.text=@"我的成交";
    mimaLB.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:mimaLB];
    [mimaLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(iconButton);
        make.top.mas_equalTo(iconButton.mas_bottom).offset(10);
    }];
    
    
    UIButton* iconButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconButton1 setImage:[UIImage imageNamed:@"组5"] forState:UIControlStateNormal];
    [iconButton1 addTarget:self action:@selector(positioningClick1) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:iconButton1];
    iconButton1.layer.masksToBounds=YES;
    iconButton1.layer.borderColor=[[UIColor whiteColor] CGColor];
    [iconButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(40);
    }];
    
    UILabel *mimaLB1=[[UILabel alloc]init];
    mimaLB1.text=@"我的分佣";
    mimaLB1.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:mimaLB1];
    [mimaLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(iconButton1);
        make.top.mas_equalTo(iconButton1.mas_bottom).offset(10);
    }];

    

}
#pragma mark --------- 我的成交
-(void)positioningClick{
    MyReflectionViewController *vc=[[MyReflectionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --------- 我的分佣
-(void)positioningClick1{
    MyBrokerageViewController *vc=[[MyBrokerageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
