//
//  Integral_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyIntegral_VC.h"

#import "MyIntegral_Cell.h"

#import "IntegralRuleS_VC.h"


@interface MyIntegral_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *dataArray;


@end

@implementation MyIntegral_VC

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray array];
    [self requestData];
    }

-(void)requestData {
    kUserData;
    kWeakSelf;
    NSDictionary * dic = @{
                           kOpt : @"my_points",
                           kToken : userInfo.token,
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"PersonalServlet" withHud:@"积分记录" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"我的几根%@",objc);
        if (code == 200) {

            weakSelf.integraL.text = objc[@"message"];
            _dataArray = [JiFenXQ mj_objectArrayWithKeyValuesArray:data];
        }
        [weakSelf.tableview cyl_reloadData];
        [weakSelf.tableview.mj_header endRefreshing];

    } withFailuerBlock:^(id error) {

    }];

};
- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    self.navigationItem.title = @"我的积分";
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [XXHelper deleteExtraCellLine:_tableview];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MyIntegral_Cell class]) bundle:nil] forCellReuseIdentifier:@"MyIntegral_Cell_ID"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"jfgz") highImage:kImageNamed(@"jfgz") target:self action:@selector(rightAction) withTitle:nil];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
}

-(void) rightAction {
    NSLog(@"积分规则");
    IntegralRuleS_VC * vc = [IntegralRuleS_VC viewControllerFromNib];
    vc.view.width = kWidth * 0.85;
    vc.view.height = kWidth ;

    vc.click = ^{
        [self dismissPopupViewControllerWithanimationType:0];
    };
    [self presentPopupViewController:vc animationType: MJPopupViewAnimationFade];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyIntegral_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyIntegral_Cell_ID"];
    cell.model = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CYLTableViewPlaceHolderDelegate

-(UIView *)makePlaceHolderView {
    kWeakSelf
    PlaceHolderView * placeHolderV = [PlaceHolderView viewFromXib];
    [[placeHolderV.reloadDataButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.tableview.mj_header beginRefreshing];
    }];
    return placeHolderV;
}


@end
