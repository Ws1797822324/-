//
//  ChooseCity_VC.h
//  Product
//
//  Created by Sen wang on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ChooseCityNameBlock)(NSString * cityName);
@interface ChooseCity_VC : BaseViewController

@property (nonatomic ,copy) ChooseCityNameBlock chooseCityNameBlock;

@property (nonatomic ,strong) NSString *cityNameNow;

@property (nonatomic ,strong) NSString *chooseCity;


@end
