//
//  PhoneInputting_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhoneInputting_Cell.h"

@implementation PhoneInputting_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[kNoteCenter rac_addObserverForName:@"deleteTextFieldValue" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        _left_TF.text = @"";
        _right_TF.text = @"";
    }];
    [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {

        if (_left_TF.text.length >= 4) {
            _left_TF.text = [_left_TF.text substringToIndex:3];
        }

        if (_right_TF.text.length >= 5) {
            _right_TF.text = [_right_TF.text substringToIndex:4];
        }

    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
