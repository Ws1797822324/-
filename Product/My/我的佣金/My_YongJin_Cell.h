//
//  My_ Default_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommissionListModel.h"

@interface My_YongJin_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *address_L;
@property (weak, nonatomic) IBOutlet UILabel *phone_L;
@property (weak, nonatomic) IBOutlet UILabel *money_L;
@property (weak, nonatomic) IBOutlet UILabel *time_L;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *time_L_TopLayout;

@property (nonatomic ,strong) CommissionListModel *model;

@end
