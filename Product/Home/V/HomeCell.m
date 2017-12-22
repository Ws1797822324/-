//
//  HomeCell.m
//  WWSS
//
//  Created by  海跃尚 on 17/11/2.
//  Copyright © 2017年  海跃尚. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()


@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (void)setModel:(HouseModel *)model {
    _model = model;
    _name_L.text = model.name;
    _address_L.text = _model.address;
    _price_L.text = kStringIsEmpty(model.price) ? @"售价待定" : (kString(@"%@万元起", model.price));
    _price_L.text =
        ([model.price floatValue] == 0) ? @"售价待定" : (kString(@"%@万元起", model.price));

    _juli_L.text = [NSString stringWithFormat:@"%@km", model.juli];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.pic]
                placeholderImage:kImageNamed(@"timg-2")];

}

- (void)tagsData:(NSArray *)arr {

    NSMutableArray *mArr = [NSMutableArray array];
    if (arr.count >= 3) {

        for (int i = 0; i < 3; i++) {
            [mArr addObject:[arr[i] name]];
        }

    } else {
        for (Label * kk in arr) {
            [mArr addObject:kk.name];
        };
    }


    if (arr.count == 0) {
        self.tagsView_H.constant = 20;

        return;
    } else {

        self.tagsView = [[SQButtonTagView alloc] initWithTotalTagsNum:3
                                                            viewWidth:kWidth - 170
                                                              eachNum:0
                                                              Hmargin:6
                                                              Vmargin:5
                                                            tagHeight:20
                                                          tagTextFont:kBoldFont(12)
                                                         tagTextColor:kRGB_HEX(0x66a8fc)
                                                 selectedTagTextColor:kRGB_HEX(0x66a8fc)
                                              selectedBackgroundColor:kRGB_HEX(0xf3f3f3)];

        _tagsView.maxSelectNum = 1;
        [_tagsViewTool addSubview:_tagsView];

        _tagsView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

        self.tagsView.tagTexts = mArr;
        _tagsView_H.constant = [SQButtonTagView returnViewHeightWithTagTexts:mArr
                                                                   viewWidth:kWidth - 170
                                                                     eachNum:0
                                                                     Hmargin:6
                                                                     Vmargin:5
                                                                   tagHeight:20
                                                                 tagTextFont:kBoldFont(12)];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
