//
//  BankPopupView.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BankPopupView.h"

@implementation BankPopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib {
    [super awakeFromNib];
    kViewRadius(_quxiaoBtn, 4);
    kViewRadius(_renZhengButton, 4);
}
- (IBAction)quXiaoButton:(UIButton *)sender {
    [KLCPopup dismissAllPopups];
}
@end
