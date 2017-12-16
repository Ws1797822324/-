//
//  MoneyDetails_VC.h
//  Product
//
//  Created by Sen wang on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WMPageController.h"
#import "LXFHouseLoanCalculator.h"

@interface MoneyDetails_VC : WMPageController
@property (nonatomic ,strong) NSString *str1;
@property (nonatomic ,strong) NSString *str2;
@property (nonatomic ,strong) NSString *str3;
@property (nonatomic ,strong) NSString *str4;

@property (nonatomic ,assign) NSInteger vcType;

// 算利息用  本金
@property (nonatomic, strong) LXFHouseLoanCalcModel *calcModel;



@property (nonatomic, assign) int DKType;

@end
