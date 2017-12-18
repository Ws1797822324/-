//
//  NewStayparticularsViewController.h
//  Product
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewStayparticularsViewController : UIViewController
@property(nonatomic,strong)NSString*type; // 判断是待结佣金还是已结佣金
@property (nonatomic, strong) NSString * ids;

@property (nonatomic ,strong) NSString *wsType;  //接口用

@end
