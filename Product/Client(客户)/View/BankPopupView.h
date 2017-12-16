//
//  BankPopupView.h
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankPopupView : UIView

@property (weak, nonatomic) IBOutlet UIButton *renZhengButton;
@property (weak, nonatomic) IBOutlet UIButton *quxiaoBtn;

- (IBAction)quXiaoButton:(UIButton *)sender;
@end
