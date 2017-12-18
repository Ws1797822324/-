//
//  Information_TVC.m
//  Product
//
//  Created by  海跃尚 on 17/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Information_TVC.h"

#import "Information_Cell.h"
#import "InformationDetails_WebVC.h" // h5

@interface Information_TVC ()<CYLTableViewPlaceHolderDelegate> {
    NSInteger _page;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation Information_TVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:kRGB_HEX(0x66A8FC)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestNewData:YES];
    self.navigationItem.title = @"头条资讯";
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([Information_Cell class]) bundle:nil]
         forCellReuseIdentifier:@"Information_Cell_ID"];

        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNewData:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNewData:NO];
    }];
}

- (void)requestNewData:(BOOL)Num {

    if (Num) {
        _dataArr = [NSMutableArray array];
        _page = 0;
    }
    NSDictionary *dict = @{ @"opt" : @"message", @"page" : kString(@"%ld", (long) _page), @"row" : @"10" };

    [XXNetWorkManager requestWithMethod:POST
        withParams:dict
        withUrlString:kUserServlet
        withHud:@"资讯列表加载中..."
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            if (code == 200) {
                _page ++;

                if (Num) {
                    _dataArr = [NSMutableArray array];

                    _dataArr = [InformationModel mj_objectArrayWithKeyValuesArray:data];
                    [self.tableview cyl_reloadData];

                } else {
                    [_dataArr addObjectsFromArray:[InformationModel mj_objectArrayWithKeyValuesArray:data]];

                    [self.tableview cyl_reloadData];
                }
            } else {
                [XXProgressHUD showMessage:message];
            }
        }
        withFailuerBlock:^(id error){

        }];

    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Information_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Information_Cell_ID"];
    cell.modelData = _dataArr[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"Information_Cell_ID"
                                       configuration:^(Information_Cell *cell) {
                                           cell.modelData = _dataArr[indexPath.row];
                                       }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    InformationDetails_WebVC *hWebVc = [[InformationDetails_WebVC alloc] init];

    InformationModel *mmodel = _dataArr[indexPath.row];
    hWebVc.classNameNum = 9964;

    if ([mmodel.type intValue]== 1) {
        mmodel.type = @"3";
        hWebVc.classNameNum = 994;
    }
    hWebVc.model = mmodel;



    [(YMNavgatinController *) self.navigationController pushViewController:hWebVc
                                                                      type:YMNavgatinControllerTypeBlue
                                                                  animated:YES];
    kUserData;
    [XXNetWorkManager requestWithMethod:POST withParams:@{@"opt" : @"browse", @"token" : userInfo.token,@"id" :  mmodel.ID} withUrlString:@"CommissionServlet" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

    } withFailuerBlock:^(id error) {

    }];

}


@end

