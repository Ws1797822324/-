//
//  HousesViewController.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedBlock) (NSArray *selectedBlockArray);

typedef void (^PhoneTypeBlock)(int phoneType);

@interface HousesViewController : UIViewController

@property (nonatomic ,copy) SelectedBlock selectedBlock ;
@property (nonatomic ,copy)  PhoneTypeBlock phoneTypeBlock;

@property (nonatomic ,strong) NSString *phoneTypeStr;

@property (nonatomic ,strong) NSMutableArray *selectedArr;

@property (nonatomic ,strong) NSArray *array;



@end
