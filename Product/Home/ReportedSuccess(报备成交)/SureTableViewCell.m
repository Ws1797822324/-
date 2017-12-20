//
//  SureTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SureTableViewCell.h"

@implementation SureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    kViewRadius(self.sureBtn, 6);
    self.sureBtn.mm_acceptEventInterval = 2;
}
- (IBAction)sureClick:(id)sender {
//    self.sureBlock();
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
