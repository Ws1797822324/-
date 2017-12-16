//
//  WorkType_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PeopleDetailsModel.h"


@interface WorkType_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *qingYongButton;
@property (weak, nonatomic) IBOutlet UILabel *price_L;
@property (weak, nonatomic) IBOutlet UIImageView *dixian_ImgV;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage1;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage2;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage3;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage4;

@property (nonatomic, strong) NSArray *imageVArr;

@property (weak, nonatomic) IBOutlet UILabel *type_L;
@property (nonatomic ,strong) LP *model;
@property (nonatomic ,strong) WorkTypeModel *W_Model;

@property (weak, nonatomic) IBOutlet UILabel *time_L;

@property (weak, nonatomic) IBOutlet UILabel *name_L;

@property (nonatomic ,strong) NSString *status;


@end
