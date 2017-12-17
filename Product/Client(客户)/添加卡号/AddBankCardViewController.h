//
//  AddBankCardViewController.h
//  Product
//
//  Created by HJ on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddBankCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TF_name;
@property (weak, nonatomic) IBOutlet UITextField *TF_bankcode;
@property (weak, nonatomic) IBOutlet UITextField *TF_bankname;
@property (weak, nonatomic) IBOutlet UITextField *TF_usercode;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *button_F;
@property (weak, nonatomic) IBOutlet UIButton *button_S;

@end
