//
//  PosTool.m
//  YGJPos
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 HD. All rights reserved.
//

#import "PosTool.h"

@implementation PosTool
+(UIImageView *)imageViewWithImageName:(NSString *)imageName{
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+(UIImageView *)imageViewWithImageName:(NSString *)imageName addOnSuperView:(UIView *)suerView{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [suerView addSubview:imageView];
    
    return imageView;
}

+(UILabel *)labelWithTextColr:(NSString *)color fontName:(NSString *)fontName fontSize:(CGFloat)fontSize defaultText:(NSString *)defaultText{
   
    UILabel* label = [[UILabel alloc] init];
    
    label.textColor = [UIColor colorWithHexString:color alpha:1.0];
    
    label.font = [UIFont fontWithName:fontName size:fontSize];
    
    label.text = defaultText;
    
    return label;

}

+(UIView *)viewWithBackgroundColor:(NSString *)backgroundColor alpha:(CGFloat)alpha{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:backgroundColor alpha:alpha];
    return view;
}

+(UIButton*)buttonWithImage:(NSString*)imageName title:(NSString*)title{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName){
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (title){
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    return button;
}

+(UITableView *)tableViewWithStyle:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate{
    UITableView* tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:style];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return tableView;
}

+(UITextField *)textFieldWithTextColor:(NSString *)color font:(NSString *)font fontSize:(CGFloat)fontSize placeHolder:(NSString *)placeholder{
    UITextField* tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    tf.textColor = [UIColor colorWithHexString:color alpha:1.0];
    tf.font = [UIFont fontWithName:font size:fontSize];
    
    return tf;
}
@end
