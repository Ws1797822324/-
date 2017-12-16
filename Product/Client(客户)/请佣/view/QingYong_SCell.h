//
//  QingYong_SCell.h
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol reloadSectionsDelegate <NSObject>

@optional//不必须实现的代理方法
-(void)reloadSections: (NSInteger)cellNum;
@end
@interface QingYong_SCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

@property (nonatomic ,weak) id<reloadSectionsDelegate> delegate;

- (IBAction)yesAction:(UIButton *)sender;
- (IBAction)noAction:(UIButton *)sender;

@end
