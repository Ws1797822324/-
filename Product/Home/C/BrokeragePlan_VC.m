//
//  BrokeragePlan_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BrokeragePlan_VC.h"

#import "BrokeragePlan_Cell.h"
#import "KHGZ_VC.h"



@interface BrokeragePlan_VC ()

@property (nonatomic ,strong) NSArray *dataArr;


@end

@implementation BrokeragePlan_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"佣金方案";
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
//
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = false;
//    }
    [self.view addSubview: self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([BrokeragePlan_Cell class]) bundle:nil] forCellReuseIdentifier:@"BrokeragePlan_Cell_ID"];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"客户规则") highImage:kImageNamed(@"客户规则") target:self action:@selector(kehuguize) withTitle:nil];
    [self requestYongJinData];

}

#pragma mark -  佣金方案请求
-(void) requestYongJinData {
    kUserData;
    kWeakSelf;
    NSDictionary * params = @{
                              kOpt : @"yongjintype",
                              kToken : userInfo.token,
                              @"id" :  _ID
                              };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:@"刷新数据" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"fangn %@",objc);

        kInspectSignInType;
        if (code == 200) {
            _dataArr = nil;
            _dataArr = [YongJinFA mj_objectArrayWithKeyValuesArray:data];
        }
        [weakSelf.tableview cyl_reloadData];

    } withFailuerBlock:^(id error) {

    }];
}
-(void) kehuguize {
    NSLog(@"客户规则");
    KHGZ_VC * vc = [KHGZ_VC viewControllerFromNib];
    vc.l_id = self.ID;
    vc.view.width = kWidth * 0.8;
    vc.view.height = kWidth * 0.9;
    vc.clickAction = ^{
        [self dismissPopupViewControllerWithanimationType:0];
    };
    [self presentPopupViewController:vc animationType:0 ];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrokeragePlan_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"BrokeragePlan_Cell_ID"];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"BrokeragePlan_Cell_ID" configuration:^(BrokeragePlan_Cell * cell) {
        cell.model = _dataArr[indexPath.row];
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
