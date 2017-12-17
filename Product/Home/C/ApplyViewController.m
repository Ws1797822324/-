//
//  ApplyViewController.m
//  Product
//
//  Created by Sen wang on 2017/12/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客户详情";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)shenqing:(UIButton *)sender {

    [XXHelper makePhoneCallWithTelNumber:@"10010"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
