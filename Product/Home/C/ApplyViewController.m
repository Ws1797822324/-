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
    self.navigationItem.title = @"申请成为经纪人";
    [XXNetWorkManager requestWithMethod:POST withParams:@{kOpt : @"kefu"} withUrlString:@"UserServlet" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200 && !kStringIsEmpty(data)) {
            kUserData;
            userInfo.kefuPhone = kString(@"%@", data);
            [UserInfoTool saveAccount:userInfo];


        }
    } withFailuerBlock:^(id error) {

    }];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)shenqing:(UIButton *)sender {

    // MARK: ------ 联系客服 ------
    kUserData
    if (!kStringIsEmpty(userInfo.kefuPhone)) {
        [XXHelper makePhoneCallWithTelNumber:userInfo.kefuPhone];
    } else {
        [XXProgressHUD showMessage:@"客服小妹请假啦"];
    }}

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
