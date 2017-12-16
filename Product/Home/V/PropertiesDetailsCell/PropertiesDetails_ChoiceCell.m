//
//  PropertiesDetails_ChoiceTableViewCell.m
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_ChoiceCell.h"

@interface PropertiesDetails_ChoiceCell ()

@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;

@property (weak, nonatomic) IBOutlet UILabel *title_L;
@property (weak, nonatomic) IBOutlet UILabel *num_L;


@end

@implementation PropertiesDetails_ChoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configData:(NSInteger)section faNum:(NSString *)fnum dtNum:(NSString *)dtNum {
    if (section == 1) {
        [fnum intValue] == 0 ? (_icon_Img.hidden = YES) : (_icon_Img.hidden = NO);

        _name_L.text = @"佣金方案";
        _icon_Img.image = kImageNamed(@"hongxingxing");
        _num_L.textColor = kRGB_HEX(0x666666);
        _title_L.text = [NSString stringWithFormat:@"个方案"];
        _num_L.text = fnum;

    } else {
        [dtNum intValue] == 0 ? (_icon_Img.hidden = YES) : (_icon_Img.hidden = NO);

        _icon_Img.image = kImageNamed(@"hongtuoyuan");
        _num_L.textColor = kRGB_HEX(0xFF0000);
        _num_L.text = dtNum;
    }
}
@end
