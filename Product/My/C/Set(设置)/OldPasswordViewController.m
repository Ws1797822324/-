

//
//  OldPasswordViewController.m
//  Product
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//
#define colorWithRGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]

#import "OldPasswordViewController.h"

@interface OldPasswordViewController () {
    UITextField *oldpw_T;
    UITextField *pwNew_T;
    UITextField *pwNewTwo_T;
}

@end

@implementation OldPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"修改密码";
    [self setUI];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = colorWithRGB(54, 157, 252);
    [button setTitle:@"确认" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-64);
    }];
}

- (void)setUI {

    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(300);

    }];

    UILabel *mimaLB = [[UILabel alloc] init];
    mimaLB.text = @"原密码";
    mimaLB.font = [UIFont systemFontOfSize:15];
    [backView addSubview:mimaLB];
    [mimaLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(60);
    }];

    oldpw_T = [[UITextField alloc] init];
    oldpw_T.textColor = [UIColor blackColor];

    oldpw_T.placeholder = @"请输入原密码";
    oldpw_T.font = [UIFont systemFontOfSize:15];
    [backView addSubview:oldpw_T];
    [oldpw_T mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mimaLB.mas_right).offset(30);
        make.centerY.mas_equalTo(mimaLB.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(oldpw_T.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    UILabel *y_LB = [[UILabel alloc] init];
    y_LB.text = @"新密码";
    y_LB.font = [UIFont systemFontOfSize:15];
    [backView addSubview:y_LB];
    [y_LB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(line1.mas_bottom).offset(30);
    }];

    pwNew_T = [[UITextField alloc] init];
    pwNew_T.textColor = [UIColor blackColor];

    pwNew_T.placeholder = @"请输入新密码";
    pwNew_T.font = [UIFont systemFontOfSize:15];
    [backView addSubview:pwNew_T];
    [pwNew_T mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(y_LB.mas_right).offset(30);
        make.centerY.mas_equalTo(y_LB.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];

    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(pwNew_T.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    UILabel *newPhone = [[UILabel alloc] init];
    newPhone.text = @"确认密码";
    newPhone.font = [UIFont systemFontOfSize:15];
    [backView addSubview:newPhone];
    [newPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(line2.mas_bottom).offset(30);
    }];

    pwNewTwo_T = [[UITextField alloc] init];
    pwNewTwo_T.textColor = [UIColor blackColor];

    pwNewTwo_T.placeholder = @"请再次输入新密码";
    pwNewTwo_T.font = [UIFont systemFontOfSize:15];
    [backView addSubview:pwNewTwo_T];
    [pwNewTwo_T mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pwNew_T);
        make.centerY.mas_equalTo(newPhone.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];

    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(pwNewTwo_T.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];
}
- (void)okclick:(UIButton *)sender {

    
    if (kStringIsEmpty(oldpw_T.text)) {
        [XXProgressHUD showError:@"旧密码不能空"];
        return;
    }
    if (pwNew_T.text.length <=5) {
        [XXProgressHUD showMessage:@"密码至少6位"];
        return;
    }
    
    if (kStringIsEmpty(pwNewTwo_T.text) || kStringIsEmpty(pwNew_T.text)) {
        [XXProgressHUD showMessage:@"密码不能为空"];
        return;
    }
    
    if (![pwNewTwo_T.text isEqualToString:pwNew_T.text]) {
        [XXProgressHUD showMessage:@"新密码两次输入不同"];
        return;
    }
    kUserData NSDictionary *params = @{
        @"opt" : @"change",
        @"password" : [GBEncodeTool getMd5_32Bit_String:pwNewTwo_T.text isUppercase:NO],
        @"token" : userInfo.token,
        @"origin" : [GBEncodeTool getMd5_32Bit_String:oldpw_T.text isUppercase:NO],
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:params
        withUrlString:kPersonalServlet
        withHud:@"修改密码..."
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"xiuhi %@",objc);
            
            if (code == 200) {

                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"密码修改成功" message:@"请重新登录"preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                    kUserData;
                    userInfo.LoginType = @"114690";   // 是否登录的条件改变
                    [UserInfoTool saveAccount:userInfo];
                    LoginViewController *loginVC = [LoginViewController viewControllerFromNib];
                    YMNavgatinController *navLiginVC = [[YMNavgatinController alloc] initWithRootViewController:loginVC];
                    [UIView animateWithDuration:0.2f
                                     animations:^{
                                         [UIApplication sharedApplication].keyWindow.rootViewController = navLiginVC;
                                     }];
                }];
                [alert addAction:a1];
                [self presentViewController:alert animated:YES completion:^{

                }];
            } else {
                [XXProgressHUD showError:message];
            }
        }
        withFailuerBlock:^(id error){

        }];
}

@end
