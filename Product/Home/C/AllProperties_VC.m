//
//  AllProperties_VC.m
//  Product
//
//  Created by  海跃尚 on 17/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AllProperties_VC.h"

#import "PropertiesDetails_VC.h"
#import "HomeCell.h"

@interface AllProperties_VC () <UITableViewDelegate, UITableViewDataSource, DOPDropDownMenuDataSource,CYLTableViewPlaceHolderDelegate,DOPDropDownMenuDelegate>

{
    DOPDropDownMenu *_menu;
    int _page;
    UITableView *_tableview;
}

@property (nonatomic, strong) CityModel *cityModel;        // 市 Model   1
@property (nonatomic, strong) NSMutableArray *districtArr; // 区域名   1
@property (nonatomic, strong) NSMutableArray *jieDaoArr;   // 区域名  1
@property (nonatomic ,copy) NSString *cityID;


@property (nonatomic, strong) NSMutableArray *pirceArrayF; // 单价    2
@property (nonatomic ,copy) NSString *pirce11;
@property (nonatomic ,copy) NSString *pirce12;

@property (nonatomic, strong) NSMutableArray *pirceArrayS; //总价  2
@property (nonatomic ,copy) NSString *pirce21;
@property (nonatomic ,copy) NSString *pirce22;

@property (nonatomic ,strong) NSMutableArray *huXingArr; // 户型  3
@property (nonatomic ,copy) NSString *huxingID;

@property (nonatomic ,strong) NSMutableArray *jZLX_Arr; // 建筑类型  4
@property (nonatomic ,strong) NSString *jzlxID;

@property (nonatomic ,strong) NSMutableArray *dataArr;


@end

@implementation AllProperties_VC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")]];



    [self requestConditionData];  //区域
    [self requestPirceData];  // 价格
    [self requestHuXingData]; // 户型
    [self requestJZLXData];  // 建筑类型

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self configMenu];
    [self configTableView];
    _districtArr = [NSMutableArray array];
    _jieDaoArr = [NSMutableArray array];
    _pirceArrayF = [NSMutableArray array];
    _pirceArrayS = [NSMutableArray array];
    _huXingArr = [NSMutableArray array];
    _jZLX_Arr = [NSMutableArray array];

    _jzlxID = @"";
    _huxingID = @"";
    _cityID = @"";
    _pirce21 = @"";
    _pirce22 = @"";
    _pirce11 = @"";
    _pirce12 = @"";
    _page = 0;
    [self requestAllHouseDataIsRefreshType:YES];

}

- (void)configMenu {

    NSInteger h = kNavHeight;
    if (kiPhone6sP_7sP) {
        h = 0;
    }
#pragma mark -  这个页面的 menu  和 tableView 布局有极大地问题
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, kNavHeight) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    _menu = menu;

    [self.view addSubview:menu];

    //  设置默认项
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0] triggerDelegate:NO];


    [[kNoteCenter rac_addObserverForName:@"ItemPopupViewTF" object:nil] subscribeNext:^(NSNotification *_Nullable x) {
        NSDictionary *dict = x.userInfo;
        NSLog(@"通知收到了  - %@", dict);
    }];
}

#pragma mark - data source DOPDropDownMenu

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 4;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {

    if (column == 0) {
        return _districtArr.count + 1;
    }
    if (column == 1) {

        return 2;
    }
    if (column == 2) {
        return _huXingArr.count + 1;
    }
    if (column == 3) {
        return _jZLX_Arr.count + 1;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {

        if (indexPath.row == 0) {
            return @"不限";
        }
        return _districtArr[indexPath.row - 1];
    }
    if (indexPath.column == 1) {

        if (indexPath.row == 0) {
            return @"单价";
        }
        if (indexPath.row == 1) {
            return @"总价";
        }

        return @"错了";
    }
    if (indexPath.column == 2) {
        if (indexPath.row == 0) {
            return @"不限";
        }
        HuXingModel * hxModel = _huXingArr[indexPath.row -1];
        return hxModel.house_type;
    }
    if (indexPath.column == 3) {
        if (indexPath.row == 0) {
            return @"不限";
        }
        JZLXModel * jzlxModel = _jZLX_Arr[indexPath.row -1];
        return jzlxModel.tenement;
    }
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    if (column == 0) { // 列  column
        if (row == 0) {
            return 0;
        }
        return 0;
    }
    if (column == 1) { // 列

        if (row == 0) {
            return _pirceArrayF.count + 1;
        }
        if (row == 1) {
            return _pirceArrayS.count + 1;
        }
    }
    return 0;
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return @"不限";
        }
//        NSArray *arr1 = _jieDaoArr[indexPath.row - 1];
//        return arr1[indexPath.item];
        return @"";
    }

    if (indexPath.column == 1) {

        if (indexPath.row == 0) {
            if (indexPath.item == 0) {
                return @"不限";
            }
            PirceModel *modelO = _pirceArrayF[indexPath.item -1];
            if (kStringIsEmpty(modelO.min)) {
                return [NSString stringWithFormat:@"%@%@", modelO.max, modelO.unit];
            } else {
                return [NSString stringWithFormat:@"%@-%@%@", modelO.min, modelO.max, modelO.unit];
            }
            return @"错误数据";
        }
        if (indexPath.row == 1) {
            if (indexPath.item == 0) {
                return @"不限";
            }
            PirceModel *modelS = _pirceArrayS[indexPath.item - 1];
            if (kStringIsEmpty(modelS.min)) {
                return [NSString stringWithFormat:@"%@%@", modelS.max, modelS.unit];
            } else {
                return [NSString stringWithFormat:@"%@-%@%@", modelS.min, modelS.max, modelS.unit];
            }
            return @"错误数据";
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {

    if (indexPath.column == 3) {
        if (indexPath.row != 0) {
        JZLXModel * jmodel = _jZLX_Arr[indexPath.row -1];
        _jzlxID = jmodel.ID;
        } else {
            _jzlxID = @"";
        }

        [self requestAllHouseDataIsRefreshType:YES];

    }
    if (indexPath.column == 2) {
        if (indexPath.row == 0) {
            _huxingID = @"";
        } else {
        HuXingModel *hModel = _huXingArr[indexPath.row -1];
        _huxingID = hModel.ID;
        }
        [self requestAllHouseDataIsRefreshType:YES];
    }
//    if (indexPath.column == 1) {
//
//        if (indexPath.row == 0) {
//
//            if (indexPath.item == 0) {
//                _pirce11 = @"kkk";
//                _pirce12 = @"ooo";
//            } else {
////                PirceModel * model = _pirceArrayF[indexPath.item - 1];
////                _pirce11 = model.min;
////                _pirce12 = model.max;
//            }
//        }
//        if (indexPath.row == 1) {
//
//            if (indexPath.item == 0) {
//                _pirce21 = @"";
//                _pirce22 = @"";
//            } else {
////                PirceModel * model = _pirceArrayS[indexPath.item - 1];
////                _pirce21 = model.min;
////                _pirce22 = model.max;
//            }
//        }
//        [self requestAllHouseDataIsRefreshType:YES];
//
//    }
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            _cityID = @"";
        } else {
        DistrictListModel * model = _cityModel.districtListArr[indexPath.row - 1];
            if (model.jeidaoArr.count == 0) {
                _cityID = model.disName;
            } else {
                JeidaoModel *jmodel = model.jeidaoArr[indexPath.row];
                _cityID = jmodel.jeidaoName;

            }
        }
        [self requestAllHouseDataIsRefreshType:YES];

    }
}

#pragma mark---   设置 tableview
- (void)configTableView {
    self.view.backgroundColor = kAllRGB;
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;

    }

    _tableview = [[UITableView alloc] init];
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[HomeCell nib]
        forCellReuseIdentifier:@"HomeCell"];

    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestConditionData];  //区域
        [self requestPirceData];  // 价格
        [self requestHuXingData]; // 户型
        [self requestJZLXData];  // 建筑类型

        [self requestAllHouseDataIsRefreshType:YES];
    }];

    _tableview.mj_header.automaticallyChangeAlpha = YES;

    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestAllHouseDataIsRefreshType:NO];

    }];

    [self.view addSubview:_tableview];
    NSInteger h = kNavHeight;
    if (kiPhone6sP_7sP) {
        h = 0;
    }
#pragma mark -  这个页面的 menu  和 tableView 布局有极大地问题
    _tableview.frame = CGRectMake(0, 45 + kNavHeight, kWidth, kHeight - kNavHeight - 45);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"search")highImage:kImageNamed(@"search")target:self action:@selector(rightAction) withTitle:@""];
}


#pragma mark - 筛选条件请求 区域
- (void)requestConditionData {
    kUserData;
    NSString * city = userInfo.position;
    if (kStringIsEmpty(userInfo.position)) {
        city = @"南京市";
    }
    NSDictionary *parmas = @{ kOpt : @"shouhuoAddress", @"name" : city, kToken : userInfo.token };

    [XXNetWorkManager requestWithMethod:POST
        withParams:parmas
        withUrlString:@"Houses"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            kInspectSignInType;

            if (code == 200) {
                userInfo.dicCity = data;
                _jieDaoArr = [NSMutableArray array];
                _districtArr = [NSMutableArray array];


                _cityModel = [CityModel mj_objectWithKeyValues:data];
            }


            for (DistrictListModel *dModel in _cityModel.districtListArr) {

                [_districtArr addObject:dModel.disName];

                NSMutableArray *arr = [NSMutableArray array];

                for (JeidaoModel *jModel in dModel.jeidaoArr) {

                    [arr addObject:jModel.jeidaoName];
                }
                [_jieDaoArr addObject:arr];
            }
        }



        withFailuerBlock:^(id error){

            _cityModel = [CityModel mj_objectWithKeyValues:userInfo.dicCity];
            for (DistrictListModel *dModel in _cityModel.districtListArr) {

                [_districtArr addObject:dModel.disName];

                NSMutableArray *arr = [NSMutableArray array];

                for (JeidaoModel *jModel in dModel.jeidaoArr) {

                    [arr addObject:jModel.jeidaoName];
                }
                [_jieDaoArr addObject:arr];
            }
            [_menu reloadData];

        }];
}

#pragma mark - 筛选条件请求  价格
- (void)requestPirceData {
    kUserData;
    NSDictionary *parmas1 = @{
        kOpt : @"jiage",
        @"type" : @"1", // 单价
        kToken : userInfo.token
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:parmas1
        withUrlString:@"Houses"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            kInspectSignInType;
            if (code == 200) {
                userInfo.dicPriceF = data;
                [UserInfoTool saveAccount:userInfo];
                _pirceArrayF = [PirceModel mj_objectArrayWithKeyValuesArray:data];

            } else {
                _pirceArrayF = [PirceModel mj_objectArrayWithKeyValuesArray:userInfo.dicPriceF];

            }

        }
        withFailuerBlock:^(id error){
            _pirceArrayF = [PirceModel mj_objectArrayWithKeyValuesArray:userInfo.dicPriceF];
            [_menu reloadData];

        }];

    // MARK: ------ ---------------- ------

    NSDictionary *parmas2 = @{
        kOpt : @"jiage",
        @"type" : @"2", // 单价
        kToken : userInfo.token
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:parmas2
        withUrlString:@"Houses"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            kInspectSignInType;
            if (code == 200) {
                userInfo.dicPriceS = data;
                [UserInfoTool saveAccount:userInfo];

                _pirceArrayS = [PirceModel mj_objectArrayWithKeyValuesArray:data];
            } else {
                _pirceArrayS = [PirceModel mj_objectArrayWithKeyValuesArray:userInfo.dicPriceS];

            }

        }
        withFailuerBlock:^(id error){
            _pirceArrayS = [PirceModel mj_objectArrayWithKeyValuesArray:userInfo.dicPriceS];
            [_menu reloadData];

        }];
}

#pragma mark - 筛选条件请求  户型
-(void) requestHuXingData {
    kUserData;
    NSDictionary * params = @{
                              kOpt : @"huxing",
                              kToken : userInfo.token
                              };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        kInspectSignInType;
        if (code == 200) {
            userInfo.dicHuXing = data;
            [UserInfoTool saveAccount:userInfo];

            _huXingArr = [HuXingModel mj_objectArrayWithKeyValuesArray:data];
        } else {
            _huXingArr = [HuXingModel mj_objectArrayWithKeyValuesArray:userInfo.dicHuXing];

        }
    } withFailuerBlock:^(id error) {
        _huXingArr = [HuXingModel mj_objectArrayWithKeyValuesArray:userInfo.dicHuXing];
        [_menu reloadData];

    }];
}

#pragma mark - 筛选条件请求  物业  第四列

-(void) requestJZLXData {
    kUserData;
    NSDictionary * params = @{
                              kOpt : @"jianzhuleixing",
                              kToken : userInfo.token
                              };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        kInspectSignInType;
        if (code == 200) {
            userInfo.dicJZLX = data;
            [UserInfoTool saveAccount:userInfo];

            _jZLX_Arr = [JZLXModel mj_objectArrayWithKeyValuesArray:data];
        } else {
            _jZLX_Arr = [JZLXModel mj_objectArrayWithKeyValuesArray:userInfo.dicJZLX];

        }
    } withFailuerBlock:^(id error) {
        _jZLX_Arr = [JZLXModel mj_objectArrayWithKeyValuesArray:userInfo.dicJZLX];
        [_menu reloadData];

    }];

}



- (void)rightAction {

    NSLog(@"你点到了右边搜索");
    SearchViewController * searchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - 查询All楼盘 接口

-(void)requestAllHouseDataIsRefreshType:(BOOL)type {
    kUserData;
    if (type) {
        _page = 0;
    }

    NSDictionary * params = @{
                              kOpt : @"selectHouses",
                              kToken : userInfo.token,
                              @"page" : kString(@"%d", _page),
                              @"row" : @"10",
                              @"lat" : kStringIsEmpty(userInfo.lat) ? @"32.164575" : userInfo.lat,
                              @"lng" : kStringIsEmpty(userInfo.lng) ? @"118.691732" : userInfo.lng,
                              @"zhoubian" : kString(@"%d", _type),
                              @"building_types" : _jzlxID,  /// 建筑类型
                              @"q_id" : _cityID,    /// 区域 id
                              @"zshx_id" : _huxingID,  /// 户型 id
                              @"price_max" : _pirce22 ,  ///总价最大值
                              @"price_min" : _pirce21 ,  ///总价最小值
                              @"price_max_s" : _pirce12,  /// 单价最大值
                              @"price_min_s" : _pirce11 , /// 单价最小值
                              };

    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"iiiooooo %@",objc);

        if (code == 200) {
            _page ++;
            
            if (type) {
                _dataArr = [NSMutableArray array];

                _dataArr = [HouseModel mj_objectArrayWithKeyValuesArray:data];
            } else {
                NSArray * arr = [HouseModel mj_objectArrayWithKeyValuesArray:data];
                if (arr.count == 0) {
                    [XXProgressHUD showMessage:@"没有更多数据啦"];
                }
                [_dataArr arrayByAddingObjectsFromArray:arr];
            }
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];

        [_tableview cyl_reloadData];
    }

    } withFailuerBlock:^(id error) {
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = [HomeCell loadCellFromNib:tableView];

    cell.model = _dataArr[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    PropertiesDetails_VC * propertiesDetails = [[PropertiesDetails_VC alloc]init];
    HouseModel * model = _dataArr[indexPath.row];


    propertiesDetails.houseID = model.ID;

    
    [(YMNavgatinController*)self.navigationController pushViewController:propertiesDetails type:YMNavgatinControllerTypeClear animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"HomeCell" configuration:^(HomeCell *cell) {
        cell.model = _dataArr[indexPath.row];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CYLTableViewPlaceHolderDelegate

-(UIView *)makePlaceHolderView {

    PlaceHolderView * placeHolderV = [PlaceHolderView viewFromXib];
    [[placeHolderV.reloadDataButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_tableview.mj_header beginRefreshing];
    }];
    return placeHolderV;
}
@end
