//
//  PeopleDetailsViewController.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PeopleDetailsViewController.h"
#import "QingYong_VC.h"
#import "PeopleDetails_Cell.h"
#import "ChooseDredgeBankViewController.h"
#import "AddBankCardViewController.h"
#import "PeopleDetailsModel.h"
#import "BuyHouseIdeasViewController.h"
#import "WorkType_Cell.h"
#import "BaseView.h"
#import "BankPopupView.h"

@interface PeopleDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,qingYongProtocol>
@property (nonatomic, strong) PeopleDetailsModel * model;
@property (nonatomic ,strong) NSArray *selectArr;

@end

@implementation PeopleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = kAllRGB;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WorkType_Cell class]) bundle:nil] forCellReuseIdentifier: @"WorkType_Cell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleDetails_Cell class]) bundle:nil] forCellReuseIdentifier:@"PeopleDetails_Cell"];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRequest];
    }];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self loadRequest];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:kRGB_HEX(0x66a8fc)];
    self.navigationController.navigationBar.translucent = NO;
    [self loadRequest];

}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;

}
- (void)loadRequest
{
    kUserData;

    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"xq_client",@"opt",self.ids,@"id",userInfo.token,@"token", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"列表加载中..." withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"客户详情 = = %@",objc);
        if(code==200){
            self.model = [PeopleDetailsModel mj_objectWithKeyValues:data];
            self.name_L.text = self.model.name;
            self.phone_L.text = self.model.phone;
            if ([_model.phone containsString:@"****"]) {
                _phone_Btn.hidden = YES;
                _message_Btn.hidden = YES;
            }

            [self.tableview reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_header endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.lpArr.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WorkType_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkType_Cell_ID"];
    cell.model = _model.lpArr[indexPath.row];
    cell.qingYongButton.tag = indexPath.row;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LP *model =  _model.lpArr[indexPath.row];

    return ([model.status intValue] == 5 && [model.apply intValue]== 0) ? 140 : 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)message_Btn:(UIButton *)sender {

    [LBXAlertAction showAlertWithTitle:@"发送手机短信" msg:kString(@"号码:%@",  self.model.phone) buttonsStatement:@[@"发送",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
        if (buttonIdx == 0) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",self.model.phone]];
            [[UIApplication sharedApplication] openURL:url];

        }
    }];
}

- (IBAction)phone_Btn:(UIButton *)sender {

    [XXHelper makePhoneCallWithTelNumber:self.model.phone];
}
#pragma mark --------- 购房意向
- (IBAction)houseIdea_Btn:(UIButton *)sender {
    BuyHouseIdeasViewController * VC = [[BuyHouseIdeasViewController alloc] init];
    VC.valueBlock = ^(NSArray *valve) {
        [self requestGFYX:valve];
        _selectArr = valve;
    };
    VC.valueArray = @[_model.min_price_budget,_model.max_price_budget,_model.min_area,_model.max_area,_model.nucleus];
    if (!kArrayIsEmpty(_selectArr)) {
        VC.valueArray = _selectArr;
    }

    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 修改购房意向
-(void)requestGFYX:(NSArray *)arr {
    kUserData;
    NSDictionary * dic = @{
                           kOpt : @"intention",
                           kToken : userInfo.token,
                           @"id" : self.ids,
                           @"min_price_budget" : kStringIsEmpty(arr[0]) ? @"" : (arr[0]),
                           @"max_price_budget" : kStringIsEmpty(arr[1]) ? @"" : (arr[1]),
                           @"min_area" : kStringIsEmpty(arr[2]) ? @"" : (arr[2]),
                           @"max_area" : kStringIsEmpty(arr[3]) ? @"" : (arr[3]),
                           @"nucleus" : kStringIsEmpty(arr[4]) ? @"" : (arr[4]),
                           };
    
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

    } withFailuerBlock:^(id error) {

    }];
}

#pragma mark - 请佣按钮


-(void)func:(NSInteger)Num {
    NSString *fwID = [_model.lpArr[Num] record_id];

    if ([_model.yh_attestation intValue] == 0) {  // 未认证  要去填银行卡的东西
        kWeakSelf;
        BankPopupView * tempView = [BankPopupView viewFromXib];
        tempView.width = kWidth * 0.75;

        kViewRadius(tempView, 4);
        [[tempView.renZhengButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [KLCPopup dismissAllPopups];
            AddBankCardViewController * vc = [AddBankCardViewController viewControllerFromNib];
            [weakSelf.navigationController pushViewController:vc animated:true];


        }];
        KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];

        KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter));

        [popView showWithLayout:popLayout];

    } else {
        QingYong_VC * vc= [[QingYong_VC alloc]init];
        vc.yingjinType = @"1";
        [self.navigationController pushViewController:vc animated:true];
        vc.khID = _ids;
        vc.baoBeiType = self.baibeiType;

        vc.fwID = fwID;
    }

}


@end
