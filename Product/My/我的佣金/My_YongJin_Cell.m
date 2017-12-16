//
//  My_ Default_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "My_YongJin_Cell.h"

@implementation My_YongJin_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CommissionListModel *)model {
    _model = model;
    _name_L.text = model.name;
    _phone_L.text = model.phone;
    _address_L.text = model.l_id;
    _money_L.text = model.brokerage;
    _time_L.text = model.nodealtime;

    
}
@end
