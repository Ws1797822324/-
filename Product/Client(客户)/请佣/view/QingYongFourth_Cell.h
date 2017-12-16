//
//  QingYongFourth_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QingYongFourth_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UITextField *money_TF;
@property (weak, nonatomic) IBOutlet UIImageView *right_Img;
@property (weak, nonatomic) IBOutlet UILabel *text_L;

-(void)configViewRow:(NSInteger )row;
@end
