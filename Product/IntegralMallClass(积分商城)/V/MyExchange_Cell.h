//
//  MyExchange_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyExchange_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UIButton *jifen;
@property (weak, nonatomic) IBOutlet UIButton *type_B;
@property (nonatomic ,strong) DuiHuan *model;


@end
