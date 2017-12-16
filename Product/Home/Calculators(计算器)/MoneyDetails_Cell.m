//
//  MoneyDetailsA_Cell.m
//  Product
//
//  Created by Sen wang on 2017/12/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MoneyDetails_Cell.h"

@implementation MoneyDetails_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configMonty:(NSInteger)row {
    NSArray * arr = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    _monty_L.text = arr[row];
}

-(void)configYGZE:(NSString *)monthRepayment {
    _ygze_L.text = monthRepayment;

}
#pragma mark - 设置月供本金
-(void)configYGBJ:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row {

    NSInteger kk = 12 * section + row;

    _ygbj_L.text = ygbjArray[kk];

}

#pragma mark - 设置月供利息
-(void)configYGLX:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row YGZE:(NSString *)ygze {
    NSInteger kk = 12 * section + row;

    _yglx_L.text = kString(@"%.2f", ([ygze floatValue] - [ygbjArray[kk] floatValue]));
}

-(void)configYGLX:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row bj:(float)bj {
    NSInteger kk = 12 * section + row;

    _yglx_L.text = kString(@"%.2f", [ygbjArray[kk] floatValue]  - bj);
}
// MARK: ------ 设施剩余 ------
-(void)ConfigRemainder:(NSArray *) arr Section:(NSInteger)section Row:(NSInteger)row{
    NSInteger kk = 12 * section + row;
    [(NSMutableArray *) arr replaceObjectAtIndex:arr.count - 1 withObject:@"0.00"];
    _remainder_L.text = arr[kk];


    
}
@end
