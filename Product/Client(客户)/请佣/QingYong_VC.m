//
//  QingYong_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QingYong_VC.h"

#import "QingYong_FCell.h"
#import "QingYong_SCell.h"
#import "QingYong_TCell.h"
#import "LocationList_VC.h"
#import "QingYongFourth_Cell.h"
#import "HouseXQ_VC.h"
#import "PushTypeViewController.h"
@interface QingYong_VC ()<UITableViewDataSource,UITableViewDelegate,reloadSectionsDelegate>

@property (nonatomic ,assign) NSInteger cellNum;

@property (nonatomic ,strong) NSString *daiKuanTypeStr;
@property (nonatomic ,strong) UITextField *name_TF;
@property (nonatomic ,strong) UITextField *phone_TF;
@property (nonatomic ,strong) XXTextView *text_TV;
@property (nonatomic ,strong) UITextField *price_TF;
@property (nonatomic ,strong) UITextField *priceDK_TF; // 贷款 金额
@property (nonatomic ,strong) NSString *dkType; // 贷款类型

@property (nonatomic ,strong) NSString *l_id;  // 从成交地址里选的
//@property (nonatomic ,strong) NSString *l_name;  // 从成交地址里选的


@property (nonatomic ,strong) NSString *selectId;


@end

@implementation QingYong_VC


- (UITextField *)priceDK_TF
{
    if (!_priceDK_TF){
        _priceDK_TF = [[UITextField alloc] init];
    }
    return _priceDK_TF;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cellNum = 2;
    _dkType = @"0";
    _daiKuanTypeStr = @"商业贷款";
    kWeakSelf
    self.navigationItem.title = @"请佣详情";
    [self.view addSubview: weakSelf.tableview];
    self.view.backgroundColor = kAllRGB;
    self.tableview.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(kHeight - 75);
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([QingYong_FCell class]) bundle:nil] forCellReuseIdentifier:@"QingYong_FCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([QingYong_SCell class]) bundle:nil] forCellReuseIdentifier:@"QingYong_SCell_ID"];

    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([QingYong_TCell class]) bundle:nil] forCellReuseIdentifier:@"QingYong_TCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([QingYongFourth_Cell class]) bundle:nil] forCellReuseIdentifier:@"QingYongFourth_Cell_ID"];
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"申请佣金" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:kImageNamed(@"background_3") forState:UIControlStateNormal];

    [button addTarget:self action:@selector(shenqingyongjin) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    button.sd_layout
    .leftSpaceToView(self.view, 20)
    .widthIs(kWidth - 40)
    .heightIs(45)
    .bottomSpaceToView(self.view, 20);

    // Do any additional setup after loading the view.
}
#pragma mark - 申请佣金
-(void)shenqingyongjin {

    XXLog(@" -%@ -- %@ --- %@ ---- %@ == %@",_name_TF.text,_phone_TF.text,_text_TV.text,_price_TF.text,_priceDK_TF.text);
    XXLog(@"%@ ==",self.priceDK_TF.text);


    if (kStringIsEmpty(_name_TF.text)) {
        [XXProgressHUD showMessage:@"请输入姓名"];
        return;
    }
    if (kStringIsEmpty(_phone_TF.text)) {
        [XXProgressHUD showMessage:@"请输入联系方式"];
        return;

    }
    if (![XXHelper isNumber:_phone_TF.text]) {
        [XXProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (kStringIsEmpty(_l_id)) {
        [XXProgressHUD showMessage:@"请选择一个地址"];
        return;
    }
    kUserData;
    NSString *str1 = @"0";
    if (_cellNum == 2) {
        str1 = @"0";
    } else {
        str1 = @"1";
    }
    NSDictionary * dic = @{
                           kOpt : @"addCommission",
                           kToken : userInfo.token,
                           @"clientid" : _khID,
                           @"loans" : str1,   // 是否贷款   1 是  0 否
                           @"remark" : _text_TV.text,
                           @"brokerage" : _price_TF.text,  // 佣金
                           @"loans_type" : _dkType,  // 贷款类型
                           @"money" : _priceDK_TF.text , // 贷款金额
                           @"l_id" : _l_id, // 楼盘 ID
                           @"type" : @"1",   //  报备
                           @"report" : _fwID
                           };
    NSLog(@"%@",dic);


    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"Commission" withHud:@"请佣中..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        XXLog(@"%@",objc);
        kInspectSignInType;
        if (code == 200) {
            [XXProgressHUD showSuccess:@"请佣成功"];
        } else {
            [XXProgressHUD showError:@"申请佣金失败"];
        }
    } withFailuerBlock:^(id error) {

    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 4 || section == 3) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 4;

    }
    else  {
        return 8;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ((indexPath.section == 0) || (indexPath.section == 1) || (indexPath.section == 4) || (indexPath.section == 2 && indexPath.row == 0)) {
        QingYong_FCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QingYong_FCell_ID"];

        [cell configCellView:indexPath];

        if (!kStringIsEmpty(_l_id)) {
            cell.chooseType_L.text = @"修改地址";
        } else {
            cell.chooseType_L.text = @"请选择地址";

        }

        if (indexPath.section == 1 && indexPath.row == 0) {
            _name_TF = cell.textField;
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            _phone_TF = cell.textField;
        }
        if (indexPath.section == 4) {
            _price_TF = cell.textField;

        }


        return cell;
    }
    if (indexPath.section == 3) {
        QingYong_TCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QingYong_TCell_ID"];
        _text_TV = cell.textView;
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        QingYong_SCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QingYong_SCell_ID"];
        cell.delegate = self;
        
        return cell;
    }
    else {
        QingYongFourth_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"QingYongFourth_Cell_ID"];
        _cellNum == 2 ? (cell.contentView.hidden = YES) : (cell.contentView.hidden = NO);
        [cell configViewRow:indexPath.row];
        self.priceDK_TF = cell.money_TF;

        cell.text_L.text = _daiKuanTypeStr;
        return cell;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 10)];
    view1.backgroundColor =kAllRGB;
    return view1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return 100;
    }
    if (indexPath.section == 2 && (indexPath.row == 2 || indexPath.row == 3)) {
        
        if (_cellNum == 2) {
            return 0.001;
        } else {
            return 44;
        }
    }
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        kWeakSelf;
        LocationList_VC * vc = [[LocationList_VC alloc]init];
        vc.addressBlock = ^(NSString * selectValue) {
            _l_id = selectValue;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        vc.khID = _khID;
        vc.selectId = _l_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        HouseXQ_VC * vc = [[HouseXQ_VC alloc]init];
        vc.ID = self.fwID;
        vc.baoBeiType = self.baoBeiType;
        [self.navigationController pushViewController:vc animated:YES];

    }

    if (indexPath.section == 2 && indexPath.row == 2) {
        kWeakSelf;
        PushTypeViewController * vc = [[PushTypeViewController alloc]init];
        vc.chooseType = ^(NSString *type, int Num) {
            _daiKuanTypeStr = type;
            _dkType = kString(@"%d", Num);

            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:2];
            [weakSelf.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
        };
        [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomBottom dismissed:^{

        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: ------ reloadSectionsDelegate ------
-(void)reloadSections:(NSInteger)cellNum {
    
    NSLog(@"8888 *** %ld",cellNum);
    _cellNum = cellNum;
    NSIndexPath * p1 = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath * p2 = [NSIndexPath indexPathForRow:3 inSection:2];
    [self.tableview reloadRowsAtIndexPaths:@[p1,p2] withRowAnimation:UITableViewRowAnimationNone];

    
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
