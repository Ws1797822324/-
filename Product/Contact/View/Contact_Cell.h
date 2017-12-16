//
//  Contact_CellTableViewCell.h
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Contact_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageview;

@property (weak, nonatomic) IBOutlet UILabel *title_L;
@property (weak, nonatomic) IBOutlet UILabel *text_L;

@property (weak, nonatomic) IBOutlet UILabel *time_L;
@end
