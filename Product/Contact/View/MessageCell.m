//
//  MessageCellTableViewCell.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    kViewRadius(_time_L, 3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsModel *)model {
    _model = model;
    _name_L.text = model.title;
    _time_L.text =  kString(@"  %@  ", [XXHelper timeStampIntoimeDifference:model.time]);
    _text_L.text =  [XXHelper stringRemovetheHTMLtags:model.morning_paper];
}
@end
