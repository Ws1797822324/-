//
//  MyIntegral_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyIntegral_Cell.h"

@implementation MyIntegral_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(JiFenXQ *)model {
    _model = model;
    _name_L.text = model.client;
    _title_L.text = model.type;
    _address_L.text = model.product;
    NSArray * timeArr = [model.time componentsSeparatedByString:@"."];
    _title_L.text = [timeArr firstObject];
    _jifen_L.text =kString(@"+%@", model.integral);
}
@end
