//
//  PropertiesDetails_HeaderCell.h
//  Product
//
//  Created by  海跃尚 on 17/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PropertiesDetails_HeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *price_L;

//* 头部滚动视图 */

@property (weak, nonatomic) IBOutlet UIView *imageViewTool;

//* 标签视图 */

@property (weak, nonatomic) IBOutlet UIView *tagsViewTool;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewToolLayout;
-(void) cinfigTagsView:(NSArray *)arr;
@end
