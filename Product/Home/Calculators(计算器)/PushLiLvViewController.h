//
//  PushLiLvViewController.h
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushLiLvViewController : UIViewController


@property (nonatomic ,strong) NSString *type;


@property (nonatomic, copy) void(^chooseLiLv)(NSString * type,float rate);
@end
@interface RateModel : NSObject

@property (nonatomic ,copy) NSString *num;
@property (nonatomic ,copy) NSString *name;


@end
