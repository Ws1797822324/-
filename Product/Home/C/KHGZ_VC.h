//
//  KHGZ_VC.h
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickAction)();

@interface KHGZ_VC : UIViewController

@property (nonatomic ,strong) NSString *l_id;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)confirmBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic ,copy) ClickAction clickAction ;

@end
