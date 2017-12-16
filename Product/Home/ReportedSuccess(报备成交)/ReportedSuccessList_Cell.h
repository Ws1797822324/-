//
//  ReportedSuccessList_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportedSuccessList_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phone_L;
@property (nonatomic ,strong) BaoBeiChengJiao *model;
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *l_name_L;
@property (weak, nonatomic) IBOutlet UILabel *time_L;

@property (weak, nonatomic) IBOutlet UIButton *type_Btn;
@end
