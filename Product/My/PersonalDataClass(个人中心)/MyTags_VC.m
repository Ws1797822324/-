//
//  MyTags_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyTags_VC.h"

#import "XXDeleteButton.h"

@interface MyTags_VC ()

@property (nonatomic, strong) SQButtonTagView *tagView0;
@property (nonatomic, strong) NSMutableArray *dataArray0;


@property (nonatomic, strong) SQButtonTagView *tagView1;
@property (nonatomic, strong) NSMutableArray *dataArray1;

@property (nonatomic, strong) SQButtonTagView *tagView2;
@property (nonatomic, strong) NSMutableArray *dataArray2;

@property (nonatomic, strong) SQButtonTagView *tagView3;
@property (nonatomic, strong) NSMutableArray *dataArray3;

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *dataIDArr1;
@property (nonatomic, strong) NSMutableArray *dataIDArr2; // 这三个  上传时候用
@property (nonatomic, strong) NSMutableArray *dataIDArr3;

@property (nonatomic, strong) NSMutableArray *dataIDArr; // 标签 ID  删除标签时候用

@property (nonatomic, strong) NSMutableArray *selectTagsNameArray;

@property (nonatomic ,strong) NSMutableArray *nameArray;


@end

@implementation MyTags_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _nameArray = [NSMutableArray arrayWithObjects:@[],@[],@[], nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个性标签(最多六个)";
    // Do any additional setup after loading the view from its nib.
    [self requestData];
}

- (void)requestData {
    kUserData;
    NSDictionary *params = @{
        kToken : userInfo.token,
        kOpt : @"glabel",
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:params
        withUrlString:kPersonalServlet
        withHud:@"刷新标签"
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"biaoqian - %@",objc);
            if (code == 200) {
                _dataArray = [TagsGroupModel mj_objectArrayWithKeyValuesArray:data];

                _dataArray1 = [NSMutableArray array];
                _dataArray2 = [NSMutableArray array];
                _dataArray3 = [NSMutableArray array];
                _dataIDArr = [NSMutableArray array];
                _dataIDArr1 = [NSMutableArray array];
                _dataIDArr2 = [NSMutableArray array];
                _dataIDArr3 = [NSMutableArray array];

                for (int i = 0; i < _dataArray.count; i++) {

                    for (TagsModel *obj in [_dataArray[i] tagesGroupArr]) {

                        if (i == 0) {
                            [_dataArray1 addObject:obj.name];
                            [_dataIDArr1 addObject:obj.ID];

                        } else if (i == 1) {
                            [_dataArray2 addObject:obj.name];
                            [_dataIDArr2 addObject:obj.ID];

                        } else if (i == 2) {
                            [_dataArray3 addObject:obj.name];
                            [_dataIDArr addObject:obj.ID];
                            [_dataIDArr3 addObject:obj.ID];
                        }
                    }
                }

                [self configUI_dataArrF:_dataArray1 dataArrS:_dataArray2 dataArrT:_dataArray3];

            } else {
                [self configUI_dataArrF:@[ @"描述标签" ]
                               dataArrS:@[ @"服务标签" ]
                               dataArrT:@[ @"定义标签" ]];

                [XXProgressHUD showError:message];
            }
        }
        withFailuerBlock:^(id error){

        }];
}
- (void)configUI_dataArrF:(NSArray *)dataArrF dataArrS:(NSArray *)dataArrS dataArrT:(NSArray *)dataArrT {
    kWeakSelf

        _scrollview = [[UIScrollView alloc] init];
    _selectTagsNameArray = [NSMutableArray arrayWithObjects:@[], @[], @[], nil];
    [self.view addSubview:_scrollview];
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.right.equalTo(weakSelf.view);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UILabel *labe1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 10)];
    labe1.backgroundColor = kRGB_HEX(0xe6e6e6);
    [self.scrollview addSubview:labe1];

    UILabel * tagsLabel = [[UILabel alloc]init];
    tagsLabel.text = @"已有标签";
    tagsLabel.textColor = kRGB_HEX(0xC6C6C6);
    tagsLabel.font = kBoldFont(18);
    [self.scrollview addSubview:tagsLabel];

    tagsLabel.sd_layout
    .leftSpaceToView(self.scrollview, 25)
    .rightSpaceToView(self.scrollview, 20)
    .topSpaceToView(self.scrollview, 30);

    UILabel * tagsL = [[UILabel alloc]init];
    if (_tagsNameArr.count) {
        tagsL.text = [_tagsNameArr componentsJoinedByString:@"  "];

    } else {
        tagsL.text = @"请您设置您的第一个标签";
    }
    tagsL.textColor = kRGB_HEX(0x929292);
    tagsL.font = kBoldFont(16);
    [self.scrollview addSubview:tagsL];

    tagsL.sd_layout
    .leftSpaceToView(self.scrollview, 25)
    .rightSpaceToView(self.scrollview, 20)
    .topSpaceToView(tagsLabel, 10)
    .autoHeightRatio(0);


    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = kRGB_HEX(0xD6D6D6);
    label2.font = kBoldFont(19);
    label2.text = @"自我描述";
    [self.scrollview addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scrollview).offset(25);
        make.top.equalTo(tagsL.mas_bottom).offset(20);
    }];

    _tagView1 = [[SQButtonTagView alloc] initWithTotalTagsNum:30
                                                    viewWidth:kWidth - 40
                                                      eachNum:0
                                                      Hmargin:10
                                                      Vmargin:10
                                                    tagHeight:30
                                                  tagTextFont:kFont(17)
                                                 tagTextColor:kRGB_HEX(0x929292)
                                         selectedTagTextColor:[UIColor whiteColor]
                                      selectedBackgroundColor:kRGB_HEX(0x0F83FA)
                                                         type:1
                                                           VC:nil];

    CGFloat height1 = [SQButtonTagView returnViewHeightWithTagTexts:dataArrF
                                                          viewWidth:kWidth - 40
                                                            eachNum:0
                                                            Hmargin:10
                                                            Vmargin:10
                                                          tagHeight:30
                                                        tagTextFont:[UIFont systemFontOfSize:17.f]];

    [weakSelf.tagView1 selectAction:^(SQButtonTagView *_Nonnull tagView, NSArray *_Nonnull selectArray) {
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr0 = [NSMutableArray array];

        for (NSString *str1 in selectArray) {
            [arr1 addObject:_dataIDArr1[[str1 intValue]]];
            [arr0 addObject:_dataArray1[[str1 intValue]]];
        }

        [_selectTagsNameArray replaceObjectAtIndex:0 withObject:arr1];
        [_nameArray replaceObjectAtIndex:0 withObject:arr0];


    }];

    [self.scrollview addSubview:_tagView1];
    self.tagView1.tagTexts = dataArrF;

    [_tagView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2).offset(30);
        make.height.mas_equalTo(height1);
        make.width.mas_equalTo(kWidth - 40);
        make.centerX.equalTo(weakSelf.scrollview.mas_centerX);
    }];
    self.tagView1.maxSelectNum = 6;

    UILabel *label3 = [[UILabel alloc] init];
    label3.textColor = kRGB_HEX(0xD6D6D6);
    label3.font = kBoldFont(19);
    label3.text = @"特色服务";
    [self.scrollview addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(_tagView1.mas_bottom).offset(20);
    }];

    _tagView2 = [[SQButtonTagView alloc] initWithTotalTagsNum:30
                                                    viewWidth:kWidth - 40
                                                      eachNum:0
                                                      Hmargin:10
                                                      Vmargin:10
                                                    tagHeight:30
                                                  tagTextFont:kFont(17)
                                                 tagTextColor:kRGB_HEX(0x929292)
                                         selectedTagTextColor:[UIColor whiteColor]
                                      selectedBackgroundColor:kRGB_HEX(0x0F83FA)
                                                         type:1
                                                           VC:nil];

    CGFloat height2 = [SQButtonTagView returnViewHeightWithTagTexts:dataArrS
                                                          viewWidth:kWidth - 40
                                                            eachNum:0
                                                            Hmargin:10
                                                            Vmargin:10
                                                          tagHeight:30
                                                        tagTextFont:[UIFont systemFontOfSize:17.f]];

    [weakSelf.tagView2 selectAction:^(SQButtonTagView *_Nonnull tagView, NSArray *_Nonnull selectArray) {


        NSMutableArray *arr2 = [NSMutableArray array];
        NSMutableArray *arr22 = [NSMutableArray array];
        for (NSString *str2 in selectArray) {
            [arr2 addObject:_dataIDArr2[[str2 intValue]]];
            [arr22 addObject:_dataArray2[[str2 intValue]]];
        }

        [_selectTagsNameArray replaceObjectAtIndex:1 withObject:arr2];
        [_nameArray  replaceObjectAtIndex:1 withObject:arr22];


    }];

    [self.scrollview addSubview:_tagView2];
    [_tagView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3).offset(30);
        make.height.mas_equalTo(height2);
        make.width.mas_equalTo(kWidth - 40);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    self.tagView2.tagTexts = dataArrS;
    self.tagView2.maxSelectNum = 6;

    UILabel *label4 = [[UILabel alloc] init];
    label4.textColor = kRGB_HEX(0xD6D6D6);
    label4.font = kBoldFont(19);
    label4.text = @"自定义标签";
    [self.scrollview addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(_tagView2.mas_bottom).offset(30);
    }];

    _tagView3 = [[SQButtonTagView alloc] initWithTotalTagsNum:30
                                                    viewWidth:kWidth - 40
                                                      eachNum:0
                                                      Hmargin:10
                                                      Vmargin:10
                                                    tagHeight:30
                                                  tagTextFont:kFont(17)
                                                 tagTextColor:kRGB_HEX(0x929292)
                                         selectedTagTextColor:[UIColor whiteColor]
                                      selectedBackgroundColor:kRGB_HEX(0x0F83FA)
                                                         type:3
                                                           VC:self];

    CGFloat height3 = [SQButtonTagView returnViewHeightWithTagTexts:dataArrT
                                                          viewWidth:kWidth - 40
                                                            eachNum:0
                                                            Hmargin:10
                                                            Vmargin:10
                                                          tagHeight:30
                                                        tagTextFont:[UIFont systemFontOfSize:17.f]];

    [weakSelf.tagView3 selectAction:^(SQButtonTagView *_Nonnull tagView, NSArray *_Nonnull selectArray) {

        NSMutableArray *arr3 = [NSMutableArray array];
        NSMutableArray *arr33 = [NSMutableArray array];
        for (NSString *str3 in selectArray) {
            [arr3 addObject:_dataIDArr3[[str3 intValue]]];
            [arr33 addObject:_dataArray3[[str3 intValue]]];
        }
        [_selectTagsNameArray replaceObjectAtIndex:2 withObject:arr3];
        [_nameArray replaceObjectAtIndex:2 withObject:arr33];



    }];

    [self.scrollview addSubview:_tagView3];
    [_tagView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(20);
        make.height.mas_equalTo(height3);
        make.width.mas_equalTo(kWidth - 40);
        make.centerX.equalTo(weakSelf.view.mas_centerX);

    }];
    self.tagView3.tagTexts = dataArrT;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:kImageNamed(@"zidingyibiaoqian") forState:UIControlStateNormal];
    [button sizeToFit];
    [self.scrollview addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {

        UIAlertController *actionSheetController =
            [UIAlertController alertControllerWithTitle:nil
                                                message:@"自定义标签"
                                         preferredStyle:UIAlertControllerStyleAlert];
        [actionSheetController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
            textField.placeholder = @"请输入标签";
        }];

        UIAlertAction *determineAction =
            [UIAlertAction actionWithTitle:@"确定"
                                     style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction *_Nonnull action) {
                                       kUserData;
                                       NSDictionary *params = @{
                                           kOpt : @"custom",
                                           kToken : userInfo.token,
                                           @"bname" : [actionSheetController.textFields.firstObject text]
                                       };

#pragma mark - 添加新标签的接口
                                       [XXNetWorkManager requestWithMethod:POST
                                           withParams:params
                                           withUrlString:kPersonalServlet
                                           withHud:@"添加自定义标签"
                                           withProgressBlock:^(float requestProgress) {

                                           }
                                           withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                                               kInspectSignInType if (code == 200) {
                                                   [XXProgressHUD showSuccess:message];
                                                   [button removeFromSuperview];

                                                   [weakSelf requestData];
                                               }
                                               else {
                                                   [XXProgressHUD showError:message];
                                               }
                                           }
                                           withFailuerBlock:^(id error){

                                           }];
                                   }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *_Nonnull action){

                                                             }];

        [actionSheetController addAction:determineAction];
        [actionSheetController addAction:cancelAction];

        [weakSelf presentViewController:actionSheetController animated:YES completion:nil];

    }];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tagView1);
        make.top.equalTo(weakSelf.tagView3.mas_bottom).offset(20);
        make.bottom.equalTo(weakSelf.scrollview.mas_bottom).offset(-30);

    }];

    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setBackgroundImage:kImageNamed(@"background_3") forState:UIControlStateNormal];
    [confirmButton sizeToFit];
    [confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];

    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-30);
    }];

    [_scrollview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(confirmButton.mas_top).offset(-10);
    }];

    [[confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
#pragma mark - 提交标签按钮
            kUserData;


            NSMutableArray *mArr = [NSMutableArray array];
            for (id arr in _selectTagsNameArray) {

                for (id str in arr) {
                    [mArr addObject:str];
                }
            }
            if (mArr.count>=6) {
                [XXProgressHUD showError:@"您最多只能选6个标签进行提交"];
                return ;
            }
            NSString *string = [mArr componentsJoinedByString:@","];

            NSDictionary *params = @{ kOpt : @"label", kToken : userInfo.token, @"label" : string };
            [XXNetWorkManager requestWithMethod:POST
                withParams:params
                withUrlString:kPersonalServlet
                withHud:@"提交标签"
                withProgressBlock:^(float requestProgress) {

                }
                withSuccessBlock:^(id objc, int code, NSString *message, id data) {

                    NSLog(@"-- 0000--%@", objc);
                    kInspectSignInType if (code == 200) {
                        [XXProgressHUD showSuccess:message];
                        [weakSelf.navigationController popViewControllerAnimated:true];
                    }
                    else {
                        [XXProgressHUD showError:message];
                    }

                }
                withFailuerBlock:^(id error){

                }];

        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)longClickAction:(UIButton *)button {
    kWeakSelf UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"删除这个自定义标签"
                                                                              message:button.titleLabel.text
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"取消"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *_Nonnull action){

                                               }];

    UIAlertAction *a2 = [UIAlertAction
        actionWithTitle:@"删除"
                  style:UIAlertActionStyleDestructive
                handler:^(UIAlertAction *_Nonnull action) {
#pragma mark - 删除标签接口
                    kUserData NSDictionary *paramas =
                        @{ kOpt : @"delete",
                           kToken : userInfo.token,
                           @"id" : _dataIDArr[button.tag - 101] };
                    [XXNetWorkManager requestWithMethod:POST
                        withParams:paramas
                        withUrlString:kPersonalServlet
                        withHud:@"删除标签"
                        withProgressBlock:^(float requestProgress) {

                        }
                        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                            kInspectSignInType if (code == 200) {
                                [XXProgressHUD showSuccess:message];

                                [_dataArray3 removeObjectAtIndex:button.tag - 101];
                                if (_dataArray3.count == 0) {
                                    [_tagView3 mas_updateConstraints:^(MASConstraintMaker *make) {
                                        make.height.mas_offset(0);
                                    }];
                                }
                                _tagView3.tagTexts = _dataArray3;
                                [weakSelf.scrollview removeFromSuperview];

                                [weakSelf requestData];
                            }
                            else {
                                [XXProgressHUD showError:message];
                            }
                        }
                        withFailuerBlock:^(id error){

                        }];

                }];
    [alertC addAction:a1];
    [alertC addAction:a2];

    [self presentViewController:alertC
                       animated:YES
                     completion:^{

                     }];
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
