//
//  Personal_introduction_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Personal_introduction_VC.h"

@interface Personal_introduction_VC ()

@property (weak, nonatomic) IBOutlet XXTextView *textview;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation Personal_introduction_VC

- (void)viewDidLoad {
    self.navigationItem.title = @"个人介绍";
    [super viewDidLoad];
    self.textview.text = self.oldIntroduce;
    self.textview.xx_placeholder = @"用简单的话介绍下自己,给客户选择你的理由。";
    self.textview.xx_placeholderColor = kRGB_HEX(0xD6D6D6);

    kWeakSelf;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       
        
        weakSelf.numL.text = kString(@"%ld", [weakSelf.textview.text length]);
        
        if ([weakSelf.textview.text length]>= 300) {
             weakSelf.textview.text = [weakSelf.textview.text substringToIndex:299];
        }
    }];

    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        kUserData;
        
        if ([weakSelf.textview.text length] == 0) {
            [XXProgressHUD showError:@"请输入自我介绍"];
            return ;
        }
        NSDictionary * params = @{
                                  kToken : userInfo.token,
                                  kOpt : @"introduce",
                                  @"introduce" : weakSelf.textview.text
                                  
                                  };
        [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kPersonalServlet withHud:@"介绍上传中..." withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            if (code == 200) {
                [XXProgressHUD showSuccess:message];
                [weakSelf.navigationController popViewControllerAnimated:true];
            } else {
                [XXProgressHUD showError:message];
            }
        } withFailuerBlock:^(id error) {
            
        }];
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
