//
//  ActivityTableViewCell.h
//  Product
//
//  Created by HJ on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) ActivityListModel * model;

@property (nonatomic, copy) void(^lookAllBlock)();

@end
