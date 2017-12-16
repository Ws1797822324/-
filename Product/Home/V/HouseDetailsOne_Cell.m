//
//  HouseDetailsOne_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseDetailsOne_Cell.h"

@interface HouseDetailsOne_Cell ()

@property (nonatomic, strong) SQButtonTagView *tagsView;


@end

@implementation HouseDetailsOne_Cell

- (void)awakeFromNib {
    [super awakeFromNib];




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


-(void)setModel:(Huxingxinxi *)model {
    _model = model;
    NSString * syr = @"【在售】";
    if ([model.status intValue] != 1) {
        syr = @"【预售】";
    }
    _minareaname_l.text = model.minareaname;
    _room_office.text = [NSString stringWithFormat:@"%@%@",model.room_office,syr];
    _area.text = model.area;
    _decoration_L.text = model.decoration;
    _room_rate_L.text = kString(@"得房率:%@", model.room_rate);
}

@end
