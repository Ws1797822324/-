//
//  RecommendProperties_CCell.h
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendProperties_CCell : UICollectionViewCell

@property (nonatomic ,strong) Tj *tjModel;

@property (nonatomic ,strong) Tuijian *tuijianModel;


@property (weak, nonatomic) IBOutlet UIImageView *img_V;
@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *price_L;
@property (weak, nonatomic) IBOutlet UILabel *address_L;
@property (weak, nonatomic) IBOutlet UILabel *priceS_L;

@end
