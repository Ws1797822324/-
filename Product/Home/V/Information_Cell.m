//
//  Information_Cell.m
//  Product
//
//  Created by  海跃尚 on 17/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Information_Cell.h"

@implementation Information_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModelData:(InformationModel *)modelData {
    _modelData = modelData;
    _titleL.text = modelData.title;
    _browseL.text = modelData.browse;
    NSArray * tempArr = [modelData.time componentsSeparatedByString:@"."];
    _timeL.text = [XXHelper timeStampIntoimeDifference:tempArr[0]];
    _addressL.text = modelData.address;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:modelData.pic] placeholderImage:kImageNamed(@"background_4")];
}

@end
