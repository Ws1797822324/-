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
    _price_L.text = model.price;
    _minareaname_l.text = model.minareaname;
    _room_office.text = model.room_office;
    _area.text = model.area;
}

@end
