//
//  MessagesTableViewController.m
//  Product
//
//  Created by HJ on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MessagesTVC.h"
#import "NewsModel.h"
#import "MessageCell.h"
#import "MessagesWebView.h"
@interface MessagesTVC ()
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MessagesTVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _page = 0;
    _dataArray = [NSMutableArray array];
    [self requestDataaRefresh:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知提醒";
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataaRefresh:YES];
    }];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MessageCell class])
                                               bundle:nil]
         forCellReuseIdentifier:@"MessageCell"];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataaRefresh:NO];
    }];
}

- (void)requestDataaRefresh:(BOOL)type {
    kUserData;
    if (type) {
        _page = 0;
    }
    NSDictionary *dic = @{
        kOpt : @"notice",
        kToken : userInfo.token,
        @"row" : @"10",
        @"page" : kString(@"%d", _page)
    };
    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"News"
        withHud:@"通知消息列表"
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            kInspectSignInType;
            if (code == 200) {
                _page++;
                _dataArray = [NSMutableArray array];

                if (type) {
                    _dataArray = [NewsModel mj_objectArrayWithKeyValuesArray:data];
                } else {
                    NSArray *arr = [NewsModel mj_objectArrayWithKeyValuesArray:data];
                    if (arr.count == 0) {
                        [XXProgressHUD showMessage:@"没有更多的消息了"];
                    }
                    [_dataArray addObjectsFromArray:arr];
                }
                [weakSelf.tableview cyl_reloadData];

            }
            NSLog(@"通知 %@", data);

        }
        withFailuerBlock:^(id error){

        }];

    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

        return _dataArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    cell.model = _dataArray[indexPath.section];
    // Configure the cell...

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vbv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 10)];
    vbv.backgroundColor = kAllRGB;

    return vbv;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessagesWebView * web = [[MessagesWebView alloc]init];
    web.h5Str = [_dataArray[indexPath.section] morning_paper];
    [self.navigationController pushViewController:web animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
