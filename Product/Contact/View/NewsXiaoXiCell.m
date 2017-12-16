//
//  NewsXiaoXiCell.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsXiaoXiCell.h"

@implementation NewsXiaoXiCell

- (void)awakeFromNib {
    [super awakeFromNib];

    kViewRadius(_time_L, 3);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsModel *)model {
    _model = model;
    _time_L.text =  kString(@"  %@  ", [XXHelper timeStampIntoimeDifference:model.time]);
    _text_L.text = model.title;
}

@end
