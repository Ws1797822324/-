//
//  PosTool.h
//  YGJPos
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 HD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PosTool : NSObject

+(UIImageView*)imageViewWithImageName:(NSString*)imageName;

+(UIImageView*)imageViewWithImageName:(NSString*)imageName addOnSuperView:(UIView*)suerView;


+(UILabel*)labelWithTextColr:(NSString*)color fontName:(NSString*)fontName fontSize:(CGFloat)fontSize defaultText:(NSString*)defaultText;

+(UIView*)viewWithBackgroundColor:(NSString*)backgroundColor alpha:(CGFloat)alpha;

+(UIButton*)buttonWithImage:(NSString*)imageName title:(NSString*)title;

+(UITableView*)tableViewWithStyle:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate;

+(UITextField*)textFieldWithTextColor:(NSString*)color font:(NSString*)font fontSize:(CGFloat)fontSize placeHolder:(NSString*)placeholder;

@end
