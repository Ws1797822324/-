//
//  QingYongFourth_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QingYongFourth_Cell.h"

@implementation QingYongFourth_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configViewRow:(NSInteger )row{
    
    if (row == 2) {
        _name_L.text = @"贷款类型";
        _right_Img.hidden = NO;
        _money_TF.hidden = YES;
        _text_L.hidden = NO;
        _text_L.text = @"商业贷款";

    } else {
        _name_L.text = @"贷款金额";
        _right_Img.hidden = YES;
        _money_TF.hidden = NO;
        _text_L.hidden = YES;


    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
