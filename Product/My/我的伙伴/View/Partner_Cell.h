//
//  Partner_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Partner_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *phone_L;
@property (weak, nonatomic) IBOutlet UILabel *time_L;

@property (nonatomic ,strong) MyPartner_Model *model;


@end
