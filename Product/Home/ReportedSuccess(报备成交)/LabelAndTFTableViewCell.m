//
//  LabelAndTFTableViewCell.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LabelAndTFTableViewCell.h"

@implementation LabelAndTFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[kNoteCenter rac_addObserverForName:@"deleteTextFieldValue" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        _TF_title.text = @"";
    }];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
