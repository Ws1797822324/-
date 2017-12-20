//
//  ReportedSuccessViewController.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReportedSuccessViewController.h"
#import "LabelAndTFTableViewCell.h"
#import "ChooseSexTableViewCell.h"
#import "SureTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "SFZInputting_Cell.h"
#import "PhoneInputting_Cell.h"
#import "ReportedSuccessList_VC.h"

@interface ReportedSuccessViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic ,strong) NSString *sexStr;

@property (nonatomic ,strong) UITextField *name_TF;
@property (nonatomic ,strong) UITextField *houseName_TF;
@property (nonatomic ,strong) UITextField *sfz_TF;
@property (nonatomic ,strong) UITextField *phone_TF;
@property (nonatomic ,strong) UITextField *price_TF;
@property (nonatomic ,strong) XXTextView *beizhu_TV;





@end

@implementation ReportedSuccessViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _sexStr = @"0";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报备成交";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LabelAndTFTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"LabelAndTFTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseSexTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"ChooseSexTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"SureTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"SureTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"RemarkTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"RemarkTableViewCell"];
    [self.tableView registerNib:[PhoneInputting_Cell nib] forCellReuseIdentifier:@"PhoneInputting_Cell"];
    [self.tableView registerNib:[SFZInputting_Cell nib] forCellReuseIdentifier:@"SFZInputting_Cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 8)];
    view.backgroundColor = kRGB_HEX(0xfafafa);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 220;
    } else if (indexPath.section == 3) {
        return 80;
    } else {
        return 44;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LabelAndTFTableViewCell *LATFCell =
        [tableView dequeueReusableCellWithIdentifier:@"LabelAndTFTableViewCell"];
    LATFCell.selectionStyle = UITableViewCellSelectionStyleNone;
    ChooseSexTableViewCell *sexCell =
        [tableView dequeueReusableCellWithIdentifier:@"ChooseSexTableViewCell"];
    sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
    SureTableViewCell *sureCell =
        [tableView dequeueReusableCellWithIdentifier:@"SureTableViewCell"];
    sureCell.selectionStyle = UITableViewCellSelectionStyleNone;

    [[sureCell.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {

        [weakSelf requestAction];
    }];
    RemarkTableViewCell *remarkCell =
        [tableView dequeueReusableCellWithIdentifier:@"RemarkTableViewCell"];
     _beizhu_TV = remarkCell.textView;
    remarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        LATFCell.titleLabel.text = @"成交楼盘";
        LATFCell.TF_title.placeholder = @"请输入楼盘";
        _houseName_TF = LATFCell.TF_title;
        return LATFCell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LATFCell.titleLabel.text = @"姓名";
            LATFCell.TF_title.placeholder = @"请输入客户姓名";
            _name_TF = LATFCell.TF_title;
            return LATFCell;
        } else if (indexPath.row == 1) {

            SFZInputting_Cell * cell= [SFZInputting_Cell loadCellFromNib:tableView];
            _sfz_TF = cell.sfz_TF;
            return cell;
        }else if (indexPath.row == 2) {
            LATFCell.titleLabel.text = @"联系方式";
            LATFCell.TF_title.placeholder = @"请输入联系方式";
            LATFCell.TF_title.keyboardType = UIKeyboardTypeNumberPad;
            [[kNoteCenter rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
                if (LATFCell.TF_title.text.length >= 12) {
                    LATFCell.TF_title.text = [LATFCell.TF_title.text substringToIndex:11];
                }

                }];
            _phone_TF = LATFCell.TF_title;
            return LATFCell;
        } else if (indexPath.row == 3) {
            sexCell.sexBlock = ^(NSString *sex) {
                _sexStr = sex;
            };
            return sexCell;
        } else if (indexPath.row == 4) {
            LATFCell.titleLabel.text = @"成交价格";
            LATFCell.TF_title.placeholder = @"请输入成交价格";
            _price_TF = LATFCell.TF_title;
            _price_TF.keyboardType = UIKeyboardTypeDecimalPad;
            LATFCell.yuanLabel.hidden = NO;
            return LATFCell;
        }
    } else if (indexPath.section == 2) {
        return remarkCell;
    } else if (indexPath.section == 3) {

        return sureCell;
    }

    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
// 验证身份证号码
- (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}

#pragma mark -  报备成交接口
-(void) requestAction {
    NSLog(@"%@ -- %@ -- %@ -- %@ -- %@ -- %@ -- -- %@",_houseName_TF.text,_name_TF.text,_sfz_TF.text,_phone_TF.text,_price_TF.text,_beizhu_TV.text,_sexStr);
    kUserData;

    if (kStringIsEmpty(_houseName_TF.text)) {
        [XXProgressHUD showMessage:@"请输入楼盘名"];
        [_houseName_TF becomeFirstResponder];
        return;
    }
    if (kStringIsEmpty(_name_TF.text)) {
        [XXProgressHUD showMessage:@"请输入姓名"];
        [_name_TF becomeFirstResponder];
        return;
    }
    if ([XXHelper JudgeTheillegalCharacter:_name_TF.text]) {
        [XXProgressHUD showMessage:@"名字中有非法字符"];
        return;
    }
    if (kStringIsEmpty(_sfz_TF.text)) {
        [XXProgressHUD showMessage:@"请输入身份证号码"];
        [_sfz_TF becomeFirstResponder];
        return;
    }
    if (![self IsIdentityCard:_sfz_TF.text]) {
        [XXProgressHUD showMessage:@"请输入正确的身份证号码"];
        return;
    }
    if (kStringIsEmpty(_phone_TF.text)) {
        [XXProgressHUD showMessage:@"请输入联系方式"];
        [_phone_TF becomeFirstResponder];
        return;
    }
    if (![XXHelper isNumber:_phone_TF.text]) {
        [XXProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (kStringIsEmpty(_price_TF.text)) {
        [XXProgressHUD showMessage:@"请输入成交价格"];
        [_price_TF becomeFirstResponder];
        return;
    }


    NSDictionary * parmas = @{
                              kOpt : @"cj_report",
                              kToken : userInfo.token,
                              @"name" : _name_TF.text,
                              @"id_card" : _sfz_TF.text,
                              @"phone" : _phone_TF.text,
                              @"sex" : _sexStr,
                              @"l_name" : _houseName_TF.text,
                              @"cj_price" : _price_TF.text,
                              @"remark" : _beizhu_TV.text,
                              @"type" : @"2"
                              };

    [XXNetWorkManager requestWithMethod:POST withParams:parmas withUrlString:@"ClientServlet" withHud:@"报备客户" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"baobeiochenhjiap - %@",objc);
        if (code == 200) {
            [XXProgressHUD showSuccess:@"报备成功"];
            ReportedSuccessList_VC * vc = [[ReportedSuccessList_VC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [XXProgressHUD showError:@"报备失败"];
        }

    } withFailuerBlock:^(id error) {

    }];

}


@end
