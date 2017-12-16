//
//  MyIntegral_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyIntegral_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_L;
@property (weak, nonatomic) IBOutlet UILabel *time_L;

@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *address_L;

@property (weak, nonatomic) IBOutlet UILabel *jifen_L;

@property (nonatomic ,strong) JiFenXQ *model;

@end

