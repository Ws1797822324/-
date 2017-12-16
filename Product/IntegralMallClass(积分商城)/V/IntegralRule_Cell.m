//
//  IntegralRule_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IntegralRule_Cell.h"

@implementation IntegralRule_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(JiFenGXModel *)model {
    _model = model;
    _text_LF.text = model.type;
    _text_LS.text = kString(@" + %@", model.points);
}

@end
