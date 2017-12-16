//
//  NewsXiaoXiCell.h
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsModel.h"

@interface NewsXiaoXiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *text_L;
@property (nonatomic ,strong) NewsModel *model;
@property (weak, nonatomic) IBOutlet UILabel *time_L;




@end
