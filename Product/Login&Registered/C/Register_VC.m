//
//  RegisterViewController.m
//  Product
//
//  Created by Sen wang on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Register_VC.h"

#import "Register_WebVC.h"
#import "CYLTabBarControllerConfig.h"


@interface Register_VC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *touristBtn;  // 游客
- (IBAction)kefuButton:(UIButton *)sender;

- (IBAction)touristButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *agentBtn;
- (IBAction)agentButton:(UIButton *)sender;

@property (strong, nonatomic)  UIImageView *arrowImg;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property(nonatomic ,copy) NSString *type;  // 经纪人2 or 游客1
// 邀请码 View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *InvitationCodeViewLayout;
@property (weak, nonatomic) IBOutlet UIView *invitationCodeView;

// 协议 View

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *protocolViewLayout;

// 阅读同意按钮
@property (nonatomic,assign) BOOL yuedu_Type;
- (IBAction)yuedu_Type:(UIButton *)sender;

// 协议按钮
- (IBAction)xieyiButton:(UIButton *)sender;

// 设置密码
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
// 确认密码
@property (weak, nonatomic) IBOutlet UITextField *pwTF2;
// 邀请码
@property (weak, nonatomic) IBOutlet UITextField *icTF;
// 手机号
@property (weak, nonatomic) IBOutlet TKPhoneTextField *phoneTF;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

// 验证码传值

@property(nonatomic, copy) NSString *codeStr;

- (IBAction)codeBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

- (IBAction)registerBtn:(UIButton *)sender;
@end

@implementation Register_VC


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];



    if (kiPhone5s) {
        
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(self.view).multipliedBy(0.3);
    }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [XXNetWorkManager requestWithMethod:POST withParams:@{kOpt : @"kefu"} withUrlString:@"UserServlet" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200 && !kStringIsEmpty(data)) {
            kUserData;
            userInfo.kefuPhone = kString(@"%@", data);
            [UserInfoTool saveAccount:userInfo];


        }
    } withFailuerBlock:^(id error) {

    }];
    self.navigationItem.title = @"注册";
    self.arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sanjiaoxing"]];
    [_backgroundImageView addSubview: _arrowImg];

    _phoneTF.delegate = self;
    self.type = @"2";
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backgroundImageView);
        make.centerX.equalTo(_agentBtn.mas_centerX);
    }];
    
    [_agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_arrowImg.mas_top).offset(-3);
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        if ([_codeTF.text length]>= 7) {
            _codeTF.text = [_codeTF.text substringToIndex:6];
        }
        if ([_icTF.text length]>= 7) {
            _icTF.text = [_icTF.text substringToIndex:6];
        }


    }];

    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setImage:kImageNamed(@"close_eyesB") forState:UIControlStateNormal];
    [tempBtn setImage:[UIImage imageNamed:@"make_eyesB"] forState:UIControlStateSelected];
    [tempBtn addTarget:self action:@selector(tempBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn sizeToFit];
    self.pwTF.rightView = tempBtn;
    self.pwTF.rightViewMode = UITextFieldViewModeAlways;
    
    _pwTF.secureTextEntry = YES;
    UIButton *tempBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn2 setImage:kImageNamed(@"close_eyesB") forState:UIControlStateNormal];
    [tempBtn2 setImage:[UIImage imageNamed:@"make_eyesB"] forState:UIControlStateSelected];
    [tempBtn2 addTarget:self action:@selector(tempBtnTwoClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn2 sizeToFit];
    self.pwTF2.rightView = tempBtn2;
    self.pwTF2.rightViewMode = UITextFieldViewModeAlways;
    
    _pwTF2.secureTextEntry = YES;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneTF) {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  - 经纪人
- (IBAction)agentButton:(UIButton *)sender {


    [_arrowImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_backgroundImageView);
            make.centerX.equalTo(_agentBtn.mas_centerX);
    
        }];
    self.invitationCodeView.hidden = NO;
    self.protocolViewLayout.constant = 45;
    self.type = @"2";
}
- (IBAction)kefuButton:(UIButton *)sender {

    // MARK: ------ 联系客服 ------
    kUserData
    if (!kStringIsEmpty(userInfo.kefuPhone)) {
        [XXHelper makePhoneCallWithTelNumber:userInfo.kefuPhone];
    } else {
        [XXProgressHUD showMessage:@"客服小妹请假啦"];
    }
}
#pragma mark  - 游客

- (IBAction)touristButton:(UIButton *)sender {
  

    [_arrowImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_backgroundImageView);
            make.centerX.equalTo(_touristBtn.mas_centerX);
        }];

    self.protocolViewLayout.constant = 15;
    self.invitationCodeView.hidden = YES;
    self.type = @"1";


}
- (IBAction)yuedu_Type:(UIButton *)sender {
    sender.selected = !sender.selected;
    _yuedu_Type = sender.selected;
}

- (IBAction)xieyiButton:(UIButton *)sender {

    Register_WebVC * webVc = [[Register_WebVC alloc]init];
    [(YMNavgatinController *)self.navigationController pushViewController:webVc type:YMNavgatinControllerTypeClear animated:YES];
}

// MARK:  密码右边的眼睛
-(void) tempBtnClickAction:(UIButton *)tempBtn {
    self.pwTF.secureTextEntry = YES;
    
    if ((tempBtn.selected=!tempBtn.selected)) {
        
        self.pwTF.secureTextEntry = NO;
        
    }
}

// MARK:  确认密码右边的眼睛
-(void) tempBtnTwoClickAction:(UIButton *)tempBtn {
    self.pwTF2.secureTextEntry = YES;
    
    if ((tempBtn.selected=!tempBtn.selected)) {
        
        self.pwTF2.secureTextEntry = NO;
        
    }
}


#pragma mark -- 获取验证码


- (IBAction)codeBtn:(UIButton *)sender {
    
    if (kStringIsEmpty(_phoneTF.text)) {
        [XXProgressHUD showMessage:@"请输入手机号"];
        return;
    }
    _phoneTF.text= [_phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([_phoneTF.text length] != 11) {
        
        [XXProgressHUD showMessage:@"请正确输入手机号"];
        [_phoneTF becomeFirstResponder];
        
        return;
    }
    [XXHelper startWithTime:60 title:@"获取验证码" countDownTitle:@"S 重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor] disposeButton:_codeBtn];
    NSDictionary * params = @{
                              @"phone" : _phoneTF.text,
                              @"opt" : @"verification"
                              };
    
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Obtainsms" withHud:@"获取验证码" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType
        if (code == 200) {
            _codeStr = data;
            NSLog(@"获取验证码请求打印 -- %@",objc);

            [XXProgressHUD showSuccess:message];
        } else {
            [XXProgressHUD showError:message];
        }
        
    } withFailuerBlock:^(id error) {
        
    }];
}
#pragma mark -- 完成按钮 注册


- (IBAction)registerBtn:(UIButton *)sender {
    
    
    if (([_type isEqualToString:@"2"] && kStringIsEmpty(_icTF.text))) {
        [XXProgressHUD showMessage:@"邀请码必填"];
        return;
    }
    
    _phoneTF.text= [_phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if ( ![XXHelper isNumber:_phoneTF.text]) {
        [XXProgressHUD showMessage:@"请输入正确的手机号"];
        [_phoneTF becomeFirstResponder];
        
        return;
    }
    if (![_codeStr isEqualToString:_codeTF.text]) {
        [XXProgressHUD showMessage:@"请输入正确的验证码"];
        return;
    }
    
    if (kStringIsEmpty(_phoneTF.text) || kStringIsEmpty(_pwTF2.text)|| kStringIsEmpty(_pwTF.text) || kStringIsEmpty(_codeTF.text)) {
        [XXProgressHUD showError:@"请完善信息"];
        return;
    }

    if (_pwTF.text.length <=5) {
        [XXProgressHUD showMessage:@"密码至少6位"];
        return;
    }
    if (![_pwTF.text isEqualToString:_pwTF2.text]) {
        [XXProgressHUD showMessage:@"两次密码输入不同"];
        return;
    }
    
    
    if (_yuedu_Type) {
        [XXProgressHUD showError:@"请同意用户使用协议"];
        return;
    }
        NSDictionary * params = @{
                              @"opt" : @"register",
                              @"phone" : _phoneTF.text,
                              @"password" : [GBEncodeTool getMd5_32Bit_String:_pwTF.text isUppercase:NO],
                              @"auth_code" : _codeTF.text,
                              @"status" : _type,
                              @"invitation_code" : _icTF.text
                              
                            };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kUserServlet withHud:@"用户注册中..." withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"注册打印 -- %@",objc);

        if (code == 200) {


            
            NSDictionary *params = @{
                                     @"phone" : _phoneTF.text,
                                     @"password" : [GBEncodeTool getMd5_32Bit_String:_pwTF.text isUppercase:NO],
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
                                       return ;
                                   }
                               }
                               withFailuerBlock:^(id error){

                               }];

        } else {
            [XXProgressHUD showError:message];
        }
    } withFailuerBlock:^(id error) {
        
    }];
}



@end
