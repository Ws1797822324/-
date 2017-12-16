//
//  PeopleDetails_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PeopleDetails_Cell.h"

@implementation PeopleDetails_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    kViewRadius( _qingYong_Btn,3);
    _imageVArr = @[_typeImage1,_typeImage2,_typeImage3,_typeImage4,_typeImage5,_typeImage6,_typeImage7,_typeImage8,_typeImage9];
    
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
    _money_L.text = price;

    _name_L.text = model.name;
    NSArray * a1 = [model.time componentsSeparatedByString:@"."];
    _time_L.text = [a1 firstObject];
    if ([model.com_status isEqualToString:@"0"]) {
        _type_L.text = @"未结佣";
        _type_L.textColor = kRGB_HEX(0x797979);

    } else {
        _type_L.text = @"已结佣";
        _type_L.textColor = [UIColor redColor];

    }


    for (int i = 0; i< [model.status intValue]; i++) {
        UIImageView * imgV = _imageVArr[i];
        imgV.image = kImageNamed(@"lansela");
    }


    if ([model.status intValue]>=7 && [model.apply intValue] == 0) { // 1  请过佣
        _qingYong_Btn.hidden = NO;
    } else {
        _qingYong_Btn.hidden = YES;

    }

}
@end
