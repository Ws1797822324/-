//
//  DZDeleteButton.h
//  Product
//
//  Created by Sen wang on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDeleteButton;

@protocol DZDeleteButtonDelegate

@optional
// 点击右上角按钮
- (void)deleteButtonRemoveSelf:(XXDeleteButton *)button;
//长按
-(void)longClickAction:(UIButton *)button;

@end

@interface XXDeleteButton : UIButton

@property (nonatomic, weak) id delegate;

@end
