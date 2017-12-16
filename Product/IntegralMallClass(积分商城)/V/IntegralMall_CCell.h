//
//  IntegralMall_CCell.h
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralMall_CCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *jifenL;  // 传值用 不显示  不能删

@property (weak, nonatomic) IBOutlet UIButton *numButton;
@property (weak, nonatomic) IBOutlet UIImageView *image_View;

@property (nonatomic ,strong) IntegralMall_Model *model;

@end
