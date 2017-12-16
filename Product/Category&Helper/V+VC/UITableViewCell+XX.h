//
//  UITableViewCell+XX.h
//  Product
//
//  Created by Sen wang on 2017/12/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (XX)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(UINib*)nib;

/**
 tableView 代理方法中加载 cell

 @param tableView 要加载的 tableView
 @return cell
 */
+ (instancetype)loadCellFromClass:(UITableView *)tableView;
+ (instancetype)loadCellFromNib:(UITableView *)tableView;



@end
