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

@interface PeopleDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PeopleDetailsModel * model;
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
- (void)loadRequest
{
    kUserData;
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"xq_client",@"opt",self.ids,@"id",userInfo.token,@"token", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:@"列表加载中..." withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"客户详情 = = %@",objc);
        if(code==200){
            self.model = [PeopleDetailsModel mj_objectWithKeyValues:data];
            self.name_L.text = self.model.name;
            self.phone_L.text = self.model.phone;
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
    kWeakSelf;

    
    WorkType_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkType_Cell_ID"];
    cell.model = _model.lpArr[indexPath.row];
    [[cell.qingYongButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf qingyong_BtnAction:[_model.lpArr[indexPath.row] record_id]];

    }];
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

    };
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 请佣按钮
- (void)qingyong_BtnAction:(NSString *)fwID {

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
    [self.navigationController pushViewController:vc animated:true];
        vc.khID = _ids;
        vc.baoBeiType = self.baibeiType;
        
        vc.fwID = fwID;
    }
}
#pragma mark --------- 结佣
- (void)jieyong_Btn:(id)sender {
    
    ChooseDredgeBankViewController * VC = [[ChooseDredgeBankViewController alloc] init];
    VC.clickNoOrYes = ^(NSString *code) {
        [self dismissPopupViewControllerWithanimationType:0];
        if ([code isEqualToString:@"no"]) {
            
        }else{
            AddBankCardViewController * VC = [[AddBankCardViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    };
    [self presentPopupViewController:VC animationType:0];
    
}
@end
