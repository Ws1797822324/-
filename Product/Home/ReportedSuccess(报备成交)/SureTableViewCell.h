//
//  SureTableViewCell.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIButton *sureBtn;
    @property (nonatomic, copy) void(^sureBlock)();
@end
