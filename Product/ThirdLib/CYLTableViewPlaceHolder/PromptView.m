//
//  PromptView.m
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PromptView.h"


@implementation PromptView

-(void)awakeFromNib {
    [super awakeFromNib];
    kViewRadius(_confirmButton, 5);   
    
    [[_confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [KLCPopup dismissAllPopups];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
