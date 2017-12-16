//
//  MoneyDetailsA_Cell.h
//  Product
//
//  Created by Sen wang on 2017/12/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyDetails_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monty_L;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label_W;

/** 月供利息 */
@property (weak, nonatomic) IBOutlet UILabel *yglx_L;
-(void)configYGLX:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row YGZE:(NSString *)ygze;
// 等额本金用  B
-(void)configYGLX:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row  bj:( float)bj;

-(void)configMonty:(NSInteger)row;
/** 剩余 */
@property (weak, nonatomic) IBOutlet UILabel *remainder_L;
-(void)ConfigRemainder:(NSArray *) arr Section:(NSInteger)section Row:(NSInteger)row;


/**
 设置月供总额
 */
-(void)configYGZE:(NSString *)monthRepayment;
@property (weak, nonatomic) IBOutlet UILabel *ygze_L;



/** 月供本金 */
-(void)configYGBJ:(NSArray *)ygbjArray Section:(NSInteger)section Row:(NSInteger)row ;
@property (weak, nonatomic) IBOutlet UILabel *ygbj_L;
@end
