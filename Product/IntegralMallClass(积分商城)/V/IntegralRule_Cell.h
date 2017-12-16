//
//  IntegralRule_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IntegralRule_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *text_LF;
@property (weak, nonatomic) IBOutlet UILabel *text_LS;

@property (nonatomic ,strong) JiFenGXModel *model;

@end
