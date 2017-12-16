//
//  PropertiesDetails_ImportantCell.m
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_ImportantCell.h"

@implementation PropertiesDetails_ImportantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHxModel:(Hx *)hxModel {
    
    _hxModel = hxModel;
    _mj_L.text = hxModel.area;
    _name_L.text = hxModel.minareaname;
    _area_L.text = hxModel.room_office;
    _price_L.text = kString(@"%@元", hxModel.price);
    [_img_V sd_setImageWithURL:[NSURL URLWithString:hxModel.pic_hx] placeholderImage:kImageNamed(@"background_5")];
    
}

-(void)setGzHxModel:(AttentionListModel *)gzHxModel {
    _gzHxModel = gzHxModel;
    _mj_L.text = gzHxModel.address;
    _name_L.text = gzHxModel.title;
    _area_L.text = gzHxModel.name;
    _price_L.text = kString(@"%@元", gzHxModel.price);
    [_img_V sd_setImageWithURL:[NSURL URLWithString:gzHxModel.pic] placeholderImage:kImageNamed(@"background_5")];

}
@end
