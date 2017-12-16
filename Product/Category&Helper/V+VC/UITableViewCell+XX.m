//
//  UITableViewCell+XX.m
//  Product
//
//  Created by Sen wang on 2017/12/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UITableViewCell+XX.h"

@implementation UITableViewCell (XX)

/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(UINib*)nib{
    return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)loadCellFromClass:(UITableView *)tableView{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

+ (instancetype)loadCellFromNib:(UITableView *)tableView{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];

    if (!cell) {
        cell = [self viewFromXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
