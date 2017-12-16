//
//  PropertiesDetails_HeaderCell.m
//  Product
//
//  Created by  海跃尚 on 17/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_HeaderCell.h"


@interface PropertiesDetails_HeaderCell ()

@property (nonatomic, strong) SQButtonTagView *tagsView;


@end


@implementation PropertiesDetails_HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) cinfigTagsView:(NSArray *)arr {

    if (arr.count != 0) {  //  占位不然 mas 会蹦

    self.tagsView = [[SQButtonTagView alloc]initWithTotalTagsNum:arr.count viewWidth:_tagsViewTool.width eachNum:0 Hmargin:10 Vmargin:5 tagHeight:20 tagTextFont:kBoldFont(12) tagTextColor:kRGB_HEX(0x66a8fc) selectedTagTextColor:kRGB_HEX(0x66a8fc) selectedBackgroundColor:kRGB_HEX(0xf3f3f3)];

    _tagsView.maxSelectNum = 1;

    [_tagsViewTool addSubview:_tagsView];

    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(_tagsViewTool);
    }];
    self.tagsView.tagTexts = arr;
        self.tagsViewToolLayout.constant = [SQButtonTagView returnViewHeightWithTagTexts:arr viewWidth:_tagsViewTool.width eachNum:0 Hmargin:10 Vmargin:5 tagHeight:20 tagTextFont:kBoldFont(12)];

    } else {
        self.tagsViewToolLayout.constant = 0.001;
    }

}
@end
