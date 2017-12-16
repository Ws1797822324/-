//
//  MoneyDetailsA_VC.h
//  Product
//
//  Created by Sen wang on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXFHouseLoanCalculator.h"

@interface MoneyDetailsA_VC : UIViewController

@property (nonatomic ,strong) NSString *str1;
@property (nonatomic ,strong) NSString *str2;
@property (nonatomic ,strong) NSString *str3;
@property (nonatomic ,strong) NSString *str4;

@property (nonatomic, assign) int DKType;
@property (nonatomic, strong) LXFHouseLoanResultModel *resultModel;
@property (nonatomic, strong) LXFHouseLoanCalcModel *calcModel;




@end
