//
//  ChooseDredgeBankViewController.h
//  Product
//
//  Created by HJ on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDredgeBankViewController : UIViewController
@property (nonatomic, copy) void(^clickNoOrYes)(NSString * code);
@end
