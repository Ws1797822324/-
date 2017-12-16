//
//  MyConcernCell.h
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionListModel.h"

@interface MyConcern_Cell : UITableViewCell
@property (nonatomic, strong) AttentionListModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
