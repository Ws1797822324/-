//
//  KeHuXiangQing_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KeHuXiangQing_VC.h"
#import "BuyHouseIdeasViewController.h"
#import "PeopleDetails_Cell.h"
#import "BankPopupView.h"
#import "QingYong_VC.h"
#import "AddBankCardViewController.h"
@interface KeHuXiangQing_VC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign) int page;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) PeopleDetailsModel * model;



@end

@implementation KeHuXiangQing_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self RequestData:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    self.navigationItem.title = @"客户详情";
    // Do any additional setup after loading the view from its nib.
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleDetails_Cell class]) bundle:nil] forCellReuseIdentifier:@"PeopleDetails_Cell"];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf RequestData:YES];
    }];


}

-(void) RequestData:(BOOL)type {
    kUserData;
    NSDictionary  *dic = @{
        kOpt : @"cg_report",
        kToken : userInfo.token,
        @"id" : _khID

    };
    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"详情..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200) {
            
            _model = [PeopleDetailsModel mj_objectWithKeyValues:data];
            self.name_L.text = self.model.name;
            self.phone_L.text = self.model.phone;

        }
        [_tableview reloadData];
        [weakSelf.tableview .mj_header endRefreshing];
        XXLog(@"kkkooo - %@",objc);
    } withFailuerBlock:^(id error) {

    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.lpArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleDetails_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleDetails_Cell"];
    cell.model = _model.lpArr[indexPath.row];
    kWeakSelf;
    [[cell.qingYong_Btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf qingyong_BtnAction:_model.lpArr[indexPath.row]];
        
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LP *model =  _model.lpArr[indexPath.row];

    return ([model.status intValue] >=7 && [model.apply intValue] == 0) ? 200 : 170;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSLog(@"主页进的购房意见 -- %@",valve);
    };
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 请佣按钮
- (void)qingyong_BtnAction:(LP *)model {


    if ([model.yh_attestation intValue] == 0) {  // 未认证  要去填银行卡的东西
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

        [self.navigationController pushViewController:vc animated:true];
        vc.khID = _khID;
        vc.baoBeiType = @"2";

        vc.fwID = model.record_id;

    }
}
@end
