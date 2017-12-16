//
//  MyExchange_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyExchange_Cell.h"

@implementation MyExchange_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(DuiHuan *)model {
    _model = model;
    _name_L.text = model.name;
    [_jifen setTitle:model.present_points forState:UIControlStateNormal];
}

@end
