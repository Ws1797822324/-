//
//  BpartnerViewController.m
//  Product
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BpartnerViewController.h"

#import "PartnerType_VC.h"

@interface BpartnerViewController ()

@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,strong) NSMutableArray *dataArr;


@end

@implementation BpartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configTableview];
    [self requestDataPage:YES];

    _dataArr = [NSMutableArray array];
}
-(void)configTableview {
    kWeakSelf
    [self.view addSubview: weakSelf.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, kNavHeight, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([Partner_Cell class]) bundle:nil] forCellReuseIdentifier:@"Partner_Cell_ID"];

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataPage:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestDataPage:NO];
    }];
}

-(void)requestDataPage:(BOOL)type {
    kUserData;
    if (type) {
        _page = 0;
    }

    
    NSDictionary * params = @{
                              kOpt : @"friendt",
                              kToken : userInfo.token,
                              @"page" : kString(@"%ld", (long)_page),
                              @"row" : @"20",
                              };
#pragma mark - 我的左伙伴请求
    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kClientServlet withHud:@"请求伙伴列表" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        kShowMessage;
        if (code == 200) {
            _dataArr = [NSMutableArray array];

            _page ++;
            if (type) {
                _dataArr = [MyPartner_Model mj_objectArrayWithKeyValuesArray:data];
            } else {
                [_dataArr addObjectsFromArray:[MyPartner_Model mj_objectArrayWithKeyValuesArray:data]];
            }
            
            [weakSelf.tableview cyl_reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
            [weakSelf.tableview.mj_footer endRefreshing];

        }
    } withFailuerBlock:^(id error) {
        
    }];
    
    [weakSelf.tableview.mj_header endRefreshing];
    [weakSelf.tableview.mj_footer endRefreshing];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Partner_Cell * cell =    [tableView dequeueReusableCellWithIdentifier:@"Partner_Cell_ID"];
    cell.model.type = 0;
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PartnerType_VC * vc = [[PartnerType_VC alloc]init];
    vc.navigationItem.title = [_dataArr[indexPath.row] name];
    vc.khID = [_dataArr[indexPath.row]ID];
    [self.navigationController pushViewController:vc animated:true];
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
