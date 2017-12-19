//
//  Exchange _VC.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyExchange_VC.h"

#import "MyExchange_Cell.h"

@interface MyExchange_VC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign) int page;

@property (nonatomic ,strong) NSMutableArray *dataArr;

@end

@implementation MyExchange_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 0;
    _dataArr =[NSMutableArray array];
    [self requestDataType:YES];
}
-(void)requestDataType:(BOOL)type {

    if (type) {
        _page = 0;
        _dataArr = nil;
    }
    kUserData;
    kWeakSelf;
    NSDictionary * dic = @{
                           kOpt : @"my_change",
                           kToken : userInfo.token,
                           @"page" : kString(@"%d", _page),
                           @"row" : @"20"
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:@"数据请求" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"dddddd - %@",objc);
        kInspectSignInType;
        kShowMessage;
        if (code == 200) {
            _page ++;
            if (type) {
                _dataArr = [DuiHuan mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr = [DuiHuan mj_objectArrayWithKeyValuesArray:data];
                if (arr.count == 0) {
                    [XXProgressHUD showMessage:@"没有更多的记录了"];
                }
                [_dataArr addObjectsFromArray:arr];
            }

            [weakSelf.tableview cyl_reloadData];
        }
    } withFailuerBlock:^(id error) {

    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    self.navigationItem.title = @"我的兑换";
    [super viewDidLoad];
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MyExchange_Cell class]) bundle:nil] forCellReuseIdentifier:@"MyExchange_Cell_ID"];

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataType:YES];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataType:NO];
    }];

    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyExchange_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyExchange_Cell_ID"];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
