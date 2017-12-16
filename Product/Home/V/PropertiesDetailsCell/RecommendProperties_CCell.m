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


    _price_L.text = [NSString stringWithFormat:@"%@万元起",tjModel.price];
    _priceS_L.text = [NSString stringWithFormat:@"%@元/㎡",tjModel.price_min_s];
    [_img_V sd_setImageWithURL:[NSURL URLWithString:tjModel.pic] placeholderImage:kImageNamed(@"background_7")];
    _address_L.text = tjModel.address;
}
-(void)setTuijianModel:(Tuijian *)tuijianModel {

    _tuijianModel = tuijianModel;
    _name_L.text = tuijianModel.room_office;

    _price_L.text = [NSString stringWithFormat:@"%@万元起",tuijianModel.price];
    _priceS_L.text = tuijianModel.area;
    [_img_V sd_setImageWithURL:[NSURL URLWithString:tuijianModel.pic_hx] placeholderImage:kImageNamed(@"background_7")];
    _address_L.text = tuijianModel.address;
}

@end
