//
//  PeopleDetailsViewController.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleDetailsViewController : UIViewController
@property (nonatomic, strong) NSString * ids;


@property (weak, nonatomic) IBOutlet UILabel *name_L;
@property (weak, nonatomic) IBOutlet UILabel *phone_L;

//短信
- (IBAction)message_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *phone_Btn;
@property (weak, nonatomic) IBOutlet UIButton *message_Btn;

//打电话
- (IBAction)phone_Btn:(UIButton *)sender;
// 购房意向  按钮
- (IBAction)houseIdea_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)qingyong_Btn:(UIButton *)sender;
- (IBAction)jieyong_Btn:(id)sender;



@property (nonatomic ,strong) NSString *baibeiType;

@property (nonatomic ,strong) NSString *clickIDS;


@end
