//
//  QingYong_TCell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QingYong_TCell.h"

@implementation QingYong_TCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textView.xx_placeholder = @"请填写房屋的特殊情况";
    _textView.xx_placeholderFont = kFont(14);
    _textView.xx_placeholderColor = kRGB_HEX(0xD6D6D6);

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
