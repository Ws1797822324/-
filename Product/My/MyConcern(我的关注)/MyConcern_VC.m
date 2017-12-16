//
//  MyConcern_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyConcern_VC.h"
#import "AttentionListModel.h"
#import "MyConcern_Cell.h"

#import "PropertiesDetails_VC.h"
#import "HouseDetails_VC.h"

#import "PropertiesDetails_ImportantCell.h"
@interface MyConcern_VC () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * rows;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MyConcern_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.rows = @"10";
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MyConcern_Cell class]) bundle:nil] forCellReuseIdentifier:@"MyConcern_Cell_ID"];
    [self.tableview registerNib:[PropertiesDetails_ImportantCell nib] forCellReuseIdentifier:@"PropertiesDetails_ImportantCell"];


    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequset)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self loadRequset];
}
- (void)loadMoreData
{
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue]+1];
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"guanzhu",@"opt",userInfo.token,@"token",self.page,@"page",self.rows,@"row", nil];

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if(code==200){

            
            NSArray * array = [AttentionListModel mj_objectArrayWithKeyValuesArray:data];
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
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"guanzhu",@"opt",userInfo.token,@"token",self.page,@"page",self.rows,@"row", nil];

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {

            self.dataArray = [AttentionListModel mj_objectArrayWithKeyValuesArray:data];
            
            [self.tableview cyl_reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [self.tableview.mj_header endRefreshing];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AttentionListModel * model = self.dataArray[indexPath.row];

    MyConcern_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyConcern_Cell_ID"];

    cell.model = model;

    PropertiesDetails_ImportantCell * cellS = [tableView dequeueReusableCellWithIdentifier:@"PropertiesDetails_ImportantCell"];


    cellS.gzHxModel = model;

    if ([model.type intValue] == 1) {

        return cell;
    } else {
        return cellS;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AttentionListModel * model = self.dataArray[indexPath.row];

    if ([model.type intValue] == 1) {

        return [tableView fd_heightForCellWithIdentifier:@"MyConcern_Cell_ID" configuration:^(id cell) {
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:@"PropertiesDetails_ImportantCell" configuration:^(id cell) {
        }];
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@" 取消关注 " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"取消关注");
        kUserData;
        AttentionListModel * model = self.dataArray[indexPath.row];
        NSString * url = [NSString stringWithFormat:@"%@OperateServlet",kBaseURL];
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"gz_delete",@"opt",model.ID,@"l_id",userInfo.token,@"token",model.type,@"type", nil];
        [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            if (code==200) {
                [XXProgressHUD showSuccess:@"删除成功"];

                [self loadRequset];
            }else{
                kShowMessage;
            }
            
        } withFailuerBlock:^(id error) {
            
        }];
        

        
    }];
    return @[action1];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    AttentionListModel * model = self.dataArray[indexPath.row];

    XXLog(@"  wwwwww %@",[_dataArray [indexPath.row] ID]);

    PropertiesDetails_VC * LP_VC =[[ PropertiesDetails_VC alloc]init];
    LP_VC.houseID = [_dataArray [indexPath.row] ID];
    HouseDetails_VC * H_VC = [[HouseDetails_VC alloc]init];
    H_VC.wuId = [_dataArray [indexPath.row] ID];
    if ([model.type intValue] == 1) {

        [(YMNavgatinController *)self.navigationController pushViewController:LP_VC type:YMNavgatinControllerTypeClear  animated:YES];
    } else {
        [(YMNavgatinController *)self.navigationController pushViewController:H_VC type:YMNavgatinControllerTypeClear animated:YES];
    }

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
