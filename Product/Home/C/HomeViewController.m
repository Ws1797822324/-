//
//  HomeViewController.m
//  WWSS
//
//  Created by  海跃尚 on 17/11/2.
//  Copyright © 2017年  海跃尚. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeTableViewHeaderView.h"
#import "HomeCell.h"
#import "ADRollView.h"
#import "ChooseCity_VC.h"

#import "PropertiesDetails_VC.h"  // 楼市详情
#import "Information_TVC.h"  //  头条资讯

#import "AllProperties_VC.h"   // 全部楼盘

#import "ReportedPeopleViewController.h"

#import "MainCalculatorsViewController.h"
#import "SearchViewController.h"
#import "ReportedSuccessBase_VC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource ,SDCycleScrollViewDelegate,UINavigationControllerDelegate,
CLLocationManagerDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UITextField *TF_search;

@property(nonatomic, strong) HomeTableViewHeaderView * homeHeader;

@property (nonatomic ,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) ADRollView *adRollView;

@property (nonatomic, strong) NSMutableArray *adsArray;

@property (nonatomic ,strong) NSArray *houseArr;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic ,strong) CLLocation *currLocationl;


@property (nonatomic ,copy) NSString *fujinStr;
@property (nonatomic ,strong) TianQiModel *tianqimodel;

@property (nonatomic ,strong) NSString *cityName;

@property (nonatomic ,strong) NSArray *bannerArr;


@end

@implementation HomeViewController


#pragma mark -------开始定位
- (void)startLocation {

    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        _homeHeader.position_L.text = @"定位中...";
    }
}
// 代理方法实现
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {


    
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        _homeHeader.position_L.text = @"定位失败";
        [LBXAlertAction showAlertWithTitle:@"位置信息访问被拒绝,请前往设置开启" msg:nil buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {

        }];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
        _homeHeader.position_L.text = @"定位失败";
        [LBXAlertAction showAlertWithTitle:@"当前无法获取位置信息,请到开阔地带" msg:nil buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {

        }];

    }
}
#pragma mark - 定位代理

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    if (_currLocationl.horizontalAccuracy > 0) {//已经定位成功了
        [_locationManager stopUpdatingLocation];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil, nil] forKey:@"AppleLanguages"];
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{

        [self requestHouseData];
        [self requestTianQi];
    }];

    kUserData;
    kWeakSelf;
    //获取当前位置
    CLLocation *location = manager.location;
        _currLocationl = location;
    //获取坐标
    CLLocationCoordinate2D corrdinate = location.coordinate;

    //打印地址
    NSLog(@"latitude = %f longtude = %f",corrdinate.latitude,corrdinate.longitude);

    // 地址的编码通过经纬度得到具体的地址
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];

    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {

        CLPlacemark *placemark = [placemarks firstObject];

        //打印地址
        NSLog(@"iiiiiii - %@",placemark.locality);

        if (![userInfo.position isEqualToString:placemark.locality] && !kStringIsEmpty(placemark.locality)) {

            [LBXAlertAction showAlertWithTitle:kString(@"您当前所在城市与您之前选择的城市 %@ 不同,是否切换至当前所在城市", userInfo.position) msg: placemark.locality buttonsStatement:@[@"切换",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
                if (buttonIdx == 0) {
                    userInfo.position = placemark.locality;
                    [UserInfoTool saveAccount:userInfo];
                    _homeHeader.position_L.text = userInfo.position;

                }

                _homeHeader.position_L.text = userInfo.position;
                [weakSelf requestTianQi];

            }];
        }
        else {
            _homeHeader.position_L.text = userInfo.position;
            [weakSelf requestTianQi];

        }



    }];

    userInfo.lat = kString(@"%lf", corrdinate.latitude);
    userInfo.lng = kString(@"%lf", corrdinate.longitude);

    [UserInfoTool saveAccount:userInfo];
//
//停止定位
    [self.locationManager stopUpdatingLocation];
    }



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    [_cycleScrollView adjustWhenControllerViewWillAppera];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.adRollView stopTimer];
}

-(void)requestImage {
#pragma mark -轮播图链接请求

    NSDictionary * params = @{
                              @"opt" : @"home"
                              };

    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kUserServlet withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        NSLog(@"lunbotu %@",objc);
        if (code == 200) {

            NSMutableArray * bannerArr  = [NSMutableArray array];
            _bannerArr = [Banner mj_objectArrayWithKeyValuesArray:data[@"banner"]];


            for (Banner *dic1 in _bannerArr) {
                [bannerArr addObject:dic1.content];
            }

            // 滚动视图
            [self cycleScrollViewConfig:bannerArr];

            self.adsArray = [[NSMutableArray alloc]init];

            for (NSDictionary *dic1 in data[@"headline"]) {

                ADRollModel *model = [[ADRollModel alloc] init];

                model.noticeTitle = dic1[@"title"];
                [self.adsArray addObject:model];
            }
            if (!kArrayIsEmpty(_adsArray)) {
                [self configAdRollView:_adsArray];
                [self.adRollView start];
            }


        }
    } withFailuerBlock:^(id error) {

    }];

}
- (void)viewDidLoad {
    kUserData;
    kWeakSelf;
    [super viewDidLoad];

    [self startLocation];

    [self requestImage];

    self.navigationController.delegate = self;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, [[UIScreen mainScreen] bounds].size.width, kScreenHeight +20)];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestImage];
        [weakSelf requestHouseData];
        [weakSelf requestTianQi];

        

    }];
    HomeTableViewHeaderView * homeHeader = [[[UINib nibWithNibName:@"HomeTableViewHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    homeHeader.nearbyProperties_L.text = [NSString stringWithFormat:@"附近楼盘0家"];

    _tableView.autoresizesSubviews = NO;
    self.tableView.tableHeaderView = homeHeader;
    _homeHeader.position_L.text = userInfo.position;
    


#pragma mark - 选择城市跳转
    [[homeHeader.chooseCityButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

        [weakSelf chooseCityAction];
    }];
    self.homeHeader = homeHeader;
    
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:@"HomeCell_ID"];

    [self homeButtonAction];

    // Do any additional setup after loading the view from its nib.
    [self createdNavUI];
}

#pragma mark - 推荐楼盘请求
-(void)requestHouseData {
    kUserData;

    if (_currLocationl.horizontalAccuracy <= 0) {//  定位 失败
        [XXProgressHUD showMessage:@"定位失败,请下拉刷新定位"];
        [self.tableView.mj_header endRefreshing];
        return;

    }

    NSDictionary * params = @{
                              kToken : userInfo.token,
                              kOpt : @"shouye",
                              @"lat" : userInfo.lat,
                              @"lng" : userInfo.lng,
                              };


    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:@"推荐楼盘..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"shouye  %@",objc);
        kInspectSignInType;
        if (code == 200) {

            _houseArr = [HouseModel mj_objectArrayWithKeyValuesArray:data[@"tuijian"]];

            _homeHeader.nearbyProperties_L.text = [NSString stringWithFormat:@"附近楼盘%@家",data[@"fujin"]];

            [_tableView cyl_reloadData];
        }
    } withFailuerBlock:^(id error) {

    }];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark   - ----  全部楼盘那一排按钮
-(void) homeButtonAction {
    kWeakSelf;
    // 全部楼盘
    [[_homeHeader.allPropertiesBtn rac_signalForControlEvents:UIControlEventTouchUpInside ]subscribeNext:^(__kindof UIControl * _Nullable x) {


        AllProperties_VC * allVC = [[AllProperties_VC alloc]init];
        allVC.navigationItem.title = @"全部楼盘";
        allVC.type = 0;
        [(YMNavgatinController *)weakSelf.navigationController pushViewController:allVC type:YMNavgatinControllerTypeBlue animated:YES];
    }];
    // 周边楼盘
    [[_homeHeader.aroundPropertiesBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        AllProperties_VC * aroundVC = [[AllProperties_VC alloc]init];
        aroundVC.navigationItem.title = @"周边楼盘";
        aroundVC.type = 1;

        [(YMNavgatinController *)weakSelf.navigationController pushViewController:aroundVC type:YMNavgatinControllerTypeBlue animated:YES];

    }];
    // 一键查看
    [[_homeHeader. quick_Btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        AllProperties_VC * aroundVC = [[AllProperties_VC alloc]init];
        aroundVC.navigationItem.title = @"周边楼盘";
        aroundVC.type = 1;

        [(YMNavgatinController *)weakSelf.navigationController pushViewController:aroundVC type:YMNavgatinControllerTypeBlue animated:YES];

    }];
    kUserData;
    if ([userInfo.status intValue]!=1) {  // 游客


    // 报备客户
    [[_homeHeader.BBKHBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ReportedPeopleViewController * VC = [[ReportedPeopleViewController alloc] init];
        [(YMNavgatinController *)weakSelf.navigationController pushViewController:VC type:YMNavgatinControllerTypeBlue animated:YES];
    }];
    // 报备成交
    [[_homeHeader.BBCJBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ReportedSuccessBase_VC * VC = [ReportedSuccessBase_VC viewControllerFromNib];
        [(YMNavgatinController *)weakSelf.navigationController pushViewController:VC type:YMNavgatinControllerTypeBlue animated:YES];
    }];

    } else {

    }
    // 房贷计算器
    [[_homeHeader.FDJSQBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        MainCalculatorsViewController * VC = [[MainCalculatorsViewController alloc] init];

        [(YMNavgatinController *)weakSelf.navigationController pushViewController:VC type:YMNavgatinControllerTypeBlue animated:YES];
    }];
    
    
}
#pragma mark  -- 滚动广告  热点资讯

-(void) configAdRollView:(NSMutableArray*)headlineArr {

    for (UIView * vv in _homeHeader.adRollView.subviews) {

        if (vv.tag == 997) {

            [vv removeFromSuperview];

        }
    }

    self.adRollView = [[ADRollView alloc] initWithFrame:CGRectMake(0, 3, kScreenWidth-48, 25)];
    self.adRollView.tag = 997;
    [self.adRollView setVerticalShowDataArr:headlineArr];
    [self.homeHeader.adRollView addSubview:_adRollView];


    //点击公告内容

    kWeakSelf;

    self.adRollView.clickBlock = ^(NSInteger index) {

        Information_TVC * tvc =[[Information_TVC alloc]init];
        [(YMNavgatinController *)weakSelf.navigationController pushViewController:tvc type:YMNavgatinControllerTypeBlue animated:YES];
    
    };

}



-(void)cycleScrollViewConfig:(NSMutableArray *)bannerArr {
    
#pragma mark   网络加载 --- 创建带标题的图片轮播器

    for (UIView *hhc in self.homeHeader.advertisementView.subviews) {
        if (hhc.tag == 884) {
            [hhc removeFromSuperview];
        }
    }
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth / 2) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.tag = 884;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.pageControlType = NO;
    
    _cycleScrollView.pageDotImage = kImageNamed(@"pageControlDot");
    _cycleScrollView.currentPageDotImage = kImageNamed(@"pageControlCurrentDot");
    _cycleScrollView.imageURLStringsGroup = bannerArr;
    [self.homeHeader.advertisementView addSubview: _cycleScrollView];

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"我是第%ld张",index);
    Banner * model = _bannerArr[index] ;

    InformationModel * kModel = [[InformationModel alloc]init];
    kModel.extra = model.extra;
    kModel.type = model.type;
    kModel.ID = model.ID;
    InformationDetails_WebVC * vc = [[InformationDetails_WebVC alloc]init];
    vc.navigationItem.title = model.title;
        vc.model =kModel;
    [(YMNavgatinController*)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];
}
#pragma mark - UINavigationControllerDelegate
    // 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    self.navigationController.fd_prefersNavigationBarHidden = isShowHomePage;
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


#pragma mark - 天气请求
-(void) requestTianQi {
    kUserData;
    if (_currLocationl.horizontalAccuracy <= 0) {//定位失败
        [XXProgressHUD showMessage:@"定位失败,请下拉刷新定位"];
        [self.tableView.mj_header endRefreshing];
        return;
    }
    NSString * cityStr = userInfo.position;
    if (kStringIsEmpty(cityStr)) {
        cityStr = @"南京";
    }

    NSDictionary * dic = @{
                           kOpt : @"tianqi",
                           kToken : userInfo.token,
                           @"name" : [cityStr  stringByReplacingOccurrencesOfString:@"市" withString:@""]
                           };


    kWeakSelf;
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:nil withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        kInspectSignInType;
        if (code == 200) {


            NSDictionary * dicc = data[@"result"][@"today"];
            if (!kDictIsEmpty(dicc)) {
                _tianqimodel = [TianQiModel mj_objectWithKeyValues:dicc];
            }
        } else {
            _tianqimodel.weather = @"天气";
            _tianqimodel.temperature = @"20~21°";
        }
        [_homeHeader.weather_ImgV sd_setImageWithURL:[NSURL URLWithString:kString(@"http://121.43.176.154:8080/mainaer/images/day/%@.png", _tianqimodel.weather_id[@"fa"])] forState:UIControlStateNormal placeholderImage:kImageNamed(@"tianqi")];
        XXLog(@"tttqqq--%@",_tianqimodel.weather_id);
        XXLog(@"tttqqq--%@",kString(@"http://121.43.176.154:8080/mainaer/images/day/%@.png", _tianqimodel.weather_id[@"fa"]));

        [weakSelf.homeHeader.weather_text setTitle:_tianqimodel.weather forState:UIControlStateNormal];
        [weakSelf.homeHeader.temperature setTitle:_tianqimodel.temperature forState:UIControlStateNormal];

        
    } withFailuerBlock:^(id error) {

    }];

}
#pragma mark  ------  搜索框
- (void)createdNavUI
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(40, 30, kWidth - 80, 40)];

    self.TF_search = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, 40)];
    self.TF_search.placeholder = @"  请输入小区房或房源编号";
    self.TF_search.userInteractionEnabled = NO;
    self.TF_search.backgroundColor =  kRGBColor(71, 149, 238, 0.8);
    self.TF_search.alpha = 0.6;
    [self.TF_search setValue:kRGBColor(157, 201, 247,1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.TF_search setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.TF_search.font = [UIFont systemFontOfSize:14];

    [view addSubview:self.TF_search];
    UIView * searchView = [[UIView alloc]init];
    searchView.frame = self.TF_search.frame;
    [view addSubview:searchView];

    self.TF_search.borderStyle = UITextBorderStyleRoundedRect;
    kViewRadius(self.TF_search, 15);
    //创建左侧视图
    UIImage *im = [UIImage imageNamed:@"search"];

    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    iv.center = lv.center;
    [lv addSubview:iv];
    
    self.TF_search.leftViewMode = UITextFieldViewModeAlways;
    self.TF_search.leftView = lv;
    
    [self.TF_search resignFirstResponder];
    self.TF_search.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchCar)];
    [self.TF_search addGestureRecognizer:tap];
    
    [self.view addSubview:view];
    [view tapPeformBlock:^{
        [self searchCar];
    }];

    [searchView tapPeformBlock:^{
        [self searchCar];
    }];

}


-(void)searchCar {
    SearchViewController * VC = [[SearchViewController alloc] init];
    VC.type = @"房屋";
    [(YMNavgatinController *)self.navigationController pushViewController:VC type:YMNavgatinControllerTypeBlue animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _houseArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell_ID"];
    HouseModel * model = _houseArr[indexPath.row];
    cell.model = model;

    cell.tagsView.hidden = 0;
    if (model.tagsArr.count>0) {
        cell.tagsView.hidden = 1;
        [cell tagsData:model.tagsArr];
    } else {
        cell.tagsView_H.constant = 2;
        [cell.tagsView removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    HouseModel * model = _houseArr[indexPath.row];
    if (model.tagsArr.count == 0) {
        return 85;
    } else {
        NSMutableArray * arrr = [NSMutableArray array];
        for (Label * jj in model.tagsArr) {
            [arrr addObject:jj.name];
        }
        return 70 + [SQButtonTagView returnViewHeightWithTagTexts:arrr
                                                        viewWidth:kWidth - 170
                                                          eachNum:0
                                                          Hmargin:10
                                                          Vmargin:5
                                                        tagHeight:20
                                                      tagTextFont:kBoldFont(12)];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PropertiesDetails_VC * propertiesDetails = [[PropertiesDetails_VC alloc]init];
    HouseModel * model = _houseArr[indexPath.row];
    propertiesDetails.houseID = model.ID;
    [(YMNavgatinController*)self.navigationController pushViewController:propertiesDetails type:YMNavgatinControllerTypeClear animated:YES];
}


-(void)chooseCityAction {
    kUserData;
    kWeakSelf
    ChooseCity_VC * VC = [[ChooseCity_VC alloc]init];
    VC.chooseCityNameBlock = ^(NSString *cityName) {

        userInfo.position = cityName;
        [UserInfoTool saveAccount:userInfo];

        _homeHeader.position_L.text = userInfo.position;
        [weakSelf requestTianQi];

    };
    VC.cityNameNow = userInfo.position;
    [(YMNavgatinController*)self.navigationController pushViewController:VC type:YMNavgatinControllerTypeBlue animated:YES];



}

#pragma mark - CYLTableViewPlaceHolderDelegate

-(UIView *)makePlaceHolderView {
    kWeakSelf
    PlaceHolderView * placeHolderV = [PlaceHolderView viewFromXib];
    [[placeHolderV.reloadDataButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    return placeHolderV;
}



@end
