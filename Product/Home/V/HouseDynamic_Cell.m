//
//  HouseDynamic_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseDynamic_Cell.h"

@implementation HouseDynamic_Cell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    // Initialization code
}
-(void)setModel:(YongJinFA *)model {
    _model = model;
        NSAttributedString * attrStr = [[NSAttributedString alloc]initWithData:[model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _text_L.attributedText = attrStr;
    _time_L.text = model.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
