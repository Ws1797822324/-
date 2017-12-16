//
//  PropertiesDetails_FootView.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_FootView.h"

@implementation PropertiesDetails_FootView
-(void)awakeFromNib {
    [super awakeFromNib];
    kUserData;
    if ([userInfo.status intValue] == 1) {
        _kuan.constant = 0.0001;
    } else {
        _kuan.constant =kWidth * 0.33;

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
