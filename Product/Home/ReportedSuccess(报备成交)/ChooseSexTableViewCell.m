//
//  ChooseSexTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChooseSexTableViewCell.h"

@implementation ChooseSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.nanBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.nanBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self.nvBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.nvBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    
    self.nanBtn.selected = YES;
    self.nvBtn.selected = NO;
    
}
- (IBAction)nanClick:(id)sender {
    self.nanBtn.selected = YES;
    self.nvBtn.selected = NO;
    self.sexBlock(@"0");
}
- (IBAction)nvClick:(id)sender {
    self.nanBtn.selected = NO;
    self.nvBtn.selected = YES;
    self.sexBlock(@"1");
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
