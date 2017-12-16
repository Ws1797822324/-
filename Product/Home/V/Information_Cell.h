//
//  Information_Cell.h
//  Product
//
//  Created by  海跃尚 on 17/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Information_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UILabel *browseL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (nonatomic, strong) InformationModel *modelData;

@end
