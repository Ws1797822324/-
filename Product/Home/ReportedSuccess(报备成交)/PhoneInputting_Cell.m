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

    [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        _background_TF.text = _phone_TF.text;
        if (_phone_TF.text.length >= 12) {
            _phone_TF.text = [_phone_TF.text substringToIndex:11];
            _background_TF.text = [_phone_TF.text substringToIndex:11];
        }
        if (_phone_TF.text.length == 4) {
            _background_TF.text = kString(@"%@*", [_phone_TF.text substringToIndex:3]);
        }
        if (_phone_TF.text.length == 5) {
            _background_TF.text = kString(@"%@**", [_phone_TF.text substringToIndex:3]);
        }
        if (_phone_TF.text.length == 6) {
            _background_TF.text = kString(@"%@***", [_phone_TF.text substringToIndex:3]);
        }
        if (_phone_TF.text.length == 7) {
            _background_TF.text = kString(@"%@****", [_phone_TF.text substringToIndex:3]);
        }
        if (_phone_TF.text.length > 7) {
            _background_TF.text = [NSString stringWithFormat:@"%@****%@",[_phone_TF.text substringToIndex:3],[_phone_TF.text substringFromIndex:7]];
        }


    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
