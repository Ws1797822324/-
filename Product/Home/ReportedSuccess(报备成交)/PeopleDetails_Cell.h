//
//  PeopleDetails_Cell.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PeopleDetailsModel.h"

@protocol qingYongSecondProtocol <NSObject>

- (void)func:(NSInteger) index;

@end


@interface PeopleDetails_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *type_L;
@property (weak, nonatomic) IBOutlet UIButton *qingYong_Btn;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage1;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage2;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage3;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage4;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage5;
@property (weak, nonatomic) IBOutlet UILabel *money_L;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage6;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage7;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage8;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage9;

@property (nonatomic ,strong) NSArray *imageVArr;

@property (nonatomic ,strong) LP *model;

@property (nonatomic ,weak) id <qingYongSecondProtocol> delegate;


@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *time_L;

@end
