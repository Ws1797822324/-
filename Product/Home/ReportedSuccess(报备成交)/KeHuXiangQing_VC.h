//
//  KeHuXiangQing_VC.h
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeHuXiangQing_VC : UIViewController

@property (nonatomic ,strong) NSString *khID;

@property (nonatomic ,strong) NSString *fwID;


@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *phone_L;

//短信
- (IBAction)message_Btn:(UIButton *)sender;

//打电话
- (IBAction)phone_Btn:(UIButton *)sender;
// 购房意向  按钮
- (IBAction)houseIdea_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
