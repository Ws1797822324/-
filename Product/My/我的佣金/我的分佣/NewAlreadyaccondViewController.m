
//
//  NewAlreadyaccondViewController.m
//  Product
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewAlreadyaccondViewController.h"
#import "PosTool.h"
#import "NewStayparticularsViewController.h"
#import "CommissionListModel.h"

@interface NewAlreadyaccondViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *type;
}

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * rows;


@end

@implementation NewAlreadyaccondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    type=@"1";
    self.rows = @"10";
    [self loadRequest];
}
- (void)loadRequest
{
    self.page = @"0";
    kUserData;

    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"selmyCommission",@"opt",@"2",@"type",userInfo.token,@"token",@"2",@"tag",self.page,@"page",self.rows,@"row", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"Commission" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            self.dataArray = [CommissionListModel mj_objectArrayWithKeyValuesArray:data];
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
        
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_header endRefreshing];
}
- (void)loadMoreData
{
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue]+1];
    kUserData;

    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"selmyCommission",@"opt",@"2",@"type",userInfo.token,@"token",@"2",@"tag",self.page,@"page",self.rows,@"row", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"Commission" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            NSArray * array = [CommissionListModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count==0) {
                [XXProgressHUD showError:@"没有更多数据啦"];
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
-(void)setUI{

    kWeakSelf;
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:weakSelf.tableview];

    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequest)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableview registerNib:[My_YongJin_Cell nib] forCellReuseIdentifier:@"My_YongJin_Cell"];
}
#pragma mark UITableViewDataSource delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    My_YongJin_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"My_YongJin_Cell"];
    cell.model = _dataArray[indexPath.row];
    cell.time_L.hidden = NO;

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    CommissionListModel * model = self.dataArray[indexPath.row];
    NewStayparticularsViewController *vc=[[NewStayparticularsViewController alloc]init];
    vc.type=type;
    vc.ids = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
