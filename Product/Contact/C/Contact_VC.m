//
//  Contact_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Contact_VC.h"
#import "MainNewsModel.h"
#import "Contact_Cell.h"
#import "ActivityTableViewController.h"
#import "NewsTableViewController.h"
#import "MessagesTVC.h"


@interface Contact_VC ()
@property (nonatomic, strong) NSMutableArray * textArray;
@property (nonatomic, strong) NSMutableArray * timeArray;
@end

@implementation Contact_VC

- (void)viewDidLoad {
    [super viewDidLoad];


    [self loadRequest];
    
    self.textArray = [NSMutableArray arrayWithObjects:@"您还未收到任何活动提醒哦~",@"您还未收到任何消息提醒哦~",@"您还未收到任何通知提醒哦~", nil];
    
    self.navigationItem.title = @"我的消息";
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([Contact_Cell class]) bundle:nil] forCellReuseIdentifier:@"Contact_Cell_ID"];
    kWeakSelf;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadRequest];
    }];
   
}

- (void)loadRequest
{
    kUserData;
    kToken;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"mymessage",@"opt",userInfo.ID,@"userid",userInfo.token,@"token", nil];

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        if (code==200) {
            MainNewsModel * actModel = [MainNewsModel mj_objectWithKeyValues:data[@"activity"]];
            MainNewsModel * newsModel = [MainNewsModel mj_objectWithKeyValues:data[@"news"]];
            MainNewsModel * notModel = [MainNewsModel mj_objectWithKeyValues:data[@"notice"]];
            
            if(kStringIsEmpty(actModel.title)){
                actModel.title = @"您还未收到任何活动提醒哦~";
            }
            if(kStringIsEmpty(newsModel.title)){
                newsModel.title = @"您还未收到任何消息提醒哦~";
            }
            if(kStringIsEmpty(notModel.title)){
                notModel.title = @"您还未收到任何通知提醒哦~";
            }
            if(kStringIsEmpty(actModel.time)){
                actModel.time = @"";
            }
            if(kStringIsEmpty(newsModel.time)){
                newsModel.time = @"";
            }
            if(kStringIsEmpty(notModel.time)){
                notModel.time = @"";
            }
            
            self.textArray = [NSMutableArray arrayWithObjects:actModel.title,newsModel.title,notModel.title, nil];
            self.timeArray = [NSMutableArray arrayWithObjects:actModel.time,newsModel.time,notModel.time, nil];
            [self.tableview cyl_reloadData];
        }else{
            [XXProgressHUD showError:message];
        }

        [self.tableview.mj_header endRefreshing];
    } withFailuerBlock:^(id error) {
        [self.tableview.mj_header endRefreshing];

    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * imgNameArr = @[@"huodongAA",@"xiaoxiAA",@"tongzhiAA"];
    NSArray * titArr = @[@"活动提醒",@"消息提醒",@"通知提醒"];
    Contact_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Contact_Cell_ID"];
    [cell.imageview setBackgroundImage:kImageNamed(imgNameArr[indexPath.row]) forState:UIControlStateNormal];
    cell.title_L.text = titArr[indexPath.row];
    cell.text_L.text = self.textArray[indexPath.row];

    cell.time_L.text =  [XXHelper timeStampIntoimeDifference:self.timeArray[indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){
        ActivityTableViewController * VC = [[ActivityTableViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==1){
        NewsTableViewController * VC = [[NewsTableViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        MessagesTVC * VC = [[MessagesTVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}


@end
