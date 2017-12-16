//
//  HouseDetailsOne_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseDetailsOne_Cell : UITableViewCell


// 滚动视图
@property (weak, nonatomic) IBOutlet UIView *toolView1;

// 标签
@property (weak, nonatomic) IBOutlet UIView *toolView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolView2Height;
-(void) cinfigTagsView:(NSArray *)arr;
@property (weak, nonatomic) IBOutlet UILabel *price_L;
@property (weak, nonatomic) IBOutlet UILabel *minareaname_l;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *room_office;

@property (nonatomic ,strong) Huxingxinxi *model;


@end
