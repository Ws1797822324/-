//
//  ChooseSexTableViewCell.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSexTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIButton *nanBtn;
    @property (weak, nonatomic) IBOutlet UIButton *nvBtn;
    @property (nonatomic, copy) void(^sexBlock)(NSString * sex);
    
@end
