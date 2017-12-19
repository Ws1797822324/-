//
//  LoginViewController.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"

#import "Register_VC.h"
#import "ForgotPassword_VC.h"
#import "YMNavgatinController.h"
#import "CYLTabBarControllerConfig.h"
#import "JPUSHService.h"

@interface LoginViewController () <UITextFieldDelegate>
/// 账号
@property (weak, nonatomic) IBOutlet TKPhoneTextField *userNameTF;

/// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

/// 登录按钮
- (IBAction)loginBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)registerBtn:(UIButton *)sender;

- (IBAction)forgotPasswordBtn:(UIButton *)sender;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JPUSHService setAlias:@"0" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:0];
    NSSet * setS = [NSSet setWithObject:@"0"];
    [JPUSHService setTags:setS completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
    } seq:0];


}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self settingNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setImage:kImageNamed(@"close_eyes") forState:UIControlStateNormal];
    [tempBtn setImage:[UIImage imageNamed:@"make_eyes"] forState:UIControlStateSelected];
    [tempBtn addTarget:self action:@selector(tempBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn sizeToFit];
    self.passwordTF.rightView = tempBtn;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;

    _passwordTF.secureTextEntry = YES;
    _passwordTF.returnKeyType = UIReturnKeyGo;
    _userNameTF.delegate = self;

    [self settingNav];
}

- (void)settingNav {

    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 20)];

    statusBarView.backgroundColor = [UIColor clearColor];

    [self.navigationController.navigationBar addSubview:statusBarView];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    //    //消除导航栏阴影

    [self.navigationController.navigationBar hiddenLine];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userNameTF) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}

// MARK:  密码右边的眼睛
- (void)tempBtnClickAction:(UIButton *)tempBtn {
    self.passwordTF.secureTextEntry = YES;

    if ((tempBtn.selected = !tempBtn.selected)) {

        self.passwordTF.secureTextEntry = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 登录按钮点击方法
- (IBAction)loginBtnAction:(UIButton *)sender {


    _userNameTF.text = [_userNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if ([_userNameTF.text length] != 11) {

        [XXProgressHUD showMessage:@"请正确输入手机号"];
        [_userNameTF becomeFirstResponder];

        return;
    }

    if (_passwordTF.text.length == 0) {
        [XXProgressHUD showMessage:@"输入密码"];
        [_passwordTF becomeFirstResponder];

        return;
    }
    NSLog(@"手机型号 %@ -- %f", [XXHelper getUserPhoneModelNumber], IOS_N);

    NSDictionary *params = @{
        @"phone" : _userNameTF.text,
        @"password" : [GBEncodeTool getMd5_32Bit_String:_passwordTF.text isUppercase:NO],
        @"opt" : @"login",
        @"brand" : @"iPhone",
        @"model" : kString(@"%@", [XXHelper getUserPhoneModelNumber]), // 手机型号
        @"os" : kString(@"%f", IOS_N)
    };

    [XXNetWorkManager requestWithMethod:POST
        withParams:params
        withUrlString:kUserServlet
        withHud:@"正在登录..."
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            if (code == 200) {
                NSLog(@"登录成功 - %@", data);

                UserInfo *user = [UserInfo mj_objectWithKeyValues:data];
                user.LoginType = @"096411";
                user.position = @"南京市";
                [UserInfoTool saveAccount:user];

                NSSet *set= [NSSet setWithObjects:user.status, nil];
                [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {

                } seq:0];

                NSString *strSet=user.phone;
                [JPUSHService setAlias:strSet completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

                } seq:0];



                CYLTabBarControllerConfig *tabVC = [[CYLTabBarControllerConfig alloc] init];
                [self presentViewController:tabVC.tabBarController
                                   animated:true
                                 completion:^{

                                 }];
            }

            if (code == 201) {
                [XXProgressHUD showError:message];
            }
        }
        withFailuerBlock:^(id error){

        }];
}

#pragma mark--  注册跳转
- (IBAction)registerBtn:(UIButton *)sender {

    Register_VC *registerVC = [[Register_VC alloc] init];

    [(YMNavgatinController *) self.navigationController pushViewController:registerVC
                                                                      type:YMNavgatinControllerTypeClear
                                                                  animated:YES];

}

- (IBAction)forgotPasswordBtn:(UIButton *)sender {

    ForgotPassword_VC *forgotPasswordVc = [[ForgotPassword_VC alloc] init];
    [(YMNavgatinController *) self.navigationController pushViewController:forgotPasswordVc
                                                                      type:YMNavgatinControllerTypeBlue
                                                                  animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated  {
    [super viewDidDisappear:animated];
}
@end
