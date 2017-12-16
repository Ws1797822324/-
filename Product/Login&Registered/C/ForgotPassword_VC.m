//
//  ForgotPassword_VC.m
//  Product
//
//  Created by  海跃尚 on 17/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ForgotPassword_VC.h"

@interface ForgotPassword_VC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UITextField *pwTF;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

// 验证码传值

@property(nonatomic, copy) NSString *codeStr;


@end

@implementation ForgotPassword_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, -20,    self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        if ([_codeTF.text length]>= 7) {
            _codeTF.text = [_codeTF.text substringToIndex:6];
        }
    }];
    // Do any additional setup after loading the view from its nib.

    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setImage:kImageNamed(@"close_eyesB") forState:UIControlStateNormal];
    [tempBtn setImage:[UIImage imageNamed:@"make_eyesB"] forState:UIControlStateSelected];
    [tempBtn addTarget:self action:@selector(tempBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn sizeToFit];
    self.pwTF.rightView = tempBtn;
    self.pwTF.rightViewMode = UITextFieldViewModeAlways;
    
    _pwTF.secureTextEntry = YES;

    _phoneTF.delegate = self;

    
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    [textField phoneTFValueChangeValueString:string shouldChangeCharactersInRange:range];
    
    
    return false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---  确定按钮

- (IBAction)determineBtn:(UIButton *)sender {
    _phoneTF.text= [_phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if ([_phoneTF.text length] != 11) {
        
        [XXProgressHUD showMessage:@"请正确输入手机号"];
        [_phoneTF becomeFirstResponder];
        
        return;
    }
        if (kStringIsEmpty(_codeTF.text)) {
        [XXProgressHUD showMessage:@"输入验证码"];
            return;
    }
    if (![_codeStr isEqualToString:_codeTF.text]) {
        [XXProgressHUD showMessage:@"请正确输入验证码"];
        return;
    }

    if (kStringIsEmpty(_pwTF.text)) {
        [XXProgressHUD showMessage:@"输入密码"];
        return;
    }
    if (_pwTF.text.length <=5) {
        [XXProgressHUD showMessage:@"密码至少6位"];
        return;
    }
    
    
    NSDictionary *params = @{
                           @"opt" : @"retrieve",
                           @"phone" : _phoneTF.text,
                           @"password" : [GBEncodeTool getMd5_32Bit_String:_pwTF.text isUppercase:NO],
                           @"auth_code" : _codeTF.text,
                           
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kUserServlet withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200) {
            [XXProgressHUD showSuccess:message];
        } else {
            [XXProgressHUD showError:message];
        }
    } withFailuerBlock:^(id error) {
        
    }];

}

#pragma mark ---  获取验证

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
        if (code == 200) {
            _codeStr = data;
            NSLog(@"获取验证码请求打印 -- %@",objc);
            
            [XXProgressHUD showSuccess:message];
        } else {
            [XXProgressHUD showMessage:message];
        }
        
    } withFailuerBlock:^(id error) {
        
    }];

    
}

// MARK:  密码右边的眼睛
-(void) tempBtnClickAction:(UIButton *)tempBtn {
    self.pwTF.secureTextEntry = YES;
    
    if ((tempBtn.selected=!tempBtn.selected)) {
        
        self.pwTF.secureTextEntry = NO;
        
    }
}
@end
