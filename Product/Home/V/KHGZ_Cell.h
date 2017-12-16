//
//  KHGZ_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHGZ_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_L;
@property (weak, nonatomic) IBOutlet UILabel *text_L;

@property (nonatomic ,strong) KHGZModel *model;

@end
