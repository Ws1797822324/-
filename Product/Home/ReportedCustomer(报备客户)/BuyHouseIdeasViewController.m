//
//  BuyHouseIdeasViewController.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BuyHouseIdeasViewController.h"

@interface BuyHouseIdeasViewController ()

@end

@implementation BuyHouseIdeasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购房意向";
    kViewRadius(self.sureBtn, 6);
    self.TF_firstMoney.text = _valueArray[0];
    self.TF_secondMoney.text = _valueArray[1];
    self.TF_firstArea.text = _valueArray[2];
    self.TF_secondArea.text = _valueArray[3];
    self.addressLabel.text = _valueArray[4];
    
}
#pragma mark -------- 选择地址区域
- (IBAction)chooseAddress:(UIButton *)sender {
    [self.view endEditing:YES];
    [BRAddressPickerView
     showAddressPickerWithDefaultSelected:@[ @9, @0, @0 ]
     isAutoSelect:NO
     resultBlock:^(NSArray *selectAddressArr) {
         self.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
     }];
}
#pragma mark ---------- 保存按钮事件
- (IBAction)sureClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSString * str1 = kStringIsEmpty(_TF_firstMoney.text)? @"" : _TF_firstMoney.text;
    NSString * str2 = kStringIsEmpty(_TF_secondMoney.text)? @"" : _TF_secondMoney.text;
    NSString * str3 = kStringIsEmpty(_TF_firstArea.text)? @"" : _TF_firstArea.text;
    NSString * str4 = kStringIsEmpty(_TF_secondArea.text)? @"" : _TF_secondArea.text;
    NSString * str5 = kStringIsEmpty(_addressLabel.text)? @"" : _addressLabel.text;

    self.valueBlock(@[str1,str2,str3,str4,str5]);

}


@end
