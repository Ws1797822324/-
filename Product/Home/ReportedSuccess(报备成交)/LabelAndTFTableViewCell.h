//
//  LabelAndTFTableViewCell.h
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelAndTFTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UITextField *TF_title;
    @property (weak, nonatomic) IBOutlet UILabel *yuanLabel;
    
@end
