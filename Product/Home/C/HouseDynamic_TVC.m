//
//  HouseDynamic_TVC.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseDynamic_TVC.h"

#import "HouseDynamic_Cell.h"

@interface HouseDynamic_TVC ()

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,assign) int page;



@end

@implementation HouseDynamic_TVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 0;
    _dataArray = [NSMutableArray array];
    [self requestDataRefreshType:YES];
}


-(void)requestDataRefreshType:(BOOL)type {
    if (type) {
        _page = 0;
    }
    kUserData;
    kWeakSelf;
    NSDictionary * dic = @{
                           kOpt : @"loupandongtai",
                           kToken : userInfo.token,
                           @"id" : _ID,
                           @"page" : kString(@"%d", _page),
                           @"row" : @"10"
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString: @"Houses" withHud:@"信息刷新" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        NSLog(@"pppp %@",objc);
        if (code == 200) {
            _page ++;
            _dataArray = [NSMutableArray array];
            if (type) {
                _dataArray =[YongJinFA mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr = [YongJinFA mj_objectArrayWithKeyValuesArray:data];
                if (arr.count == 0) {
                    [XXProgressHUD showError:@"没有更多数据啦"];
                }
            [_dataArray arrayByAddingObjectsFromArray:arr];
            }


        }
        [weakSelf.tableview cyl_reloadData];
    } withFailuerBlock:^(id error) {

    }];
    [self.tableview.mj_footer endRefreshing];
    [self.tableview.mj_header endRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    self.navigationItem.title = @"楼盘动态";
    [self.view addSubview: self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HouseDynamic_Cell class]) bundle:nil] forCellReuseIdentifier:@"HouseDynamic_Cell_ID"];

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataRefreshType:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataRefreshType:NO];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseDynamic_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseDynamic_Cell_ID"];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"HouseDynamic_Cell_ID" configuration:^(HouseDynamic_Cell * cell) {
        cell.model = _dataArray[indexPath.row];

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
