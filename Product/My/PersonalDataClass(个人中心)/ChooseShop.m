//
//  ChooseShop.m
//  Product
//
//  Created by Sen wang on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChooseShop.h"

@interface ChooseShop ()
@property (nonatomic ,assign)  int page;
@property (nonatomic ,strong) NSMutableArray *dataArray;


@end

@implementation ChooseShop

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    self.navigationItem.title = @"切换店铺";
    [self requestData:YES];
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData: YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData:NO];
    }];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _dataArray.count;
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kUserData;
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.textLabel.font = kBoldFont(15);
    cell.textLabel.textColor = kRGB_HEX(0x9696996);
    if (indexPath.section == 0) {
        cell.textLabel.text = kStringIsEmpty(_dianPuNameNow) ? @"您还没有选择任何一家店呢" : _dianPuNameNow;

    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [_dataArray[indexPath.row] name];
    }

    return cell;
}

-(void) requestData:(BOOL)type {

    if (type) {
        _page = 0;
        _dataArray = [NSMutableArray array];
    }
    kUserData;
    kWeakSelf;

    NSDictionary * dict = @{
                            kOpt : @"mendian",
                            kToken : userInfo.token,
                            @"row" : @"20",
                            @"page" : kString(@"%d", _page)
                            };
    [XXNetWorkManager requestWithMethod:POST withParams:dict withUrlString:@"CommissionServlet" withHud:@"店铺加载..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        _page ++;
        if (type) {
            _dataArray = [DianPu mj_objectArrayWithKeyValuesArray:data];
        } else {
            NSArray * dataArr = [DianPu mj_objectArrayWithKeyValuesArray:data];

            if (dataArr.count == 0) {
                [XXProgressHUD showMessage:@"没有更多店铺了"];
            }
            [_dataArray addObjectsFromArray:dataArr];
        }
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview.mj_footer endRefreshing];
        [weakSelf.tableview cyl_reloadData];
    } withFailuerBlock:^(id error) {
        
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    v1.backgroundColor =kAllRGB;

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];

    if (section == 0) {
        label.text = @"已选店铺";
    } else
        {
            label.text = @"全部店铺";
        }

    label.textColor = kRGB_HEX(0x969696);
    label.font = kFont(14);
    [v1 addSubview:label];
    return v1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf;
    NSString *str = @"";

    if (indexPath.section == 0) {

        return;

    }
    if (indexPath.section == 1) {
    str = [_dataArray[indexPath.row] name];

    }
    [LBXAlertAction showAlertWithTitle:@"切换店铺" msg: str buttonsStatement:@[@"切换",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
        NSLog(@"%ld",(long)buttonIdx);

        if (buttonIdx == 0) {
// 切换
            [weakSelf requeseQiehuan:[_dataArray[indexPath.row] ID]];
        } else {

        }
    }];

}
#pragma mark - 切换店铺请求
-(void)requeseQiehuan:(NSString *)ID {
    kUserData;
    kWeakSelf;
    NSDictionary * dic = @{
                           kOpt : @"huandian",
                           kToken : userInfo.token,
                           @"id" : ID
                           };
    [XXNetWorkManager requestWithMethod: POST withParams:dic withUrlString:@"CommissionServlet" withHud:@"店铺切换中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        if (code == 200) {
            [XXProgressHUD showMessage:@"店铺切换成功"];
        [weakSelf.navigationController popViewControllerAnimated:true];

        } else {
            [XXProgressHUD showMessage:message];
        }

    } withFailuerBlock:^(id error) {

    }];

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
