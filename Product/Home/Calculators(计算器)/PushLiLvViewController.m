//
//  PushLiLvViewController.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PushLiLvViewController.h"

@interface PushLiLvViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView * pickView; // 滚动视图
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) UIView * tools; // 自定义栏
@property (nonatomic ,strong) UITextField *TF_B;
@property (nonatomic ,strong) UITextField *TF_A;
@property (nonatomic ,assign) float baseRate;


@end

@implementation PushLiLvViewController
- (void)viewWillLayoutSubviews{
    self.view.frame = CGRectMake(0, kHeight-260, kWidth, 260);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSDictionary * dic = @{
                           kOpt : @"rate",
                           @"type" : _type
                           };

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:@"利率更新中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        XXLog(@"%@",objc);
        if (code == 200) {
            _dataArray = [RateModel mj_objectArrayWithKeyValuesArray:data];
            [_pickView reloadAllComponents];

            _TF_A.text = kString(@"%.2f", [[_dataArray[0] num] floatValue]);
            _baseRate = [[_dataArray[0] num] floatValue];
        } else {
            [XXProgressHUD showMessage:@"利率加载失败"];
        }

    } withFailuerBlock:^(id error) {

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    [self.view addSubview:label];
    label.backgroundColor = kRGB_HEX(0xfafafa);
    label.text = @"请选择利率折扣";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kRGB_HEX(0x575757);
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.pickView];
    [self createdBottomToolsView];
}
- (void)createdBottomToolsView{
    
    self.tools = [[UIView alloc] initWithFrame:CGRectMake(0, 240-60, kWidth, 60)];
    self.tools.backgroundColor = kRGB_HEX(0xfafafa);
    [self.view addSubview:self.tools];
    UILabel * label = [[UILabel alloc] init];
    [self.tools addSubview:label];
    label.text = @"自定义";
    label.font = [UIFont systemFontOfSize:16];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    
    UIButton * sureBtn = [[UIButton alloc] init];
    kViewRadius(sureBtn, 5);
    [self.tools addSubview:sureBtn];
    [sureBtn setTitle:@"确定" forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setBackgroundColor:kRGB_HEX(0x2880e3)];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(self.tools);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(35);
    }];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * beiLa = [[UILabel alloc] init];
    beiLa.text = @"倍";
    beiLa.font = [UIFont systemFontOfSize:16];
    [self.tools addSubview:beiLa];
    [beiLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tools);
        make.right.mas_equalTo(sureBtn.mas_left).offset(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(50);
    }];
    
    CGFloat width_TF = (kWidth-15-50-15-10-50-15-10-50)/2;
    
    UITextField * TF_B = [[UITextField alloc] init];
    _TF_B = TF_B;
    
    [self.tools addSubview:TF_B];
    TF_B.borderStyle = UITextBorderStyleRoundedRect;
    TF_B.keyboardType = UIKeyboardTypeDecimalPad;
    [TF_B mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(beiLa.mas_left).offset(-5);
        make.width.mas_equalTo(width_TF);
        make.bottom.mas_equalTo(-10);
    }];
    
    UILabel * bfbLa = [[UILabel alloc] init];
    [self.tools addSubview:bfbLa];
    bfbLa.font = [UIFont systemFontOfSize:14];
    bfbLa.text = @"%  X";
    [bfbLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(TF_B.mas_left).offset(-10);
        make.width.mas_equalTo(30);
        make.bottom.mas_equalTo(0);
    }];
    
    UITextField * TF_BFB = [[UITextField alloc] init];
    _TF_A = TF_BFB;

    TF_BFB.textColor = kRGB_HEX(0x969696);
    TF_BFB.userInteractionEnabled = NO;
    [self.tools addSubview:TF_BFB];
    TF_BFB.borderStyle = UITextBorderStyleRoundedRect;
    TF_BFB.keyboardType = UIKeyboardTypeNumberPad;
    [TF_BFB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(bfbLa.mas_left).offset(-10);
        make.width.mas_equalTo(width_TF);
        make.bottom.mas_equalTo(-10);
    }];
    
}
- (void)sureClick{
    NSInteger Index = [self.pickView selectedRowInComponent:0];
     float rate = [[self.dataArray[Index] num] floatValue];

    if (!kStringIsEmpty(_TF_B.text)) {
        rate = [_TF_B.text floatValue] * _baseRate;
    }
    self.chooseLiLv(kString(@"%ld", Index), rate);
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSInteger Index = [self.pickView selectedRowInComponent:0];
    float rate = [[self.dataArray[Index] num] floatValue];

    if (!kStringIsEmpty(_TF_B.text)) {
        rate = [_TF_B.text floatValue] * _baseRate;
    }
    self.chooseLiLv(kString(@"%ld", Index), rate);

    
}
- (UIPickerView *)pickView{
    if(!_pickView){
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kWidth, 240-40-50)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}
    // 1.设置列的返回数量
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
    // 2.设置列里边组件的个数 component:组件
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
    
}
    
    // 3.返回组件的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.dataArray[row] name];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


@end

#pragma mark - model
@implementation RateModel
@end
