//
//  BrokeragePlan_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokeragePlan_Cell : UITableViewCell

@property (nonatomic ,strong) YongJinFA *model;

@property (weak, nonatomic) IBOutlet UILabel *title_L;

@property (weak, nonatomic) IBOutlet UILabel *commission_L;
@end
