//
//  MainCalculatorsViewController.m
//  Product
//
//  Created by HJ on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MainCalculatorsViewController.h"
#import "PushTypeViewController.h"
#import "PushLiLvViewController.h"

#import "MoneyDetails_VC.h"
#import "LXFHouseLoanCalculator.h"
@interface MainCalculatorsViewController ()
@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (nonatomic, strong) LXFHouseLoanCalcModel *calcModel;
@property (nonatomic, strong) LXFHouseLoanResultModel *resultModel;

/**
 还款类型
 */
@property (nonatomic, copy) NSString *HKType;
/**
 贷款类型
 */
@property (nonatomic, assign) int DKType;
/**
 利率
 */
@property (nonatomic, assign) float rate;
@property (nonatomic ,assign) float rateTwo;



@end

@implementation MainCalculatorsViewController

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"计算"];

}


-(void)requestData {

    NSDictionary * dict = @{
                            kOpt : @"daikuanxiangqin",

                            @"type" : @"1",
                            @"amountmoney" : @"10000000000000",
                            @"rate" : @"4.9",
                            @"year" : @"10"
                            };
    [XXNetWorkManager requestWithMethod:POST withParams:dict withUrlString:@"News" withHud:@"计算数据..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
//        XXLog(@"ccccc - %@",objc);
    } withFailuerBlock:^(id error) {

    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _HKType = @"1";
    _DKType = 0;


    self.titleTwo.hidden = YES;
    self.MoneyTwo.hidden = YES;
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view1Layout.constant = 0.001;
    self.view2Layout.constant = 0.001;

    self.title = @"房贷计算器";
    _toolView.backgroundColor = [UIColor colorWithPatternImage:kImageNamed(@"background_Nav")];
    [_lilvTwo centerHorizontallyImageAndTextWithPadding:-20];
    [self updateUI];
    kWeakSelf;
    [[kNoteCenter rac_addObserverForName:@"doneAction" object:nil]
        subscribeNext:^(NSNotification *_Nullable x) {

            [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"计算"];

            if (kStringIsEmpty(_TF_year.text)) {
                [_TF_year becomeFirstResponder];
                return ;
            }
            if (kStringIsEmpty(_TF_money.text)) {
                [_TF_year becomeFirstResponder];
                return ;
            }
            if (_rate == 0) {

                return ;
            }

            [weakSelf computeData];

        }];

}
- (void)updateUI {
    [self.BXBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.BXBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self.BJBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.BJBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    self.BXBtn.selected = YES;
    self.BJBtn.selected = NO;

    [_typeBtn centerHorizontallyImageAndTextWithPadding:-20];
    [_liLvBtn centerHorizontallyImageAndTextWithPadding:-20];

    

}

- (IBAction)chooseTypeClick:(UIButton *)sender {

    [self.view endEditing:YES];
    PushTypeViewController *VC = [[PushTypeViewController alloc] init];
    VC.chooseType = ^(NSString *type, int Num) {

        [self.typeBtn setTitle:type forState:0];

        CGSize titleLabelSize = [self.typeBtn.titleLabel.text
            sizeWithAttributes:@{NSFontAttributeName : self.typeBtn.titleLabel.font}];
        self.typeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [self.typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -titleLabelSize.width + 5)];
        [self.navigationController
            dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
        kWeakSelf;
        if (Num != _DKType) {
            [_liLvBtn setTitle:@"0.00" forState:UIControlStateNormal];
        }
        _DKType = Num;
        if (Num == 2) {
            self.view1.hidden = 0;
            self.view2.hidden = 0;
            self.view1Layout.constant = 45;
            self.view2Layout.constant = 45;
        } else {
            self.view1.hidden = YES;
            self.view2.hidden = YES;
            self.view1Layout.constant = 0.001;
            self.view2Layout.constant = 0.001;
        }
        [weakSelf computeData];

    };

    [self.navigationController presentPopupViewController:VC
                                            animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (IBAction)chooseLiLv:(id)sender {

    [self.view endEditing:YES];
    PushLiLvViewController *VC = [[PushLiLvViewController alloc] init];

    if (_DKType == 1) {
        VC.type = @"1";
    } else {
        VC.type = @"0";
    }
    kWeakSelf;
    VC.chooseLiLv = ^(NSString *type, float rate) {

        [self.liLvBtn setTitle:kString(@"%.2f", rate) forState:0];
        _rate = rate;

        [self.navigationController
            dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
        [weakSelf computeData];
    };
    [self.navigationController presentPopupViewController:VC
                                            animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (IBAction)BXClick:(UIButton *)sender {
    [self.view endEditing:YES];
    self.BXBtn.selected = YES;
    self.BJBtn.selected = NO;
    self.titleTwo.hidden = YES;
    self.MoneyTwo.hidden = YES;
    self.typeDetailsLabel.text = @"等额本息还款详情";
    _HKType = @"1";
    [self computeData];

}
- (IBAction)BJBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    self.BXBtn.selected = NO;
    self.BJBtn.selected = YES;

    self.titleTwo.hidden = NO;
    self.MoneyTwo.hidden = NO;
    self.typeDetailsLabel.text = @"等额本金还款详情";
    _HKType = @"2";
    [self computeData];

}
#pragma mark----------- 看详情
- (IBAction)lookDetailsClick:(id)sender {
    if (!_resultModel.monthRepaymentArr.count) {
        return;
    }
    MoneyDetails_VC *VC = [[MoneyDetails_VC alloc] init];

    VC.vcType = [_HKType intValue];

    kUserData;
    VC.DKType = _DKType;
    userInfo.jisuanqiDic = [_calcModel mj_JSONObject];
    [UserInfoTool saveAccount:userInfo];

    _allMoneyLabel.text = kString(@"%.2f", _resultModel.repayTotalPrice); // 总还款
    if ([_allMoneyLabel.text isEqualToString:@"nan"]) {
        _allMoneyLabel.text = @"0.00";
    }
    VC.str1 = kString(@"%@", _allMoneyLabel.text);

    _interestLabel.text = kString(@"%.2f", _resultModel.interestPayment); // 总利息

    if ([_interestLabel.text isEqualToString:@"nan"]) {
        _interestLabel.text = @"0.00";
    }

    VC.str2 = _interestLabel.text;

    VC.str3 = kString(@"%.3f", [_money_TF.text floatValue] + [_TF_money.text floatValue] );

    VC.str4 = kString(@"%d", [self.TF_year.text intValue]);
    [self.navigationController pushViewController:VC animated:YES];
}

// MARK: ------ 计算数据 ------

- (void)computeData {


    if (_rateTwo == 2) {
        [XXProgressHUD showMessage:@"请选择利率"];
        return;
    }

    if ( kStringIsEmpty(_TF_money.text)) {
        [XXProgressHUD showMessage:@"请输入金额"];
        [_TF_money becomeFirstResponder];
        return;

    }
    if ( kStringIsEmpty(_TF_year.text)) {
        [XXProgressHUD showMessage:@"请输入年限"];
        [_TF_year becomeFirstResponder];
        return;

    }
    if ( [_TF_year.text intValue]>70) {
        [XXProgressHUD  showMessage:@"年限不得大于七十年"];
        [_TF_year becomeFirstResponder];
        return;

    }

    if (_rate == 0) {
        [XXProgressHUD showMessage:@"请选择利率之后再进行计算"];
        return;
    }
    if ( _DKType == 2 && kStringIsEmpty( _money_TF.text)) {
        [XXProgressHUD showMessage:@"请输入公积金金额"];
        [_money_TF becomeFirstResponder];
        return;
    }

    LXFHouseLoanCalcModel *calcModel = [LXFHouseLoanCalcModel new];
    calcModel.mortgageYear = [_TF_year.text floatValue]; // 年数

    _calcModel = calcModel;

    if ([_HKType intValue] == 1) { // 等额本息

        switch (_DKType) {
            case 0:                    // 商业贷款
                calcModel.businessTotalPrice = [_TF_money.text floatValue]* 10000; // 商业贷款总额
                calcModel.bankRate = _rate;                                 // 银行利率

                _resultModel = [LXFHouseLoanCalculator
                    calculateBusinessLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:
                        _calcModel];

                break;
            case 1:                                                     // 公积金贷款
                calcModel.fundTotalPrice = [_TF_money.text floatValue] * 10000; // 公积金贷款总额
                calcModel.fundRate = _rate;
                _resultModel = [LXFHouseLoanCalculator
                    calculateFundLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:_calcModel];
                break;
            case 2: //  组合贷款

                _calcModel.mortgageYear = [_TF_year.text intValue];
                _calcModel.fundRate = _rateTwo;  // 公积金利率
                _calcModel.bankRate = _rate;
                _calcModel.fundTotalPrice = [_money_TF.text doubleValue]* 10000;
                _calcModel.businessTotalPrice = [_TF_money.text doubleValue] * 10000;

                _resultModel = [LXFHouseLoanCalculator calculateCombinedLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:_calcModel];


                break;

            default:
                break;
        }
    }

    // MARK: ------ 本金本息分割线 ------

    if ([_HKType intValue] == 2) { // 等额本金

        switch (_DKType) {
            case 0:                                                         // 商业贷款
                calcModel.businessTotalPrice = [_TF_money.text floatValue] * 10000; // 商业贷款总额
                calcModel.bankRate = _rate;                                 // 银行利率

                _resultModel = [LXFHouseLoanCalculator
                    calculateBusinessLoanAsTotalPriceAndEqualPrincipalWithCalcModel:_calcModel];

                break;
            case 1:                                                     // 公积金贷款
                calcModel.fundTotalPrice = [_TF_money.text floatValue] * 10000 ; // 公积金贷款总额
                calcModel.fundRate = _rate;
                _resultModel = [LXFHouseLoanCalculator
                    calculateFundLoanAsTotalPriceAndEqualPrincipalWithCalcModel:_calcModel];

                break;
            case 2: //  组合贷款

                _calcModel.fundRate = _rateTwo;  // 公积金利率
                _calcModel.bankRate = _rate;
                _calcModel.fundTotalPrice = [_money_TF.text doubleValue] * 10000;
                _calcModel.businessTotalPrice = [_TF_money.text doubleValue]* 10000;

                _resultModel = [LXFHouseLoanCalculator calculateCombinedLoanAsTotalPriceAndEqualPrincipalWithCalcModel:_calcModel];
                break;

            default:
                break;
        }
    }
#pragma mark - if 结束



    NSLog(@"AAAA -- %@", _resultModel.monthRepaymentArr);

    _allMoneyLabel.text = kString(@"%.2f", _resultModel.repayTotalPrice); // 4

    if ([_allMoneyLabel.text isEqualToString:@"nan"]) {
        _allMoneyLabel.text = @"0.00";
    }

    _interestLabel.text = kString(@"%.2f", _resultModel.interestPayment); // 3

    if ([_interestLabel.text isEqualToString:@"nan"]) {
        _interestLabel.text = @"0.00";
    }


        _MoneyTwo.text = kString(@"%.2f",  _resultModel.decrease ); // 2




    _monthMoney.text = kString(@"%.2f", _resultModel.firstMonthRepayment);  //1

    if ([_monthMoney.text isEqualToString:@"inf"] || [_monthMoney.text isEqualToString:@"nan"]) {
        _monthMoney.text = @"0.00";
    }
}



- (IBAction)lilvTwoAction:(UIButton *)sender {

    [self.view endEditing:YES];
    PushLiLvViewController *VC = [[PushLiLvViewController alloc] init];
    VC.type = @"1";
    kWeakSelf;
    VC.chooseLiLv = ^(NSString *type, float rate) {
        [_lilvTwo setTitle:kString(@"%.2f", rate) forState:UIControlStateNormal];

        _rateTwo = rate;
        [self.navigationController
         dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
        [weakSelf computeData];

    };
    [self.navigationController presentPopupViewController:VC
                                            animationType:MJPopupViewAnimationSlideBottomBottom];

}
@end
