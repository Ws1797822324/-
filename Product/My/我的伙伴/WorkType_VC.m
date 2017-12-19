//
//  WorkType_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WorkType_VC.h"

#import "WorkType_Cell.h"

@interface WorkType_VC ()

@property (nonatomic ,strong)NSMutableArray  *dataArray;
@property (nonatomic ,assign) int page;



@end

@implementation WorkType_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableview];
    _page = 0;
    _dataArray = [NSMutableArray array];
    [self requestDataRefreshType:YES];

    // Do any additional setup after loading the view from its nib.
}

-(void)configTableview {
    kWeakSelf
    [self.view addSubview: weakSelf.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WorkType_Cell class]) bundle:nil] forCellReuseIdentifier:@"WorkType_Cell_ID"];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataRefreshType:YES];

    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestDataRefreshType:NO];

    }];
}
#pragma mark - 请求  借口呀
-(void) requestDataRefreshType:(BOOL)type{
    kUserData;
    kWeakSelf;
    if (type) {
        _page = 0;
    }
    NSDictionary * dic = @{
                           kOpt : @"ck_friend",
                           kToken : userInfo.token,
                           @"flow" : _type_vc,
                           @"page" : kString(@"%d", _page),
                           @"row" : @"20",
                           @"id" : _kh_ID
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"状态加载中..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200) {
            if (type) {
                _page ++;
                _dataArray = [NSMutableArray array];

                _dataArray = [WorkTypeModel mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr = [WorkTypeModel mj_objectArrayWithKeyValuesArray:data];
                if (arr.count == 0) {
                    [XXProgressHUD showError:@"没有更多数据啦"];
                }
                [_dataArray addObjectsFromArray:arr];
            }
        }
        [weakSelf.tableview cyl_reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview.mj_footer endRefreshing];

        NSLog(@"00000 --%@",objc);
    } withFailuerBlock:^(id error) {

    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkType_Cell * cell =    [tableView dequeueReusableCellWithIdentifier:@"WorkType_Cell_ID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.qingYongButton.hidden = YES;
    cell.type_L.hidden = YES;
    cell.dixian_ImgV.hidden = YES;
    cell.W_Model = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
