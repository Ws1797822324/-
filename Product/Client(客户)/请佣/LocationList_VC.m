//
//  LocationList_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LocationList_VC.h"
#import "PeopleListModel.h"
#import "ChooseHouseTableViewCell.h"

@interface LocationList_VC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ChooseHouseTableViewCell * LastCell;

@property (nonatomic ,strong) NSString *selectStr;
@property (nonatomic ,assign) int page;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation LocationList_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 0;
    _dataArray = [NSMutableArray array];
    [self requestCJDZ:YES];

}
- (void)viewDidLoad {
    self.navigationItem.title = @"成交地址";
    [super viewDidLoad];
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.view, 70);
    self.view.backgroundColor = kAllRGB;

    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight-70-kNavHeight, kWidth, 70)];
    bottomView.backgroundColor = kAllRGB;
    [self.view addSubview:bottomView];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, kWidth-40, 42)];
    [btn setBackgroundColor:kRGB_HEX(0x0F83FA)];
    [btn setTitle:@"添加地址" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    kViewRadius(btn, 6);
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(addLocation) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ChooseHouseTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ChooseHouseTableViewCell_Id"];

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestCJDZ:YES];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestCJDZ:NO];
    }];
    // Do any additional setup after loading the view.

}
-(void) requestCJDZ:(BOOL)type {
    kUserData;
    if (type) {
        _page = 0;
        _dataArray = [NSMutableArray array];
    }
    NSDictionary * dic = @{
                           kOpt : @"cj_dz",
                           @"id" :  _khID,
                           kToken : userInfo.token,
                           @"row" : @"10",
                           @"page" : kString(@"%d", _page)
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"CommissionServlet" withHud:@"地址请求中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        XXLog(@"chenghjiao = %@",objc);
        if (code == 200) {
            _page ++;
            if (type) {
                _dataArray = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr =  [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
                if (arr.count== 0) {
                    [XXProgressHUD showMessage:@"没有更多数据了"];
                }
                
                [_dataArray arrayByAddingObjectsFromArray:arr];
            }
        }
        [self.tableview cyl_reloadData];

    } withFailuerBlock:^(id error) {

    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}
-(void) addLocation {



    [self.navigationController popViewControllerAnimated:true];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    self.addressBlock(_selectId);

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChooseHouseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseHouseTableViewCell_Id"];
    cell.titleLabel.text = [_dataArray[indexPath.row] name];

    if ([_selectId intValue] == [[_dataArray[indexPath.row] ID] intValue]) {
        cell.chooseBtn.selected = YES;
    } else {
        cell.chooseBtn.selected = NO;

    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChooseHouseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.chooseBtn.selected = !cell.chooseBtn.selected;

           if(cell!=self.LastCell){
            cell.chooseBtn.selected = YES;
            self.LastCell.chooseBtn.selected = NO;
            self.LastCell = cell;
        }

    _selectId =  [_dataArray[indexPath.row] ID];

    [tableView reloadData];


    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
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
