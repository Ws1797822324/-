//
//  MainCalculatorsViewController.h
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCalculatorsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *monthMoney;
@property (weak, nonatomic) IBOutlet UILabel *MoneyTwo;
@property (weak, nonatomic) IBOutlet UILabel *titleTwo;

@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeDetailsLabel;

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UITextField *TF_money;
@property (weak, nonatomic) IBOutlet UITextField *TF_year;
@property (weak, nonatomic) IBOutlet UIButton *liLvBtn;
@property (weak, nonatomic) IBOutlet UIButton *BXBtn;
@property (weak, nonatomic) IBOutlet UIButton *BJBtn;

// 综合用
@property (weak, nonatomic) IBOutlet UIView *view1; // 公积金贷款View
@property (weak, nonatomic) IBOutlet UIView *view2; // 公积金利率View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1Layout;

@property (weak, nonatomic) IBOutlet UITextField *money_TF;

- (IBAction)lilvTwoAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *lilvTwo;




@end
