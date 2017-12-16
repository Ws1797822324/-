//
//  ConfigNameDate_VC.h
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigNameDate_VC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *data_TF;
@property (weak, nonatomic) IBOutlet UILabel *nianL;

@property (nonatomic,assign) int type;
@property (nonatomic ,copy) NSString *oldStr;



@end
