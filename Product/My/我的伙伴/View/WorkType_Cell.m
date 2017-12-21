//
//  WorkType_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WorkType_Cell.h"

@implementation WorkType_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageVArr = @[_typeImage1,_typeImage2,_typeImage3,_typeImage4];
    kViewRadius(_qingYongButton, 3);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(LP *)model {
    _model = model;
    NSString * price = model.price;
    if ([price intValue] == 0) {
        price = @"售价待定";
    }
    _price_L.text = kString(@"%@元", price);
    _name_L.text = model.name;

    NSArray * a1 = [model.time componentsSeparatedByString:@"."];
    _time_L.text = [a1 firstObject];

    if ([model.com_status isEqualToString:@"0"]) {
        _type_L.text = @"未结佣";
    } else {
        _type_L.text = @"已结佣";

    }

    int k = [model.status intValue] - 1;
    if (k == 1) {
        k = 0;
    }

    for (int i = 0; i< k; i++) {

        UIImageView * imgV = _imageVArr[i];
        imgV.image = kImageNamed(@"lansela");
    }
    if (k == 4 && ([model.apply intValue] != 1)) {
        _qingYongButton.hidden = NO;
        _dixian_ImgV.hidden = NO;
    } else {
        _qingYongButton.hidden = YES;
        _dixian_ImgV.hidden = YES;

    }

}

-(void)setW_Model:(WorkTypeModel *)W_Model {
    _W_Model = W_Model;
    _name_L.text = W_Model.name;
    _time_L.text = W_Model.time;
    int k = [W_Model.status intValue] - 1;
    if (k == 1) {
        k = 0;
    }
    for (int i = 0; i< k; i++) {
        UIImageView * imgV = _imageVArr[i];
        imgV.image = kImageNamed(@"lansela");
    }


}


- (IBAction)qingYong:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(func:)]) {
        [_delegate func:sender.tag];
    }
}

@end
