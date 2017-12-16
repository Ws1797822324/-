//
//  MoneyDetailsA_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MoneyDetailsA_VC.h"
#import "MoneyDetails_View.h"
#import "MoneyDetailsHeaderView.h"
#import "MoneyDetails_Cell.h"

@interface MoneyDetailsA_VC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;


@end

@implementation MoneyDetailsA_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kUserData;
    self.navigationController.navigationBar.translucent = YES;

    _calcModel = [LXFHouseLoanCalcModel mj_objectWithKeyValues:userInfo.jisuanqiDic];
    switch (_DKType) {
        case 0:                                                         // 商业贷款
            _resultModel = [LXFHouseLoanCalculator
                            calculateBusinessLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:_calcModel];
            break;
        case 1:                                                     // 公积金贷款
            _resultModel = [LXFHouseLoanCalculator
                            calculateFundLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:_calcModel];
            break;
        case 2: //  组合贷款
            _resultModel = [LXFHouseLoanCalculator calculateCombinedLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:_calcModel];
            break;

        default:
            break;

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    if (kIOS11) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    UIView * bbView = [[UIView alloc]init];
    bbView.backgroundColor = kRGB_HEX(0x61a1d7);
    bbView.frame = CGRectMake(0, 0, kWidth, 61);
    [self.view addSubview:bbView];
    MoneyDetails_View * moneyViww = [MoneyDetails_View viewFromXib];
    moneyViww.text_L1.text = kString(@"%.2f", [self.str1 floatValue]/ 10000);
    moneyViww.text_L2.text = kString(@"%.2f", [self.str2 floatValue]/ 10000);;
    moneyViww.text_L3.text = kString(@"%.2f", [self.str3 floatValue]);
    moneyViww.text_L4.text = kString(@"%d", [self.str4 intValue] * 12);

    moneyViww.frame = CGRectMake(0, 0, kWidth, 60);
    moneyViww.backgroundColor =kRGB_HEX(0x61a1d7);
    [self.view addSubview:moneyViww];

    MoneyDetailsHeaderView * hViww = [MoneyDetailsHeaderView viewFromXib];
    hViww.label_W.constant = 70;
    hViww.frame = CGRectMake(0, 75, kWidth, 30);
    hViww.backgroundColor = [UIColor redColor];
    [self.view addSubview:hViww];

    self.tableview = [[UITableView alloc]init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[MoneyDetails_Cell nib] forCellReuseIdentifier:@"MoneyDetailsA_Cell"];
    self.tableview.frame = CGRectMake(0, 90, kWidth, kHeight - 90 -kNavHeight - 55);
    [self.view addSubview:_tableview];
    
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [_str4 integerValue];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoneyDetails_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyDetailsA_Cell"];


    cell.label_W.constant = (kWidth -40)/ 4;
    [cell configMonty:indexPath.row];
    [cell configYGZE: _resultModel.monthRepaymentArr[0]];
    [cell configYGBJ:_resultModel.ygbjArr Section:indexPath.section Row:indexPath.row];
    [cell configYGLX:_resultModel.ygbjArr Section:indexPath.section Row:indexPath.row YGZE: _resultModel.monthRepaymentArr[0]];
    [cell ConfigRemainder:_resultModel.remainderArr Section:indexPath.section Row:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 35)];
    view1.backgroundColor = kRGB_HEX(0xecf5fb);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 70, 30)];
    label.font = kFont(15);
    label.textColor = kRGB_HEX(0x0f83fa);

    label.text = kString(@"第%ld年", section + 1);

    [view1 addSubview:label];

    return view1;

}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
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
