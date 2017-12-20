//
//  ReportedSuccessList_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReportedSuccessList_Cell.h"

@implementation ReportedSuccessList_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(BaoBeiChengJiao *)model {
    _model = model;
    _name_L.text = model.name;
    _l_name_L.text = model.l_name;

    _time_L.text = [model.time stringByReplacingOccurrencesOfString:@".0" withString:@""];
//    NSMutableString * str = [[NSMutableString alloc]initWithString:model.phone];
//    [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _phone_L.text = model.phone;
    [_type_Btn setTitleColor:kRGB_HEX(0x0F83FA) forState:0];

    switch ([model.status intValue]) {
        case 0:
            [_type_Btn setTitle:@"签约" forState:0];
            break;
        case 1:
            [_type_Btn setTitle:@"按揭" forState:0];
            break;
        case 2:
            [_type_Btn setTitle:@"过户" forState:0];
            break;
        case 3:
            [_type_Btn setTitle:@"出件" forState:0];
            break;
        case 4:
            [_type_Btn setTitle:@"送抵押" forState:0];
            break;
        case 5:
            [_type_Btn setTitle:@"出抵押" forState:0];
            break;
        case 6:
            [_type_Btn setTitle:@"下款" forState:0];
            break;
        case 7:
            [_type_Btn setTitle:@"交房" forState:0];
            break;
        case 8:
            [_type_Btn setTitle:@"请佣" forState:0];
            break;
        case 9:
            [_type_Btn setTitle:@"结佣" forState:0];
            [_type_Btn setTitleColor:[UIColor redColor] forState:0];
            break;

        default:
            break;
    }
}
@end
