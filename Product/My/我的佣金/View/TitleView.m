//
//  TitleView.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(void)awakeFromNib {
    [super awakeFromNib];
    _dMoney_L.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:23];
    _yMoney_L.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:23];
    _yMoney_L.textColor = [UIColor redColor];
    _dMoney_L.textColor = [UIColor redColor];
    
}

@end
