//
//  AdviceViewController.m
//  Product
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//
#define colorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kTextBorderColor     RGBCOLOR(227,224,216)
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "AdviceViewController.h"


@interface AdviceViewController ()<UITextViewDelegate>{
    UITextField *phoneTextField;

}
@property (nonatomic, strong) XXTextView * textView;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"用户反馈"];
    [self setUI];
}
-(void)setUI{
    self.view.backgroundColor = colorWithRGB(246, 247, 248);
    
    [self.view addSubview:self.textView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIView *backView=[[UIView alloc]init];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(5);
    }];
    
    
    
    
    UILabel *mimaLB=[[UILabel alloc]init];
    mimaLB.text=@"联系方式";
    mimaLB.font=[UIFont systemFontOfSize:14];
    [backView addSubview:mimaLB];
    [mimaLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(30);
    }];
    
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mimaLB.mas_right).offset(5);
        make.top.bottom.mas_equalTo(mimaLB);
        make.width.mas_equalTo(1);
    }];
    
    phoneTextField = [[UITextField alloc] init];
    phoneTextField.textColor = [UIColor lightGrayColor];
    phoneTextField.keyboardType = UIKeyboardTypeDefault;
    phoneTextField.placeholder = @"手机号码/QQ/微信";
    phoneTextField.font = [UIFont systemFontOfSize:14];
    [backView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mimaLB.mas_right).offset(30);
        make.centerY.mas_equalTo(mimaLB.mas_centerY);
        make.right.mas_equalTo(-30);
        make.height.equalTo(@30);
    }];
    
    
    UIView* line1 = [[UIView alloc] init];
    line1.backgroundColor = colorWithRGB(198, 198, 198);
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(phoneTextField.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = colorWithRGB(54, 157, 252);
    [button setTitle:@"提交" forState:UIControlStateNormal];
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

-(XXTextView *)textView{
    
    if (!_textView) {
        _textView = [[XXTextView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 150)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = kTextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.xx_placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.xx_placeholder = @"请描述您遇到的问题或提出您的宝贵建议";
    }
    
    return _textView;
}


-(void)okclick:(UIButton *)sender{

    if (kStringIsEmpty(_textView.text)) {
        [XXProgressHUD showError:@"反馈信息不能为空"];
        return;
    }
    if (kStringIsEmpty(phoneTextField.text)) {
        [XXProgressHUD showError:@"请输入您的联系方式"];
        return;
    }
    
    kUserData
    NSDictionary *params = @{
                             @"opt" : @"tickling",
                             @"token" : userInfo.token,
                             @"tickling" : _textView.text,
                             @"contact_way" : phoneTextField.text,
                             @"os" : kString(@"%f",IOS_N),
                             @"time" : [XXHelper currentTime],
        
    };
    
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kPersonalServlet withHud:@"反馈信息提交..." withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        if (code == 200) {
            [XXProgressHUD showSuccess:message];
        } else {
            [XXProgressHUD showError:message];

        }
    } withFailuerBlock:^(id error) {
        
    }];
    
}
@end
