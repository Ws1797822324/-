//
//  HousesViewController.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HousesViewController.h"
#import "ChooseHouseTableViewCell.h"
#import "BBLPListModel.h"

@interface HousesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) ChooseHouseTableViewCell * LastCell;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * rows;


@end

@implementation HousesViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.rows = @"10";
    self.title = @"报备楼盘";
    self.view.backgroundColor = kRGB_HEX(0xfafafa);
    _selectedArr = [NSMutableArray arrayWithArray:_array];
    if (_selectedArr.count>1) {
        _phoneTypeStr = @"2";
    }
    [self loadRequest];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseHouseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChooseHouseTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight-70-kNavHeight, kWidth, 70)];
    bottomView.backgroundColor = kAllRGB;
    [self.view addSubview:bottomView];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, kWidth-40, 42)];
    [btn setBackgroundColor:kRGB_HEX(0x0F83FA)];
    [btn setTitle:@"添加楼盘" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    kViewRadius(btn, 6);
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(addHouses) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)loadRequest
{
    self.page = @"0";
    kUserData;

    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"lp_report",@"opt",userInfo.token,@"token",self.page,@"page",self.rows,@"row", nil];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"ClientServlet" withHud:@"请求楼盘" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            
            self.dataArray = [BBLPListModel mj_objectArrayWithKeyValuesArray:data];

            [self.tableView reloadData];
        }else{
            kShowMessage;
        }
    } withFailuerBlock:^(id error) {
        
    }];
    [_tableView.mj_header endRefreshing];
    
}
#pragma mark ------------ 添加楼盘
- (void)addHouses
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (_selectedArr.count>1) {
        _phoneTypeStr = @"2";
    } else {
        for (BBLPListModel * model in _dataArray) {

            if ([model.ID intValue] == [_selectedArr[0] intValue]) {
                _phoneTypeStr = model.type;
            }
        }
    }
    self.selectedBlock(_selectedArr);
    self.phoneTypeBlock([_phoneTypeStr intValue]);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ChooseHouseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseHouseTableViewCell"];
    BBLPListModel * model = self.dataArray[indexPath.row];
       [ _selectedArr containsObject:model.ID] ? (cell.chooseBtn.selected = YES) : (cell.chooseBtn.selected = NO);
    cell.titleLabel.text = model.name;


    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ChooseHouseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell.chooseBtn.selected) {

        BBLPListModel * modelo = _dataArray[indexPath.row];
           [_selectedArr addObject: modelo.ID];
    } else {
// MARK: ------ 删除数组中的某个元素 ------
        NSIndexSet *indexSet = [_selectedArr indexesOfObjectsPassingTest:^BOOL(NSString *  _Nonnull var, NSUInteger idx, BOOL * _Nonnull stop) {
            return [var isEqual:[_dataArray[indexPath.row] ID]];
        }];
        [_selectedArr removeObjectsAtIndexes:indexSet];
    }
    cell.chooseBtn.selected = !cell.chooseBtn.selected;

    NSLog(@"惺惺惜惺惺  - %@",_selectedArr);
    /// 单选就解开

}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-78-kNavHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadRequest];
        }];
    }
    return _tableView;
}


@end
