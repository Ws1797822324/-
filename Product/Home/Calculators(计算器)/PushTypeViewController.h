//
//  PushTypeViewController.h
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushTypeViewController : UIViewController
@property (nonatomic, copy) void(^chooseType)(NSString * type, int Num);
@end
