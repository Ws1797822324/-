//
//  ChooseCity_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChooseCity_VC.h"

@interface ChooseCity_VC ()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic ,strong) NSString *cityName;


@end

@implementation ChooseCity_VC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kWeakSelf;
    [[PBLocation location] startLocationAddress:^(BOOL isSuccess, PBLocationModel *locationModel) {
        _cityName = locationModel.locality;
        [weakSelf.tableview cyl_reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"城市选择";
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self requestData];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    // Do any additional setup after loading the view.
}

#pragma mark - 请求

-(void)requestData {
kUserData;
    kWeakSelf;
NSDictionary *dic = @{ @"opt" : @"province", kToken : userInfo.token };
[XXNetWorkManager requestWithMethod:POST
                         withParams:dic
                      withUrlString:@"Houses"
                            withHud:@"城市刷新中..."
                  withProgressBlock:^(float requestProgress) {

                  }
                   withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                       if (code == 200) {
                           _dataArr = [City mj_objectArrayWithKeyValuesArray:data];

                           for (City * cmodel in _dataArr ) {
                               for(cityAry * model in  cmodel.cityAry) {
                                   XXLog(@"--%@",model.cityName);
                               }
                           }
                       } else {
                           [XXProgressHUD showMessage:@"列表加载失败,下拉重试"];
                       }
                       [self.tableview.mj_header endRefreshing];
                       [weakSelf.tableview cyl_reloadData];

                   }
                   withFailuerBlock:^(id error){
                       [self.tableview.mj_header endRefreshing];
                   }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count + 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else {
    return [[_dataArr[section - 2] cityAry] count];
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.textLabel.font = kBoldFont(15);
    cell.textLabel.textColor = kRGB_HEX(0x9696996);

    if (indexPath.section == 0) {
        cell.textLabel.text = _cityNameNow;
    } else if(indexPath.section == 1) {
        cell.textLabel.text = _cityName;

    } else {
    cell.textLabel.text = [[_dataArr[indexPath.section - 2] cityAry][indexPath.row] cityName];

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    v1.backgroundColor =kAllRGB;

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];

    if (section == 0) {
        label.text = @"当前位置";
    } else
    if (section == 1) {
        label.text = @"定位位置";
    } else
    {
        label.text = [_dataArr[section - 2 ] provinceName];
    }

    label.textColor = kRGB_HEX(0x969696);
    label.font = kFont(14);
    [v1 addSubview:label];
    return v1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf;

    NSString *str = @"";

    if (indexPath.section == 0) {

        str = _cityNameNow;
    } else if (indexPath.section == 1) {
        str = _cityName;
    }  else {
        str = [[_dataArr[indexPath.section - 2] cityAry][indexPath.row] cityName];
    }
    
    [LBXAlertAction showAlertWithTitle:@"切换城市" msg: str buttonsStatement:@[@"切换",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
        NSLog(@"%ld",(long)buttonIdx);

        if (buttonIdx == 0) {
            _cityNameNow = str;
            [weakSelf.navigationController popViewControllerAnimated:true];
        } else {

        }
    }];

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.chooseCityNameBlock(_cityNameNow);
}

@end
