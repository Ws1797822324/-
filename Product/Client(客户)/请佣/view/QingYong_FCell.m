//
//  QingYong_FCell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QingYong_FCell.h"

@implementation QingYong_FCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configCellView:(NSIndexPath *)indexPath {


    (indexPath.section == 0 || (indexPath.section == 2 && indexPath.row == 0)) ? (_rightImgV.hidden = NO) : (_rightImgV.hidden = YES);

    (indexPath.section == 0 || indexPath.section == 1) ? ( _xingImgV.hidden = NO) :(
        _xingImgV.hidden = YES);
    (indexPath.section == 1 || indexPath.section == 4) ? (_textField.hidden = NO) : (_textField.hidden = YES);
    if (indexPath.section == 2 && indexPath.row == 0) {
        _name_L.text = @"房屋详情";
        _xingImgV.hidden = YES;
        _textField.hidden = true;


    }
    _chooseType_L.hidden = YES;

    if (indexPath.section == 0) {
        _name_L.text = @"成交地址";

        _chooseType_L.hidden = NO;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        _name_L.text = @"客户姓名";
        _textField.placeholder = @"请输入姓名";

    }
if (indexPath.section == 1 && indexPath.row == 1) {
    _name_L.text = @"客户联系方式";

    _textField.placeholder = @"请输入联系方式";
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if (_textField.text.length >= 12) {
            _textField.text = [_textField.text substringToIndex:11];
        }
    }];
}
    if (indexPath.section == 4) {
        _textField.placeholder = @"请输入佣金数额(元)";
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _name_L.text = @"佣金";
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
