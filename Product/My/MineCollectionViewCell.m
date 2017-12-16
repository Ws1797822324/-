//
//  MineCollectionViewCell.m
//  经纪人
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MineCollectionViewCell.h"
@interface MineCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end
@implementation MineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label.textColor = [UIColor blackColor];
}

-(void)setupWithImageName:(NSString*)imageName title:(NSString*)title{
    
    [self.imageView setImage:[UIImage imageNamed:imageName]];
    
    self.label.text = title;
    self.label.font=[UIFont systemFontOfSize:14];
}

@end
