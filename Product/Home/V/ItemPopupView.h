//
//  ItemPopupView.h
//  Product
//
//  Created by  海跃尚 on 17/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemPopupView : UIView


@property (weak, nonatomic) IBOutlet UITextField *min_TF;

@property (weak, nonatomic) IBOutlet UITextField *max_TF;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmButton:(UIButton *)sender;

@end
