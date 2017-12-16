//
//  PushTypeViewController.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PushTypeViewController.h"

@interface PushTypeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
    @property (nonatomic, strong)UIView * tools; // 顶部工具栏
    @property (nonatomic, strong) UIButton * sureBtn; // 确定按钮
    @property (nonatomic, strong) UIPickerView * pickView; // 滚动视图
    @property (nonatomic, strong) NSArray * dataArray;
@end

@implementation PushTypeViewController
- (void)viewWillLayoutSubviews{
    self.view.frame = CGRectMake(0, kHeight-250, kWidth, 250);
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSInteger Index = [self.pickView selectedRowInComponent:0];
    NSString * string = self.dataArray[Index];

    self.chooseType(string, (int)Index);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createdTopToolsView];
    self.dataArray = [NSArray arrayWithObjects:@"商业贷款",@"公积金贷款",@"组合贷款", nil];
    [self.view addSubview:self.pickView];
}
- (void)sureClik{
    NSInteger Index = [self.pickView selectedRowInComponent:0];
    NSString * string = self.dataArray[Index];
    self.chooseType(string, (int)Index);
}
- (void)createdTopToolsView{
    
    self.tools = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    [self.view addSubview:self.tools];
    
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = kRGB_HEX(0xfafafa);
    [self.tools addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    label.text = @"请选择贷款类型";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    
    self.sureBtn = [[UIButton alloc] init];
    [self.tools addSubview:self.sureBtn];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(50);
        make.centerY.mas_equalTo(label.centerY);
        make.height.mas_equalTo(30);
    }];
    [self.sureBtn setTitle:@"  确定  " forState:0];
    [self.sureBtn setTitleColor:kRGB_HEX(0x2880e3) forState:0];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    kViewRadius(self.sureBtn, 5);
    [self.sureBtn setBackgroundColor:kAllRGB];
    
    [self.sureBtn addTarget:self action:@selector(sureClik) forControlEvents:UIControlEventTouchUpInside];

}
- (UIPickerView *)pickView{
    if(!_pickView){
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kWidth, 250-40)];
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
    
    return self.dataArray[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

@end
