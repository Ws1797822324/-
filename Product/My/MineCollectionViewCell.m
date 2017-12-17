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
    if (kiPhone5s) {
        _label.font = kFont(7);
    }
}

-(void)setupWithImageName:(NSString*)imageName title:(NSString*)title{
    
    [self.imageView setImage:[UIImage imageNamed:imageName]];
    
    self.label.text = title;

    if (kiPhone5s) {
        _label.font = kFont(11);
    } else {
        _label.font = kFont(14);

    }

}

@end
