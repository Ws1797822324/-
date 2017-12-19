//
//  NewsTableViewController.m
//  Product
//
//  Created by HJ on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsXiaoXiCell.h"

#import "MyPartner_VC.h"
#import "PeopleDetailsViewController.h"
#import "IntegralMall_VC.h"
#import "MyExchange_VC.h"
#import "NewStayparticularsViewController.h"
@interface NewsTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,assign) BOOL page;
@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation NewsTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 0;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    kWeakSelf;
    [self requestDataaRefresh:YES];

    [self.view addSubview:weakSelf.tableview];
    self.tableview.backgroundColor =kAllRGB;
    self.view.backgroundColor = kAllRGB;
    [self.tableview registerNib:[UINib nibWithNibName:@"NewsXiaoXiCell" bundle:nil] forCellReuseIdentifier:@"NewsXiaoXiCell"];

    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataaRefresh:YES];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataaRefresh:NO];
    }];

}
-(void)requestDataaRefresh:(BOOL)type {
    kUserData;
    if (type) {
        _page = 0;

    }
    NSDictionary * dic = @{
                           kOpt : @"news",
                           kToken : userInfo.token,
                           @"row" : @"20",
                           @"page" : kString(@"%d", _page)
                           };
    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:@"消息列表" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        if (code == 200) {
            _page ++;
            if (type) {
                _dataArray = [NSMutableArray array];
                _dataArray = [NewsModel mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr = [NewsModel mj_objectArrayWithKeyValuesArray:data];
                if (arr.count == 0) {
                    [XXProgressHUD showMessage:@"没有更多的消息了"];
                }
                [_dataArray addObjectsFromArray:arr];
            }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
        }
        [weakSelf.tableview cyl_reloadData];


    } withFailuerBlock:^(id error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NewsXiaoXiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsXiaoXiCell"];
    cell.model = _dataArray[indexPath.section];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vbv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 10)];
    vbv.backgroundColor = kAllRGB;

    return vbv;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel * model = _dataArray[indexPath.section];
    NSLog(@"iiiidddd %@",model);
    int kkk = [model.status intValue];
//
//    1    已成交        ->    客户详情
//    2    已结佣        ->    佣金详情
//    3    兑换成功    ->    我的兑换记录
//    4    已报备        ->    客户详情
//    5    积分提醒     ->    礼品商城
//    6    邀请完成    ->    我的伙伴

    if (kkk == 6) {
        MyPartner_VC * vc = [[MyPartner_VC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (kkk == 5) {
        IntegralMall_VC * vc = [[IntegralMall_VC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (kkk == 4) {
        PeopleDetailsViewController * vc = [[PeopleDetailsViewController alloc]init];
        vc.ids = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (kkk == 3) {
        MyExchange_VC * vc = [[MyExchange_VC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (kkk == 2) {
        NewStayparticularsViewController * vc = [[NewStayparticularsViewController alloc]init];
        vc.ids = model.ID;
        vc.type = @"1";
        vc.wsType = @"0";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (kkk == 1) {
        PeopleDetailsViewController * vc = [[PeopleDetailsViewController alloc]init];
        vc.ids = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }

}


@end
