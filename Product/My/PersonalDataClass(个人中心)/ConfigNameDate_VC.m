//
//  ConfigNameDate_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConfigNameDate_VC.h"

@interface ConfigNameDate_VC ()

@end

@implementation ConfigNameDate_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    _data_TF.text = _oldStr;
    if (self.type) {
        _titleL.text = @"设置从业年限";
        _data_TF.keyboardType = UIKeyboardTypeDecimalPad;
        _nianL.hidden = NO;

    } else {
        _titleL.text = @"设置昵称";
        _nianL.hidden = YES;
    }
    [[_confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
            kUserData;

            if (_type) {
                NSDictionary *params = @{
                                         @"opt" : @"work_limit",
                                         @"work_limit" : _data_TF.text,
                                         kToken : userInfo.token
                                         };
                kWeakSelf
                [XXNetWorkManager requestWithMethod:POST
                                         withParams:params
                                      withUrlString:kPersonalServlet
                                            withHud:@"信息提交中..."
                                  withProgressBlock:^ (float requestProgress) {
                                      
                                  }
                                   withSuccessBlock:^ (id objc, int code, NSString *message, id data) {
                                       
                                       if (code == 200) {
                                           [XXProgressHUD showSuccess:message];
                                           [weakSelf.navigationController popViewControllerAnimated:YES];
                                       } else {
                                           [XXProgressHUD showError:message];
                                           
                                       }
                                   }
                                   withFailuerBlock:^ (id error) {
                                       
                                   }];
                

            } else {

                
                NSDictionary *params = @{
                    @"opt" : @"name",
                    @"name" : _data_TF.text,
                    kToken : userInfo.token
                    };
                kWeakSelf
                [XXNetWorkManager requestWithMethod:POST
                                           withParams:params
                                        withUrlString:kPersonalServlet
                                              withHud:@"昵称提交中..."
                                  withProgressBlock:^ (float requestProgress) {
                                      
                                  }
                                   withSuccessBlock:^ (id objc, int code, NSString *message, id data) {

                                       if (code == 200) {
                                           userInfo.name = _data_TF.text;
                                           [UserInfoTool saveAccount:userInfo];
                                           [XXProgressHUD showSuccess:message];
                                           [weakSelf.navigationController popViewControllerAnimated:YES];
                                       } else {
                                           [XXProgressHUD showError:message];

                                       }
                                   }
                                   withFailuerBlock:^ (id error) {
                                       
                                   }];
            }

        }];
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

