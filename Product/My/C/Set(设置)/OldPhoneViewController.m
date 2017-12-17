//
//  OldphoneViewController.m
//  Product
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//
#define colorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "OldPhoneViewController.h"

@interface OldPhoneViewController () <UITextFieldDelegate>
{
    UITextField *pw_TextField;
    UITextField *codeTextField;
    TKPhoneTextField *phoneNewTextField;
    NSString* _codeStr;
}

@end

@implementation OldPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    self.navigationItem.title = @"修改绑定手机";

    
    [self setUI];
    
    [self oklick];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {

        if ([codeTextField.text length]>= 7) {
            codeTextField.text = [codeTextField.text substringToIndex:6];
        }
    }];
}


-(void)oklick{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:kImageNamed(@"background_3") forState:UIControlStateNormal];
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

-(void)setUI{
    
    UIView *backView=[[UIView alloc]init];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(500);
    }];
    
    UILabel *titleLB=[[UILabel alloc]init];
    titleLB.text=@"修改后下次可以使用新手机号码登录";
    titleLB.font=[UIFont systemFontOfSize:14];
    titleLB.textColor=colorWithRGB(188, 188, 188);
    [backView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-30);
    }];
    kUserData;
    UILabel *phoneLB=[[UILabel alloc]init];

    phoneLB.text= [NSString stringWithFormat:@"当前手机号码为: %@",userInfo.phone];
    phoneLB.textColor=colorWithRGB(188, 188, 188);
    phoneLB.font=[UIFont systemFontOfSize:14];
    [backView addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(titleLB.mas_bottom).offset(5);
        make.right.mas_equalTo(-30);
    }];

    
    UILabel *mimaLB=[[UILabel alloc]init];
    mimaLB.text=@"原密码";
    mimaLB.font=[UIFont systemFontOfSize:15];
    [backView addSubview:mimaLB];
    [mimaLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(phoneLB.mas_bottom).offset(30);
    }];
    
    pw_TextField = [[UITextField alloc] init];
    pw_TextField.textColor = [UIColor blackColor];

    pw_TextField.placeholder = @"请输入登录密码";
    pw_TextField.clearButtonMode = UITextFieldViewModeAlways;
    pw_TextField.font = [UIFont systemFontOfSize:15];
    [backView addSubview:pw_TextField];
    [pw_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mimaLB.mas_right).offset(20);
        make.centerY.mas_equalTo(mimaLB.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];
    
    
    UIView* line1 = [[UIView alloc] init];
    line1.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(pw_TextField.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];


    UILabel *y_LB=[[UILabel alloc]init];
    y_LB.text=@"验证码";
    y_LB.font=[UIFont systemFontOfSize:15];
    [backView addSubview:y_LB];
    [y_LB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(line1.mas_bottom).offset(20);
    }];
    
    codeTextField = [[UITextField alloc] init];
    codeTextField.textColor = [UIColor blackColor];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.placeholder = @"请输入验证码";
    codeTextField.font = [UIFont systemFontOfSize:15];
    codeTextField.clearButtonMode = UITextFieldViewModeAlways;
    [backView addSubview:codeTextField];
  
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [codeBtn setTitleColor:kRGB_HEX(0x2880e3) forState:0];
    [backView addSubview:codeBtn];
    [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeTextField);
        make.right.mas_equalTo(-30);
        make.width.mas_offset(100);
        make.height.equalTo(@32);
    }];

    
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(y_LB.mas_right).offset(20);
        make.centerY.mas_equalTo(y_LB.mas_centerY);
        make.right.equalTo(codeBtn.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    
    UIView* line2 = [[UIView alloc] init];
    line2.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(codeTextField.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    
    
    UILabel *newPhone=[[UILabel alloc]init];
    newPhone.text=@"新手机";
    newPhone.font=[UIFont systemFontOfSize:15];
    [backView addSubview:newPhone];
    [newPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
    make.top.mas_equalTo(line2.mas_bottom).offset(20);
    }];
    
    phoneNewTextField = [[TKPhoneTextField alloc] init];
    phoneNewTextField.textColor = [UIColor blackColor];
    phoneNewTextField.delegate = self;
    phoneNewTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNewTextField.placeholder = @"请输入新的手机号";
    phoneNewTextField.clearButtonMode = UITextFieldViewModeAlways;
    phoneNewTextField.font = [UIFont systemFontOfSize:15];
    [backView addSubview:phoneNewTextField];
    [phoneNewTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeTextField);
        make.centerY.mas_equalTo(newPhone.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];
    
    
    UIView* line3 = [[UIView alloc] init];
    line3.backgroundColor = colorWithRGB(179, 233, 252);
    [backView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(phoneNewTextField.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == phoneNewTextField) {
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
//获取验证码
-(void)codeBtnClick:(UIButton*)sender{

    if (kStringIsEmpty(phoneNewTextField.text)) {
        [XXProgressHUD showError:@"请输入手机号"];
        return;
    }
    phoneNewTextField.text= [phoneNewTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![XXHelper isNumber:phoneNewTextField.text]) {
        
        [XXProgressHUD showMessage:@"请正确输入手机号"];
        [phoneNewTextField becomeFirstResponder];
        
        return;
    }
    
    [XXHelper startWithTime:60 title:@"获取验证码" countDownTitle:@"S 重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor] disposeButton:sender];
    
    NSDictionary * params = @{
                              @"phone" : phoneNewTextField.text,
                              @"opt" : @"verification"
                              };
    
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Obtainsms" withHud:@"获取验证码" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200) {
            kInspectSignInType
            _codeStr = data;
            NSLog(@"获取验证码请求打印 -- %@",objc);
            
            [XXProgressHUD showSuccess:message];
        } else {
            [XXProgressHUD showError:message];
        }
        
    } withFailuerBlock:^(id error) {
        
    }];

}

-(void)okclick:(UIButton*)sender{
    
    if (![_codeStr isEqualToString:codeTextField.text]) {
        [XXProgressHUD showMessage:@"请正确输入验证码"];
        return;
    }
    if (kStringIsEmpty(pw_TextField.text)) {
        [XXProgressHUD showError:@"密码不能为空"];
        return;
    }
    kUserData;
    NSDictionary * params = @{
                              kOpt : @"xg_phone",
                              @"phone" : phoneNewTextField.text,
                              @"password" : [GBEncodeTool getMd5_32Bit_String:pw_TextField.text isUppercase:NO],
                              @"auth_code" : codeTextField.text,
                              kToken : userInfo.token
                              };
    
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kPersonalServlet withHud:@"修改手机号" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"990--* -- %@",objc);
        kInspectSignInType;
        kShowMessage
        if (code == 200) {

            kUserData;
            userInfo.LoginType = @"114690";
            [UserInfoTool saveAccount:userInfo];
            LoginViewController *loginVC = [LoginViewController viewControllerFromNib];
            [self presentViewController:loginVC
                               animated:YES
                             completion:^{
                             }];
        }
        
    } withFailuerBlock:^(id error) {
        
    }];
    
    
}

@end
