//
//  AddBankCardViewController.m
//  Product
//
//  Created by HJ on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddBankCardViewController.h"

@interface AddBankCardViewController ()

@property (nonatomic ,strong) NSString *imgUrl1;
@property (nonatomic ,strong) NSString *imgUrl2;


@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写卡号";
    kViewRadius(self.sureBtn, 6);
    kUserData;
    self.TF_name.text = userInfo.sfz_name;
    self.TF_usercode.text = userInfo.sfz_code;
    NSLog(@"----   %@",userInfo.sfz_z);
    [self.button_F sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:kImageNamed(@"bg_card_default")];
    [self.button_S sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:kImageNamed(@"bg_card_default")];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)SFZClick1:(UIButton *)sender {
    kWeakSelf;
    [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {


        NSString * url = [NSString stringWithFormat:@"%@Uploader",kBaseURL];

        [XXNetWorkManager uploadImageWithOperations:@{}
                                     withImageArray:photos
                                    withtargetWidth:kWidth * 0.4
                                      withUrlString:url
                                   withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                       NSLog(@" 上传文件zheng  -%@", objc);
                                       if (code == 200) {
                                           weakSelf.imgUrl1 = data;
                                       } else {
                                       }

                                   }
                                    withFailurBlock:^(id error) {

                                    }
                                 withUpLoadProgress:^(float uploadProgress){

                                 }];
        [weakSelf.button_F setImage:photos[0] forState:UIControlStateNormal];

    }
                               target:self
                       selectedAssets:nil
                             maxCount:1
                               isIcon:NO];

}
- (IBAction)SFZClick2:(UIButton *)sender {
    kWeakSelf;
    [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {
        NSString * url = [NSString stringWithFormat:@"%@Uploader",kBaseURL];


        // MARK: ------ fan  ------
        [XXNetWorkManager uploadImageWithOperations:@{}
                                     withImageArray:photos
                                    withtargetWidth:kWidth * 0.4
                                      withUrlString:url
                                   withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                       NSLog(@" 上传文件fan  -%@", objc);
                                       if (code == 200) {
                                           weakSelf.imgUrl2 = data;

                                       } else {
                                       }

                                   }
                                    withFailurBlock:^(id error) {

                                    }
                                 withUpLoadProgress:^(float uploadProgress){

                                 }];
        [weakSelf.button_S setImage:photos[0] forState:UIControlStateNormal];

    }
                               target:self
                       selectedAssets:nil
                             maxCount:1
                               isIcon:NO];
    
}
- (IBAction)sureClick:(id)sender {

    if (kStringIsEmpty(_TF_name.text)) {
        [XXProgressHUD showMessage:@"请输入您的名字"];
        return;
    }
    if (![XXHelper IsIdentityCard:_TF_usercode.text]) {
        [XXProgressHUD showMessage:@"请输入正确的身份证号码"];
        return;
    }
    if (kStringIsEmpty(_TF_bankname.text)) {
        [XXProgressHUD showMessage:@"请输入开户行"];
        return;
    }
    if (kStringIsEmpty(_TF_bankcode.text)) {
        [XXProgressHUD showMessage:@"请输入银行卡号码"];
        return;
    }

    if (kStringIsEmpty(_imgUrl1)) {
        [XXProgressHUD showMessage:@"身份证照片正面上传失败!\n请重新选择照片"];
        return;
    }
    if (kStringIsEmpty(_imgUrl2)) {
        [XXProgressHUD showMessage:@"身份证照片反面上传失败!\n请重新选择照片"];
        return;
    }



    kUserData;

    [XXProgressHUD showLoading:@"图片上传中..."];

    [[RACScheduler mainThreadScheduler]
     afterDelay:3
     schedule:^{
         [ XXProgressHUD  hideHUD];


         NSDictionary *params = @{
                                  kOpt : @"comm_rz",
                                  kToken : userInfo.token,
                                  @"bank_num" : _TF_bankcode.text,
                                  @"open_bank" : _TF_bankname.text,
                                  @"pic_z" : _imgUrl1,
                                  @"pic_fan" : _imgUrl2,
                                  @"id_card" : _TF_usercode.text,
                                  };
         kWeakSelf;
         [XXNetWorkManager requestWithMethod:POST
                                  withParams:params
                               withUrlString:@"CommissionServlet"
                                     withHud:@"银行卡信息上传中..."
                           withProgressBlock:^(float requestProgress) {

                           }
                            withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                NSLog(@"银行卡上传 = %@", objc);
                                if (code == 200) {

                                    [XXProgressHUD showMessage:message];
                                    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{

                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                    }];
                                } else {
                                    [XXProgressHUD showError:message];
                                }
                            }
                            withFailuerBlock:^(id error){

                            }];

     }];

}


@end
