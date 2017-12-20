//
//  HouseXQ_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseXQ_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *text_L;
@property (weak, nonatomic) IBOutlet UILabel *name_L;

-(void)configViewRow:(NSInteger)row model:(FWXQ *)model;
@end
