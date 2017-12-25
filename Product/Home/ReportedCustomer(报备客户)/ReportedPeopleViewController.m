//
//  ReportedPeopleViewController.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReportedPeopleViewController.h"
#import "LabelAndTFTableViewCell.h"
#import "ChooseSexTableViewCell.h"
#import "SureTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "BuyHouseIdeasViewController.h"
#import "HousesViewController.h"
#import "PhoneInputting_Cell.h"
#import "KeyInputTextField.h"
#import "MyPeopleTableViewController.h"

@interface ReportedPeopleViewController ()<UITableViewDelegate,UITableViewDataSource,KeyInputTextFieldDelegate>
    @property (nonatomic, strong) UITableView * tableView;
@property (nonatomic ,strong) NSArray *seleArr;


@property (nonatomic ,strong) NSString *sexStr;

@property (nonatomic ,strong) NSArray *yixiangArr;

@property (nonatomic ,strong) UITextField *nameTF;
@property (nonatomic ,strong) UITextField *phoneTF;
@property (nonatomic ,strong) UITextField *phone_leftTF;
@property (nonatomic ,strong) UITextField *phone_rightTF;
@property (nonatomic ,strong) NSString *phoneStr;

@property (nonatomic ,strong) UITextView *textview;

@end

@implementation ReportedPeopleViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (UITextField *)nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
    }
    return _nameTF;
}
- (UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] init];
    }
    return _phoneTF;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sexStr = @"1";

    self.title = @"报备客户";

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];

    [self.tableView registerNib:[UINib nibWithNibName:@"LabelAndTFTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LabelAndTFTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseSexTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChooseSexTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"SureTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SureTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"RemarkTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RemarkTableViewCell"];
    [self.tableView registerNib:[PhoneInputting_Cell nib] forCellReuseIdentifier:@"PhoneInputting_Cell"];


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 8)];
    view.backgroundColor = kRGB_HEX(0xfafafa);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if(indexPath.section==3){
            return 220;
        }else if(indexPath.section==4){
            return 80;
        }else{
            return 44;
        }
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1){
        return 3;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell){

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font  =[UIFont systemFontOfSize:15];
    cell.textLabel.textColor = kRGB_HEX(0x333333);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = kColor(204, 203, 209);
cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    LabelAndTFTableViewCell * LATFCell = [tableView dequeueReusableCellWithIdentifier:@"LabelAndTFTableViewCell"];
    LATFCell.selectionStyle = UITableViewCellSelectionStyleNone;
    ChooseSexTableViewCell * sexCell = [tableView dequeueReusableCellWithIdentifier:@"ChooseSexTableViewCell"];
    sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
    SureTableViewCell * sureCell = [tableView dequeueReusableCellWithIdentifier:@"SureTableViewCell"];
    kWeakSelf;

    [[sureCell.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf requestBBKH];
    }];
    sureCell.selectionStyle = UITableViewCellSelectionStyleNone;
    RemarkTableViewCell * remarkCell = [tableView dequeueReusableCellWithIdentifier:@"RemarkTableViewCell"];
    remarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {

        cell.textLabel.text = @"报备楼盘";
        _seleArr.count == 0
            ? (cell.detailTextLabel.text = @"请选择楼盘")
            : (cell.detailTextLabel.text = kString(@"您已选择%lu个楼盘", _seleArr.count));

        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LATFCell.titleLabel.text = @"姓名";
            LATFCell.TF_title.placeholder = @"请输入姓名";
            LATFCell.TF_title.textColor = [UIColor blackColor];
            self.nameTF = LATFCell.TF_title;
            return LATFCell;
        } else if (indexPath.row == 1) {

            if (_phoneType == 1) {
                PhoneInputting_Cell *cell = [PhoneInputting_Cell loadCellFromNib:tableView];
                cell.right_TF.keyInputDelegate = self;
                self.phone_rightTF = cell.right_TF;
                self.phone_leftTF = cell.left_TF;
                [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {

                    if (cell.left_TF.text.length == 3) {

                        [self.phone_rightTF becomeFirstResponder];
                    }
                }];
                return cell;

            }
            if (_phoneType != 1) {
                LATFCell.titleLabel.text = @"联系方式";
                LATFCell.TF_title.placeholder = @"请输入联系方式";
                LATFCell.TF_title.keyboardType = UIKeyboardTypeNumberPad;
                [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
                    if (LATFCell.TF_title.text.length >= 12) {
                        LATFCell.TF_title.text = [LATFCell.TF_title.text substringToIndex:11];
                    }

                }];
                _phoneTF = LATFCell.TF_title;

                return LATFCell;

            }
        }else if(indexPath.row==2){
            sexCell.sexBlock = ^(NSString *sex) {

                _sexStr = sex;
            };
            return sexCell;
        }
    }

    if (indexPath.section==2){
        cell.textLabel.text = @"购房意向";
        _yixiangArr.count == 0 ? (cell.detailTextLabel.text = @"请填写购房意向") : (cell.detailTextLabel.text = @"修改购房意向");

        return cell;
    }

    if (indexPath.section==3){
        _textview =  remarkCell.textView;
        return remarkCell;
    }

    if (indexPath.section==4){
        [sureCell.sureBtn setTitle:@"报备" forState:0];
        return sureCell;
    }

    return cell;
}

-(void)deleteBackward {
    if (kStringIsEmpty(_phone_rightTF.text)) {

        [_phone_leftTF becomeFirstResponder];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){  // 报备楼盘
        HousesViewController * VC = [[HousesViewController alloc] init];
        VC.selectedBlock = ^(NSArray *selectedBlockArray) {

            _seleArr = selectedBlockArray;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };

        VC.phoneTypeBlock = ^(int phoneType) {
            _phoneType = phoneType;
            //一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        };

        VC.array = _seleArr;
        VC.phoneTypeStr = kString(@"%d", _phoneType);

        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section==2){ // 购房意向
        kWeakSelf;
        BuyHouseIdeasViewController * VC = [[BuyHouseIdeasViewController alloc] init];

        VC.valueBlock = ^(NSArray *valve) {
            _yixiangArr = valve;

            NSIndexSet *s1 = [NSIndexSet indexSetWithIndex:2];
            [weakSelf.tableView reloadSections:s1 withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        VC.valueArray = _yixiangArr;


        [self.navigationController pushViewController:VC animated:YES];
    }
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - 报备客户接口请求

-(void) requestBBKH {
    kUserData;

    if (_yixiangArr.count == 0) {
        _yixiangArr = @[@"",@"",@"",@"",@""];
    }

    if (kStringIsEmpty(_nameTF.text) ) {
        [XXProgressHUD showMessage:@"姓名不能为空"];
        [_nameTF becomeFirstResponder];
        return;
    }
    if ([XXHelper JudgeTheillegalCharacter:_nameTF.text]) {
        [XXProgressHUD showMessage:@"名字中有非法字符"];
        return;
    }
    if (kStringIsEmpty(_phoneTF.text) && _phoneType != 1) {  // ==2
        [XXProgressHUD showMessage:@"联系方式不能为空"];
        [_phone_leftTF becomeFirstResponder];
        return;
    }

    if (![XXHelper isNumber:_phoneTF.text] && _phoneType != 1) { // == 2
        [XXProgressHUD showMessage:@"请输入正确的手机号"];
        [_phoneTF becomeFirstResponder];
        return;
    }
    if ( _phoneType == 1) {
        if (kStringIsEmpty(_phone_leftTF.text) || kStringIsEmpty(_phone_rightTF.text)) {
            [XXProgressHUD showMessage:@"手机号输入有误"];
            [_phone_rightTF becomeFirstResponder];
            return;
        }

    }

    if (_seleArr.count == 0) {
        [XXProgressHUD showMessage:@"至少选择一个楼盘"];
        return;
    }

    if (_phoneType == 1) {
        _phoneStr = [NSString stringWithFormat:@"%@****%@",_phone_leftTF.text,_phone_rightTF.text];
    }
    if (_phoneType != 1) {
        _phoneStr = _phoneTF.text;
    }
    NSDictionary * dic = @{
                           kOpt : @"tj_client",
                           kToken : userInfo.token,
                           @"name" : _nameTF.text,
                           @"phone" : _phoneStr,
                           @"sex": _sexStr,
                           @"l_id" : [_seleArr componentsJoinedByString:@","],
                           @"min_price_budget" :  _yixiangArr[0],
                           @"max_price_budget" :  _yixiangArr[1],
                           @"min_area" :  _yixiangArr[2],
                           @"max_area" : _yixiangArr[3],
                           @"nucleus" : _yixiangArr[4],
                           @"remark" : _textview.text,
                           };
    
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"客户报备中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        kInspectSignInType;
        kShowMessage;

        if (code == 200) {
            [XXProgressHUD showMessage:@"报备客户成功"];
            MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
            VC.title = @"已报备";
            VC.flag = @"1";
            [self.navigationController pushViewController:VC animated:YES];
        }


    } withFailuerBlock:^(id error) {

    }];


}

@end
