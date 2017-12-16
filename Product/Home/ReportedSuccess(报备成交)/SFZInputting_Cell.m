//
//  SFZInputting_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SFZInputting_Cell.h"

@implementation SFZInputting_Cell

- (void)awakeFromNib {
    [super awakeFromNib];

    [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if (_sfz_TF.text.length >= 19) {
            _sfz_TF.text = [_sfz_TF.text substringToIndex:18];
        }

    }];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
