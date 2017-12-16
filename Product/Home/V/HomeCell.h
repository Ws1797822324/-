//
//  HomeCell.h
//  WWSS
//
//  Created by  海跃尚 on 17/11/2.
//  Copyright © 2017年  海跃尚. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SQButtonTagView.h"

@interface HomeCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UIView *tagsViewTool;
@property (weak, nonatomic) IBOutlet UIView *tagsViewTool;


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *address_L;
@property (weak, nonatomic) IBOutlet UILabel *price_L;
@property (weak, nonatomic) IBOutlet UILabel *juli_L;

@property (nonatomic ,strong) HouseModel *model;



@end
