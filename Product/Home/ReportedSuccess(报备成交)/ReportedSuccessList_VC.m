//
//  ReportedSuccessList_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReportedSuccessList_VC.h"
#import "ReportedSuccessList_Cell.h"

#import "KeHuXiangQing_VC.h"

@interface ReportedSuccessList_VC ()

@property (nonatomic ,assign) int page;
@property (nonatomic ,strong) NSMutableArray *dataArray;


@end

@implementation ReportedSuccessList_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ReportedSuccessList_Cell class]) bundle:nil] forCellReuseIdentifier:@"ReportedSuccessList_Cell_ID"];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData:NO];
    }];
    self.navigationItem.title = @"报备成交";
    // Do any additional setup after loading the view.
}


-(void) requestData:(BOOL)type {
    if (type) {
        _page = 0;
        _dataArray = [NSMutableArray array];

    }
    kUserData;
    NSDictionary * dic = @{
                           @"row" : @"20",
                           @"page" : kString(@"%d", _page),
                           kOpt :@"cj_lb",
                           kToken : userInfo.token
                           };
    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"加载中..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"jjj -- %@",objc);
        if (code == 200) {
            _page ++;
            if (type) {
                _dataArray = [BaoBeiChengJiao mj_objectArrayWithKeyValuesArray:data];

            } else {
                if ([BaoBeiChengJiao mj_objectArrayWithKeyValuesArray:data].count == 0) {
                    [XXProgressHUD showMessage:@"已经到底啦"];
                }
                [_dataArray addObjectsFromArray:[BaoBeiChengJiao mj_objectArrayWithKeyValuesArray:data]];
            }
            [weakSelf.tableview cyl_reloadData];
        }


    } withFailuerBlock:^(id error) {

    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ReportedSuccessList_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"ReportedSuccessList_Cell_ID"];
    cell.model = _dataArray[indexPath.row];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KeHuXiangQing_VC * vc = [KeHuXiangQing_VC viewControllerFromNib];

    vc.khID = [_dataArray[indexPath.row] ID];

    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [kNoteCenter postNotificationName:@"deleteTextFieldValue" object:nil];

}
@end
