//
//  PhoneInputting_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyInputTextField.h"
@interface PhoneInputting_Cell : UITableViewCell 

@property (weak, nonatomic) IBOutlet UITextField *left_TF;
@property (weak, nonatomic) IBOutlet KeyInputTextField *right_TF;

@property (weak, nonatomic) IBOutlet UILabel *xingxing_L;

@end
