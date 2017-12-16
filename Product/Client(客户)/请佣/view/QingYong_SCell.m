//
//  QingYong_SCell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QingYong_SCell.h"

@implementation QingYong_SCell

- (void)awakeFromNib {

    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)yesAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(reloadSections:)]) {
        [_delegate reloadSections:4];
    }
            [_yesBtn setImage:kImageNamed(@"xuanzhong") forState:UIControlStateNormal];
            [_noBtn setImage:kImageNamed(@"weixuanzhong") forState:UIControlStateNormal];
   

}

- (IBAction)noAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(reloadSections:)]) {
        [_delegate reloadSections:2];
    }
            [_noBtn setImage:kImageNamed(@"xuanzhong") forState:UIControlStateNormal];
            [_yesBtn setImage:kImageNamed(@"weixuanzhong") forState:UIControlStateNormal];

}
@end
