//
//  MyConcernCell.m
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyConcern_Cell.h"

@implementation MyConcern_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(AttentionListModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.allMoneyLabel.text = [NSString stringWithFormat:@"%@万元起",model.price];
    self.name.text = model.name;
    self.addressLabel.text = model.address;
    self.moneyLabel.text = kString(@"%@元/㎡", model.price_min_s);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
