//
//  ChooseHouseTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChooseHouseTableViewCell.h"

@implementation ChooseHouseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.chooseBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.chooseBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    
    self.chooseBtn.userInteractionEnabled = NO;
    
}

- (IBAction)chooseClick:(UIButton *)sender {
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
