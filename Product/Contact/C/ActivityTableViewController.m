//
//  ActivityTableViewController.m
//  Product
//
//  Created by HJ on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityListModel.h"
#import "MainWebViewController.h"

@interface ActivityTableViewController ()

@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * rows;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rows = @"10";
    
    self.title = @"活动提醒";
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0 ));
    [self.tableview registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ActivityTableViewCell"];

    [self loadRequset];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ActivityTableViewCell"];
    self.tableview.separatorStyle = UITableViewCellAccessoryNone;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequset)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
- (void)loadMoreData
{
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue]+1];
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"activity",@"opt",userInfo.token,@"token",self.page,@"page",self.rows,@"row", nil];

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if(code==200){
            NSArray * array = [ActivityListModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count==0) {
                [XXProgressHUD showMessage:@"我已经到底啦！！！"];
            }else{
                [self.dataArray addObjectsFromArray:array];
                [self.tableview cyl_reloadData];
            }
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_footer endRefreshing];
}
- (void)loadRequset
{
    self.page = @"0";
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"activity",@"opt",userInfo.token,@"token",self.page,@"page",self.rows,@"row", nil];

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if(code==200){
            NSLog(@"活动 ---- %@",objc);
            self.dataArray = [ActivityListModel mj_objectArrayWithKeyValuesArray:data];
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_header endRefreshing];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 290;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityTableViewCell" forIndexPath:indexPath];
    __block ActivityListModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.lookAllBlock = ^{
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MainWebViewController * vc= [[MainWebViewController alloc]init];
    __block ActivityListModel * model = self.dataArray[indexPath.row];

    vc.urlString = kString(@"http://121.43.176.154:8080/h5/myinfo.html?ids=%@", model.id);
    vc.title = @"活动详情";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
