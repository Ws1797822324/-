//
//  Certification_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Certification_VC.h"

@interface Certification_VC () <UITextFieldDelegate>

@property (nonatomic, copy) NSString *imgUrl1; // zheng
@property (nonatomic, copy) NSString *imgUrl2; // fan
@property (nonatomic, strong) NSArray *imageArr1;
@property (nonatomic, strong) NSArray *imageArr2;

@end
#define imgWidth (kWidth * 0.5 - 40)
@implementation Certification_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"实名认证";
    kWeakSelf;
    [[self.photographBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
            [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {

                _imageArr1 = photos;
                NSString * url = [NSString stringWithFormat:@"%@Uploader",kBaseURL];

                [XXNetWorkManager uploadImageWithOperations:@{}
                    withImageArray:self.imageArr1
                    withtargetWidth:imgWidth
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
                [weakSelf.photographBtn1 setImage:photos[0] forState:UIControlStateNormal];

            }
                                       target:self
                               selectedAssets:nil
                                     maxCount:1
                                       isIcon:NO];

        }];

    [[self.photographBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
            [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {
                NSString * url = [NSString stringWithFormat:@"%@Uploader",kBaseURL];

                _imageArr2 = photos;
                // MARK: ------ fan  ------
                [XXNetWorkManager uploadImageWithOperations:@{}
                    withImageArray:_imageArr2
                    withtargetWidth:imgWidth
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
                [weakSelf.photographBtn2 setImage:photos[0] forState:UIControlStateNormal];

            }
                                       target:self
                               selectedAssets:nil
                                     maxCount:1
                                       isIcon:NO];
        }];

    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {

            if (kStringIsEmpty(_name_TF.text)) {
                [XXProgressHUD showError:@"请输入您的名字"];
                return;
            }
            if (![XXHelper IsIdentityCard:weakSelf.sfcode_TF.text]) {
                [XXProgressHUD showError:@"请输入正确的身份证号码"];
                return;
            }

            if (kStringIsEmpty(_imgUrl1)) {
                [XXProgressHUD showError:@"身份证照片正面上传失败!\n请重新选择照片"];
                return;
            }
            if (kStringIsEmpty(_imgUrl2)) {
                [XXProgressHUD showError:@"身份证照片反面上传失败!\n请重新选择照片"];
                return;
            }

            
            [XXProgressHUD showLoading:@"图片上传中..."];
#pragma mark - 上传所有信息
            kUserData;
            [[RACScheduler mainThreadScheduler]
                afterDelay:3
                  schedule:^{
                      [ XXProgressHUD  hideHUD];

                      
                      NSDictionary *params = @{
                          kOpt : @"certification",
                          kToken : userInfo.token,
                          @"real_name" : _name_TF.text,
                          @"id_card" : _sfcode_TF.text,
                          @"pic_z" : _imgUrl1,
                          @"pic_fan" : _imgUrl2
                      };
                      [XXNetWorkManager requestWithMethod:POST
                          withParams:params
                          withUrlString:kPersonalServlet
                          withHud:@"认证信息上传中..."
                          withProgressBlock:^(float requestProgress) {

                          }
                          withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                              if (code == 200) {
                                  NSLog(@"shnag = %@", objc);
                                  userInfo.sfz_z = _imgUrl1;
                                  userInfo.sfz_f = _imgUrl2;
                                  userInfo.sfz_code = _sfcode_TF.text;
                                  userInfo.sfz_name = _name_TF.text;
                                  [UserInfoTool saveAccount:userInfo];
                                  [XXProgressHUD showMessage:message];
                              } else {
                                  [XXProgressHUD showError:message];
                              }
                          }
                          withFailuerBlock:^(id error){

                          }];

                  }];

        }];
    // Do any additional setup after loading the view from its nib.
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
