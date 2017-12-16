//
//  QingYong_FCell.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QingYong_FCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UIImageView *xingImgV;

@property (weak, nonatomic) IBOutlet UILabel *chooseType_L;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;

-(void)configCellView:(NSIndexPath *)indexPath;


@end
