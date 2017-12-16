//
//  LocationList_VC.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AddressBlock)(NSString * selectValue);
@interface LocationList_VC : BaseViewController
@property (nonatomic ,strong) NSString *khID;
@property (nonatomic ,copy) AddressBlock addressBlock;

@property (nonatomic ,strong) NSString  *selectId;



@end
