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
-(void)configViewRow:(NSInteger)row {
    _name_L.text = _nameArr[row];
    _text_L.text = @"暂时不详";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
