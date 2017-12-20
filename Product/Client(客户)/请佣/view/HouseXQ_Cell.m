//
//  HouseXQ_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseXQ_Cell.h"

@interface HouseXQ_Cell ()

@property (nonatomic ,copy) NSArray *nameArr;

@end

@implementation HouseXQ_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    _nameArr = @[@"面积",@"楼层",@"建筑类型",@"装修状况",@"产权年限",@"单价"];
    // Initialization code
}
-(void)configViewRow:(NSInteger)row model:(FWXQ *)model {
    _name_L.text = _nameArr[row];
    _text_L.text = @"暂时不详";
    if (row == 0) {
        kStringIsEmpty(model.covered_area) ?  (_text_L.text = @"暂时不详") : (_text_L.text = kString(@"%@㎡",  model.covered_area));
    }
    if (row == 1) {
        kStringIsEmpty(model.building_high) ?  (_text_L.text = @"暂时不详") : (_text_L.text = model.building_high);
    }
    if (row == 2) {
        kStringIsEmpty(model.building_types) ?  (_text_L.text = @"暂时不详") : (_text_L.text = model.building_types);
    }
    if (row == 3) {
        kStringIsEmpty(model.decoration) ?  (_text_L.text = @"暂时不详") : (_text_L.text = model.decoration);
    }
    if (row == 4) {
        kStringIsEmpty(model.age_limit) ?  (_text_L.text = @"暂时不详") : (_text_L.text = model.age_limit);
    }
    if (row == 5) {
        kStringIsEmpty(model.price) ?  (_text_L.text = @"暂时不详") : (_text_L.text = model.price);
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
