//
//  PersonalDataThird_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConfigNameDate_VC.h"

@interface PersonalDataThird_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@property (nonatomic ,copy) NSString *sexType;

@end
