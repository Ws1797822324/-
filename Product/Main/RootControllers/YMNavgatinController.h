//
//  YMNavgatinController.h
//  YMMY
//
//  Created by apple on 2017/3/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum YMNavgatinControllerType{
    YMNavgatinControllerTypeClear = 1,
    YMNavgatinControllerTypeBlue = 2,

}YMNavgatinControllerType;

@interface YMNavgatinController : UINavigationController

-(void)pushViewController:(UIViewController *)viewController type:(YMNavgatinControllerType)type animated:(BOOL)animated;


-(UIViewController *)popViewControllerAnimated:(BOOL)animated type:(YMNavgatinControllerType)type;


@end
