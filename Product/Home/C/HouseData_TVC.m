//
//  House_TVC.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseData_TVC.h"

#import "HouseData_Cell.h"

@interface HouseData_TVC ()

@property (nonatomic ,strong) NSArray *nameArr;
@property (nonatomic ,strong) PropertiesXinxi_Model *model;

@property (nonatomic ,strong) NSArray *valueArr;

@end

@implementation HouseData_TVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameArr = @[@[@"开盘时间",@"交房时间"],@[@"开发商",@"品牌",@"物业公司"],@[@"建筑面积",@"容积率",@"绿化率",@"总户数",@"车位数"],@[@"均价",@"物业费",@"建筑类型",@"装修状况",@"产权年限"]];
    [self requestData];

    [self configTableview];
}

-(void)requestData {
    kUserData;
    kWeakSelf;
    NSDictionary * params = @{
                              kOpt : @"loupanxiangqin",
                              kToken : userInfo.token,
                              @"id" : _houseID
                              };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:@"数据刷新..." withProgressBlock:^(float requestProgress) {
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        NSLog(@"jjjjjjjjjj - %@",data);

        kInspectSignInType;
        kShowMessage;
        if (code == 200) {
            _model = [PropertiesXinxi_Model mj_objectWithKeyValues:data];
            _valueArr = @[@[_model.open_time,_model.completion_date],@[_model.developers,_model.brand,_model.p_m_company],@[_model.covered_area,_model.plot_ratio,_model.greening_rate,_model.households,_model.carport],@[_model.price,_model.property_fee,_model.building_types,_model.building_state,_model.age_limit]];
            XXLog(@"ooooooo - %@",_valueArr);
            [weakSelf.tableview reloadData];

        }
    } withFailuerBlock:^(id error) {

    }];
}

-(void)configTableview {
    kWeakSelf
    [self.view addSubview: weakSelf.tableview];
    self.tableview.dataSource = self;
    self.navigationItem.title = @"楼盘信息";
    self.tableview.delegate = self;
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HouseData_Cell class]) bundle:nil] forCellReuseIdentifier:@"HouseData_Cell_ID"];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _nameArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_nameArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseData_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseData_Cell_ID"];

    cell.title_L.text = _nameArr[indexPath.section][indexPath.row];
    NSString * str1 = _valueArr[indexPath.section][indexPath.row];
    if (kStringIsEmpty(str1)) {
        str1 = @"待定";
    }
    if (indexPath.section == 3 && indexPath.row == 1 && kStringIsEmpty(str1)) { // 物业费
        str1 = @"待定";
    }
    if (indexPath.section == 3 && indexPath.row == 0 && !kStringIsEmpty(str1)) { // 均价
        str1 = kString(@"%@元左右/㎡", str1);
    }
    if (indexPath.section == 3 && indexPath.row == 0 && [str1 isEqualToString:@"0元左右/㎡"]) { // 均价
        str1 = @"售价待定";
    }
    cell.text_L.text = str1;

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
   UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 10)];
    view.backgroundColor = kAllRGB;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
