//
//  ActivityTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    kViewRadius(self.timeLabel, 5);
    
}
- (IBAction)readAllClick:(id)sender {
    self.lookAllBlock();
}

- (void)setModel:(ActivityListModel *)model
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.timeLabel.text = kString(@"  %@  ", [XXHelper timeStampIntoimeDifference:model.time]);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"background_7"]];
    self.titleLabel.text = model.name;
    self.textsLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
