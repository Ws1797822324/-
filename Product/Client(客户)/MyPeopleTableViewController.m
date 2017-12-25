//
//  MyPeopleTableViewController.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyPeopleTableViewController.h"
#import "MyPeopleTableViewCell.h"
#import "PeopleDetailsViewController.h"
#import "PeopleListModel.h"
#import "AllPeopleTableViewCell.h"
#import "SearchViewController.h"


@interface MyPeopleTableViewController ()

@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * rows;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MyPeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    self.rows = @"10";
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.tableview registerNib:[UINib nibWithNibName:@"MyPeopleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPeopleTableViewCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"AllPeopleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AllPeopleTableViewCell"];
    
    if ([self.title isEqualToString:@"我的客户"]) {
        [self loadAllRequest];
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAllRequest)];
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreAllData)];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"search")highImage:kImageNamed(@"search")target:self action:@selector(rightAction) withTitle:@""];
    }else{
        [self loadSingleData];
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadSingleData)];
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSingleData)];
    }


}



- (void)rightAction
{
    SearchViewController * VC = [[SearchViewController alloc] init];
    VC.type = @"人";
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)loadMoreSingleData
{
    
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue]+1];
    kUserData;
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"client",@"opt",self.page,@"page",self.rows,@"row",userInfo.token,@"token",self.flag,@"flag", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            
            NSArray * array = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count==0) {
                [XXProgressHUD showError:@"已经没有数据啦"];
                return ;
            }
            [self.dataArray addObjectsFromArray:array];
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_footer endRefreshing];
}
- (void)loadSingleData
{
    self.page = @"0";
    kUserData;
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"client",@"opt",self.page,@"page",self.rows,@"row",userInfo.token,@"token",self.flag,@"flag", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            
            NSLog(@"%@",objc);

            self.dataArray = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_header endRefreshing];
}


- (void)loadMoreAllData
{
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue]+1];
    kUserData;
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_client",@"opt",self.page,@"page",self.rows,@"row",userInfo.token,@"token", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            NSArray * array = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count==0) {
                [XXProgressHUD showError:@"已经没有数据啦"];
                return ;
            }
            [self.dataArray addObjectsFromArray:array];
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_footer endRefreshing];
}
- (void)loadAllRequest
{
    self.page = @"0";
    kUserData;
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"my_client",@"opt",self.page,@"page",self.rows,@"row",userInfo.token,@"token", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:@"加载客户列表..." withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            NSLog(@"%@",objc);
            self.dataArray = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"我的客户"]) {
        return 65;
    }else{
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPeopleTableViewCell"];
    AllPeopleTableViewCell * allCell = [tableView dequeueReusableCellWithIdentifier:@"AllPeopleTableViewCell"];
    
    PeopleListModel * model = self.dataArray[indexPath.row];
    if ([self.title isEqualToString:@"我的客户"]) {
        NSMutableString * str = [[NSMutableString alloc]initWithString:model.phone];

        [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];


        allCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,str];
        allCell.timeLabel.text = [model.time stringByReplacingOccurrencesOfString:@".0" withString:@""];
        return allCell;
    }else{
        NSMutableString * str = [[NSMutableString alloc]initWithString:model.phone];
                if ([model.type intValue] == 1) {
        [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }

        cell.nameLabel.text = [NSString stringWithFormat:@"%@   %@",model.name,str];
        cell.addressLabel.text = model.l_name;
        NSArray * arr = [model.time componentsSeparatedByString:@"."];
        cell.telLabel.text = [arr firstObject];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeopleListModel * model = self.dataArray[indexPath.row];
    PeopleDetailsViewController * VC = [[PeopleDetailsViewController alloc] init];
    VC.ids = model.ID;
    VC.baibeiType = @"1";
    [self.navigationController pushViewController:VC animated:YES];
}


@end
