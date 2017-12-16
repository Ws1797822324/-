//
//  MyTags_VC.h
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXDeleteButton.h"
@interface MyTags_VC : UIViewController  <DZDeleteButtonDelegate>
@property (nonatomic ,strong) NSArray *tagsNameArr;

@end
