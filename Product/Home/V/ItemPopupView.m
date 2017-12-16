//
//  ItemPopupView.m
//  Product
//
//  Created by  海跃尚 on 17/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ItemPopupView.h"


@interface ItemPopupView ()

@end

@implementation ItemPopupView


- (IBAction)confirmButton:(UIButton *)sender {
    
    [kNoteCenter postNotificationName:@"ItemPopupViewTF" object:nil userInfo:@{
                                                _min_TF.text  : _max_TF.text
                                                                               }];

}
@end
