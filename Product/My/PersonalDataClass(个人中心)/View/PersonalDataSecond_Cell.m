//
//  PersonalDataSecond_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonalDataSecond_Cell.h"

@implementation PersonalDataSecond_Cell

- (void)awakeFromNib {
    [super awakeFromNib];

    kViewRadius(_renzhengButton, 4);
    // Initialization code
    
    self.renzhengButton.userInteractionEnabled = NO;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
