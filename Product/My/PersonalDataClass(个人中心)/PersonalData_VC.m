//
//  PersonalData_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonalData_VC.h"
#import "XHNetworking.h"
#import "PersonalDataHeader_Cell.h"
#import "PersonalDataSecond_Cell.h"
#import "PersonalDataThird_Cell.h"
#import "Personal_introduction_VC.h"
#import "Certification_VC.h"
#import "ChooseShop.h"

@interface PersonalData_VC () {

    NSArray *nameArr; // cell 标题
    PersonalDataModel *_model;
    NSString *_selectAddressStr; // 选择的地址
    NSString *_selectDateValue;  // 选择的时间

}


@end

@implementation PersonalData_VC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kUserData;
    kWeakSelf;
    NSDictionary *params = @{ @"opt" : @"material", kToken : userInfo.token };
    [XXNetWorkManager requestWithMethod:POST
        withParams:params
        withUrlString:kPersonalServlet
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"个人资料详情页 -  %@", objc);
           kInspectSignInType

            if (code == 200) {

                
                _model = [PersonalDataModel mj_objectWithKeyValues:data];

                // 初始化信息
                _selectDateValue = _model.date;
                _selectAddressStr = _model.home;

                [weakSelf.tableview reloadData];
            }
        }
        withFailuerBlock:^(id error){

        }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableview];


    self.navigationItem.title = @"个人资料";
    // Do any additional setup after loading the view.
}

- (void)configTableview {
    kUserData;
    nameArr = @[
                @[ @"头像" ], @[ @"昵称", @"真实姓名", @"性别", @"出生日期", @"家乡" ],
                @[ @"个性标签", @"个人介绍" ,@"我的推荐码"], @[ @"从业年限",@"选择店铺" ]
                ];
   if ([userInfo.status intValue] == 1) {  // 游客
       nameArr = @[
                   @[ @"头像" ], @[ @"昵称", @"真实姓名", @"性别", @"出生日期", @"家乡" ],
                   @[ @"个性标签", @"个人介绍" ], @[ @"从业年限" ]
                   ];
    }

    self.view.backgroundColor = kAllRGB;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view);
    }];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PersonalDataHeader_Cell class]) bundle:nil]
         forCellReuseIdentifier:@"PersonalDataHeader_Cell_ID"];

    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PersonalDataSecond_Cell class]) bundle:nil]
         forCellReuseIdentifier:@"PersonalDataSecond_Cell_ID"];

    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PersonalDataThird_Cell class]) bundle:nil]
         forCellReuseIdentifier:@"PersonalDataThird_Cell_ID"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return nameArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [nameArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonalDataHeader_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataHeader_Cell_ID"];

        [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:kImageNamed(@"icon")];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        PersonalDataThird_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataThird_Cell_ID"];
        cell.sexType = _model.sex;
        return cell;
    } else {
        PersonalDataSecond_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataSecond_Cell_ID"];
        cell.titleL.text = nameArr[indexPath.section][indexPath.row];

        if (indexPath.section == 1 && indexPath.row == 0) {
            kStringIsEmpty(_model.name) ? (cell.dataL.text = @"设置昵称") : (cell.dataL.text = _model.name);


        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            kStringIsEmpty(_model.real_name) ? (cell.dataL.text = @"") : (cell.dataL.text = _model.real_name);
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            cell.renzhengButton.hidden = NO;
             ([_model.attestation intValue] == 1) ? [cell.renzhengButton setTitle:@" 已实名认证 " forState:UIControlStateNormal] : [cell.renzhengButton setTitle:@" 未实名认证 " forState:UIControlStateNormal];
        } else {
            cell.renzhengButton.hidden = YES;

        }
        if (indexPath.section == 1 && indexPath.row == 3) { // 生日
            cell.dataL.text = _selectDateValue;
        }
        if (indexPath.section == 1 && indexPath.row == 4) { // 家乡
            cell.dataL.text = _selectAddressStr;
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
            if (_model.labelArr.count == 0) {
                cell.dataL.text = @"设置标签";

            } else {
                cell.dataL.text = @"修改标签";

            }
        }
        if (indexPath.section == 2 && indexPath.row == 1) {
            kStringIsEmpty(_model.introduce) ? (cell.dataL.text = @"去填写") : (cell.dataL.text = _model.introduce);
        }

        if (indexPath.section == 2 && indexPath.row == 2) {
            kUserData;
            cell.dataL.text = userInfo.zjyqm;   // 推荐码

        }


        if (indexPath.section == 3 && indexPath.row == 0) {
            cell.dataL.text =
                kStringIsEmpty(_model.work_limit) ? @"请填写从业年限" : kString(@"%@ 年", _model.work_limit);
        }
        if (indexPath.section == 3 && indexPath.row == 1) {
            cell.dataL.text = _model.m_name;
        }

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 85;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf;
    if (indexPath.section == 1 && indexPath.row == 1) {
        Certification_VC * vc = [[Certification_VC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 3) { // 出生日期
        NSString *str1 = [XXHelper currentTime];
        [BRDatePickerView
            showDatePickerWithTitle:@""
                           dateType:UIDatePickerModeDate
                    defaultSelValue:_selectDateValue
                         minDateStr:@"1900-01-01 00:00:00"
                         maxDateStr:str1
                       isAutoSelect:NO
                        resultBlock:^(NSString *selectValue) {
                            kUserData;
                            NSDictionary *params = @{ kOpt : @"date", kToken : userInfo.token, @"date" : selectValue };
                            [XXNetWorkManager requestWithMethod:POST
                                withParams:params
                                withUrlString:kPersonalServlet
                                withHud:@"修改日期..."
                                withProgressBlock:^(float requestProgress) {

                                }
                                withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                    if (code == 200) {
                                        _selectDateValue = selectValue;

                                        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:3 inSection:1];
                                        [weakSelf.tableview
                                            reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1, nil]
                                                  withRowAnimation:UITableViewRowAnimationNone];
                                        [XXProgressHUD showSuccess:message];
                                    } else {
                                        [XXProgressHUD showError:message];
                                    }
                                }
                                withFailuerBlock:^(id error){

                                }];

                        }];
    }
    if (indexPath.section == 1 && indexPath.row == 4) { // 家乡

        [BRAddressPickerView
            showAddressPickerWithDefaultSelected:@[ @9, @0, @0 ]
                                    isAutoSelect:NO
                                     resultBlock:^(NSArray *selectAddressArr) {
                                         NSString *tempStr1 = @"";
                                         kUserData;
                                         for (NSString *Str1 in selectAddressArr) {
                                             tempStr1 = [tempStr1 stringByAppendingString:Str1];
                                         }
                                         NSLog(@"oo - %@", tempStr1);
                                         NSDictionary *params =
                                             @{ kOpt : @"home",
                                                kToken : userInfo.token,
                                                @"home" : tempStr1 };
                                         [XXNetWorkManager requestWithMethod:POST
                                             withParams:params
                                             withUrlString:kPersonalServlet
                                             withHud:@"修改地址..."
                                             withProgressBlock:^(float requestProgress) {

                                             }
                                             withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                                 if (code == 200) {
                                                     _selectAddressStr = @"";
                                                     for (NSString *Str1 in selectAddressArr) {
                                                         _selectAddressStr =
                                                             [_selectAddressStr stringByAppendingString:Str1];
                                                     }

                                                     //一个cell刷新
                                                     NSIndexPath *indexPath1 =
                                                         [NSIndexPath indexPathForRow:4 inSection:1];
                                                     [weakSelf.tableview
                                                         reloadRowsAtIndexPaths:[NSArray
                                                                                    arrayWithObjects:indexPath1, nil]
                                                               withRowAnimation:UITableViewRowAnimationAutomatic];
                                                     [XXProgressHUD showSuccess:message];
                                                 } else {
                                                     [XXProgressHUD showError:message];
                                                 }
                                             }
                                             withFailuerBlock:^(id error){

                                             }];

                                     }];
    }

    if (indexPath.section == 1 && indexPath.row == 0) {
        ConfigNameDate_VC *configVc = [ConfigNameDate_VC viewControllerFromNib];
        configVc.navigationItem.title = @"设置昵称";
        configVc.oldStr = _model.name;
        configVc.type = 0;
        [weakSelf.navigationController pushViewController:configVc animated:YES];
    }


    if (indexPath.section == 3 && indexPath.row == 0) {
        ConfigNameDate_VC *configVc = [ConfigNameDate_VC viewControllerFromNib];
        configVc.navigationItem.title = @"设置从业年限";
        configVc.oldStr = _model.work_limit;
        configVc.type = 1;
        [weakSelf.navigationController pushViewController:configVc animated:YES];
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        ChooseShop * vc = [[ChooseShop alloc]init];
        vc.dianPuNameNow = _model.m_name;
        [self.navigationController pushViewController:vc animated:YES];
#pragma mark - 跳转修改门店
    }

    if (indexPath.section == 0) {

        PersonalDataHeader_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {
            
             #pragma mark - 上传头像文件
            UIImage * image1 = photos[0];

            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"file"] = image1;
            
            NSString * url = [NSString stringWithFormat:@"%@Uploader",kBaseURL];
            [XHNetworking POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                BOOL isSingle =  [image1 isKindOfClass:[UIImage class]];
                if (isSingle)
                {
                    NSData *data = UIImageJPEGRepresentation(image1, 0.65);

                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];

                    [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(id responseObject) {
                NSLog(@"上传图片------------------%@",responseObject);
                if ([responseObject[@"code"] intValue] == 200) {
                    [XXProgressHUD showSuccess:responseObject[@"message"]];
                    
                    [self updataImageIcon:responseObject[@"data"]];
                } else {
                    [XXProgressHUD showError:responseObject[@"message"]];
                }

            } failure:^(NSError *error) {
                return;
            }];
//
           
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [weakSelf.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
                                   target:self
                           selectedAssets:nil
                                 maxCount:1
                                   isIcon:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        MyTags_VC *vc = [[MyTags_VC alloc] init];
        NSMutableArray * arr = [NSMutableArray array];
        for (TagsModel * modelL in  _model.labelArr) {

            [arr addObject:modelL.bname];

        }
        vc.tagsNameArr = (NSArray *)arr;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.section == 2 && indexPath.row == 1) {
        //介绍
        Personal_introduction_VC *vc = [[Personal_introduction_VC alloc] init];
        vc.oldIntroduce = _model.introduce;


        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 2) {

    }

}

// MARK: ------ 请求头像地址 ------
-(void) updataImageIcon:(NSString *)Url {
    kUserData;
    kWeakSelf;
    NSDictionary * params = @{
                              kOpt : @"pic",
                              kToken : userInfo.token,
                              @"pic" : Url
                              };
    [XXNetWorkManager requestWithMethod:POST withParams: params withUrlString:kPersonalServlet withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        if (code == 200) {
            _model.pic = [NSString stringWithFormat:@"%@%@",kImgBaseURL,Url];

            userInfo.pic = [NSString stringWithFormat:@"%@%@",kImgBaseURL,Url];
            [UserInfoTool saveAccount:userInfo];
            
            NSLog(@"22222- %@",userInfo.pic);
            NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
            [weakSelf.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } withFailuerBlock:^(id error) {
        
    }];
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view1.backgroundColor = kAllRGB;
    return view1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
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
