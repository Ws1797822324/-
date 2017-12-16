//
//  BuyHouseIdeasViewController.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ValueBlock)(NSArray *valve);

@interface BuyHouseIdeasViewController : UIViewController
    @property (weak, nonatomic) IBOutlet UITextField *TF_firstMoney;
    @property (weak, nonatomic) IBOutlet UITextField *TF_secondMoney;
    @property (weak, nonatomic) IBOutlet UITextField *TF_firstArea;
    @property (weak, nonatomic) IBOutlet UITextField *TF_secondArea;
    @property (weak, nonatomic) IBOutlet UILabel *addressLabel;
    @property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic ,copy) ValueBlock valueBlock;
@property (nonatomic ,strong) NSArray *valueArray;

@end
