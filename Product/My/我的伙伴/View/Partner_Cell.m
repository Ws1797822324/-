//
//  Partner_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Partner_Cell.h"

@implementation Partner_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MyPartner_Model *)model {
    _model = model;
    _name_L.text = model.name;
    _phone_L.text = model.phone;

    _time_L.text = [[model.time componentsSeparatedByString:@"."] firstObject];
    _phone_L.hidden = model.type;
}

@end
