//
//  RemarkTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RemarkTableViewCell.h"

@implementation RemarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textView.xx_placeholder = @"请填写客户的特殊要求，如靠近公园、海边等。";
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
