//
//  RecommendProperties_CCell.m
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RecommendProperties_CCell.h"

@implementation RecommendProperties_CCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTjModel:(Tj *)tjModel {

    _tjModel = tjModel;
    _name_L.text = tjModel.name;

    if (!kStringIsEmpty(tjModel.price) && [tjModel.price floatValue]>=0) {

        _price_L.text = [NSString stringWithFormat:@"%@万元起",tjModel.price];
        _price_L.hidden = NO;
    } else {
        _price_L.hidden = YES;

    }
    if (!kStringIsEmpty(tjModel.price) && [tjModel.price floatValue]>=0) {

        _priceS_L.text = [NSString stringWithFormat:@"%@元/㎡",tjModel.price_min_s];
    } else {
        _priceS_L.text = @"暂时未知";

    }
    [_img_V sd_setImageWithURL:[NSURL URLWithString:tjModel.pic] placeholderImage:kImageNamed(@"background_7")];
    _address_L.text = tjModel.address;
}
-(void)setTuijianModel:(Tuijian *)tuijianModel {

    _tuijianModel = tuijianModel;
    _name_L.text = tuijianModel.room_office;
    if (!kStringIsEmpty(tuijianModel.price) && [tuijianModel.price floatValue]>=0) {

        _price_L.text = [NSString stringWithFormat:@"%@万元起",tuijianModel.price];

    } else {
        _price_L.text = @"";
        _addressLayout.constant = 0;

    }
    _priceS_L.text = tuijianModel.area;
    [_img_V sd_setImageWithURL:[NSURL URLWithString:tuijianModel.pic_hx] placeholderImage:kImageNamed(@"background_7")];
    _address_L.text = tuijianModel.address;
}

@end
