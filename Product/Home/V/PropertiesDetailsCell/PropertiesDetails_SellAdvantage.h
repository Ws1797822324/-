//
//  PropertiesDetails_SellAdvantage.h
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol buttonActionDelegate <NSObject>

-(void) clockButton:(NSInteger)index;
@end
@interface PropertiesDetails_SellAdvantage : UIView

@property (nonatomic ,weak) id <buttonActionDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIButton *jiaotongBtn;

@property (weak, nonatomic) IBOutlet UIButton *jiaoyuBtn;

@property (weak, nonatomic) IBOutlet UIButton *yiliaoBtn;

@property (weak, nonatomic) IBOutlet UIButton *canyinBtn;


@property (weak, nonatomic) IBOutlet UILabel *jiaotongL;

@property (weak, nonatomic) IBOutlet UILabel *jiaoyuL;

@property (weak, nonatomic) IBOutlet UILabel *yiliaoL;

@property (weak, nonatomic) IBOutlet UILabel *canyinL;

-(void) buttonColor:(NSInteger) index;
@end
