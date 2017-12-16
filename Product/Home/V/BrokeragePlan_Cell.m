//
//  BrokeragePlan_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BrokeragePlan_Cell.h"

@implementation BrokeragePlan_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YongJinFA *)model {
    _model = model;
    _title_L.text = model.title;
    _commission_L.text = model.commission;
}

@end
