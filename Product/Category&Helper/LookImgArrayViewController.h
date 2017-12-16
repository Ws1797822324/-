//
//  LookImgArrayViewController.h
//  Jewelry
//
//  Created by HJ on 2017/4/5.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LookImgArrayViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * imgArray;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) void (^myClick)(int num);

@end
