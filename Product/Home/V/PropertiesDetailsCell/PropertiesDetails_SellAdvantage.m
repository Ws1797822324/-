//
//  PropertiesDetails_SellAdvantage.m
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_SellAdvantage.h"

@implementation PropertiesDetails_SellAdvantage


-(void)awakeFromNib {
    
    [super awakeFromNib];


}

-(void) buttonColor:(NSInteger) index{
    kWeakSelf;
    
    switch (index) {
        case 1:

            [weakSelf.jiaoyuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaoyuL.backgroundColor = [UIColor blackColor];

            [weakSelf.jiaotongBtn setTitleColor:kRGB_HEX(0x66A8FC) forState:UIControlStateNormal];
            weakSelf.jiaotongL.backgroundColor = kRGB_HEX(0x66A8FC);

            [weakSelf.yiliaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.yiliaoL.backgroundColor = [UIColor blackColor];

            [weakSelf.canyinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.canyinL.backgroundColor = [UIColor blackColor];


            break;
        case 2:
            [weakSelf.jiaotongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaotongL.backgroundColor = [UIColor blackColor];

            [weakSelf.jiaoyuBtn setTitleColor:kRGB_HEX(0x66A8FC) forState:UIControlStateNormal];
            weakSelf.jiaoyuL.backgroundColor = kRGB_HEX(0x66A8FC);

            [weakSelf.yiliaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.yiliaoL.backgroundColor = [UIColor blackColor];

            [weakSelf.canyinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.canyinL.backgroundColor = [UIColor blackColor];

            break;
        case 3:

            [weakSelf.jiaoyuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaoyuL.backgroundColor = [UIColor blackColor];

            [weakSelf.yiliaoBtn setTitleColor:kRGB_HEX(0x66A8FC) forState:UIControlStateNormal];
            weakSelf.yiliaoL.backgroundColor = kRGB_HEX(0x66A8FC);

            [weakSelf.jiaotongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaotongL.backgroundColor = [UIColor blackColor];

            [weakSelf.canyinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.canyinL.backgroundColor = [UIColor blackColor];

            break;
        case 4:
            [weakSelf.jiaotongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaotongL.backgroundColor = [UIColor blackColor];

            [weakSelf.canyinBtn setTitleColor:kRGB_HEX(0x66A8FC) forState:UIControlStateNormal];
            weakSelf.canyinL.backgroundColor = kRGB_HEX(0x66A8FC);

            [weakSelf.yiliaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.yiliaoL.backgroundColor = [UIColor blackColor];

            [weakSelf.jiaoyuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.jiaoyuL.backgroundColor = [UIColor blackColor];
            
            break;

        default:
            break;
    }


}


- (IBAction)jiaotong:(UIButton *)sender {
    [self buttonColor:1];
    if( [_delegate respondsToSelector:@selector(clockButton:)]) {
        [_delegate clockButton:1];
    }
}
- (IBAction)jiaoyu:(UIButton *)sender {
    [self buttonColor:2];
    if( [_delegate respondsToSelector:@selector(clockButton:)]) {
    [_delegate clockButton:2];
    }
}
- (IBAction)yiliao:(UIButton *)sender {
    if( [_delegate respondsToSelector:@selector(clockButton:)]) {
        [_delegate clockButton:3];
    }
    [self buttonColor:3];

}
- (IBAction)canyin:(UIButton *)sender {
    if( [_delegate respondsToSelector:@selector(clockButton:)]) {
        [_delegate clockButton:4];
    }

    [self buttonColor:4];

}




@end
