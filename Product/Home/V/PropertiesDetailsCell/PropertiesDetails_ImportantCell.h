//
//  PropertiesDetails_ImportantCell.h
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionListModel.h"
@interface PropertiesDetails_ImportantCell : UITableViewCell
@property (nonatomic ,strong) Hx *hxModel;

@property (weak, nonatomic) IBOutlet UIImageView *img_V;
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *price_L;
@property (weak, nonatomic) IBOutlet UILabel *mj_L;
@property (weak, nonatomic) IBOutlet UILabel *area_L;

@property (nonatomic ,strong) AttentionListModel *gzHxModel;


@end
