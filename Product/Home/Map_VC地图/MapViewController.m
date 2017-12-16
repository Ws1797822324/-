//
//  MapViewController.m
//  Product
//
//  Created by Sen wang on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MapViewController.h"
#import "YFRadialMenu.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JXMapNavigationView.h"
#import "MapPopupView.h"
#import "XXPointAnnotation.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "POIAnnotation.h"
#import "CommonUtility.h"
#import "ErrorInfoUtility.h"

@interface MapViewController () <AMapLocationManagerDelegate, MAMapViewDelegate, MKMapViewDelegate,YFRadialMenuDelegate, AMapSearchDelegate, UISearchBarDelegate>
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) JXMapNavigationView *mapNavigationView;

@property (nonatomic, strong) AMapLocationManager *locationManager;
/// 用户位置
@property (nonatomic, strong) MAUserLocationRepresentation *Representation;

@property (nonatomic ,assign) CLLocationCoordinate2D  myLocation; // 自己的位置

@property (nonatomic, copy) NSArray *pathPolylines;


@property (nonatomic, assign) CLLocationCoordinate2D destinationLocation; // 终点

@property (nonatomic, strong) XXPointAnnotation *pointAnnotion1; // 大头针

@property (nonatomic, strong) YFRadialMenu *radialView; // 菜单按钮




@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")]];
}


- (JXMapNavigationView *)mapNavigationView {
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[JXMapNavigationView alloc] init];
    }
    return _mapNavigationView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.title;
    [AMapServices sharedServices].apiKey = @"657f9c3b4796a7678da16859a6b3a351";

    self.mapView = [[MAMapView alloc] init];



    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.view);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    [AMapServices sharedServices].enableHTTPS = YES;

    _mapView.delegate = self;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    // 基础定位
    [self settingLocation];

    
    [self createdRadiaMenu];

    [self.mapView setCenterCoordinate:[self getGaoDeCoordinateByBaiDuCoordinate:_location] animated:YES];

    XXPointAnnotation *pointAnnotation = [[XXPointAnnotation alloc] init];


    pointAnnotation.coordinate = [self getGaoDeCoordinateByBaiDuCoordinate:_location];
    kWeakSelf;

    _pointAnnotion1 = pointAnnotation;

    [self.mapView addAnnotation:pointAnnotation];

    [self.mapView setZoomLevel:17 atPivot:CGPointMake(kWidth / 2 , kHeight / 2)  animated:true];

    [[RACScheduler mainThreadScheduler]afterDelay:0.1 schedule:^{
        [weakSelf.mapView selectAnnotation:_pointAnnotion1 animated:NO];

    }];


}
- (void)createdRadiaMenu{
    YFRadialMenu *radialView = [[YFRadialMenu alloc] initWithFrame:CGRectMake(self.view.center.x-40, self.view.frame.size.height - 250, 80, 80)];
    radialView.delegate = self;

    UIImageView * imageView = [[UIImageView alloc]initWithImage:kImageNamed(@"fujinsheshi")];
    imageView.frame = CGRectMake(0, 0, 80 ,80);
    [radialView.centerView addSubview:imageView];

    NSArray* imageArray = @[@"gongjiao",@"ditie",@"xuexiao",@"canyin",@"yiyuan",@"yinhang"];
    NSArray* keywordArray = @[@"公交",@"地铁",@"学校",@"餐饮",@"医院",@"银行"];
    NSInteger index = 0;
    for (NSString* imageName in imageArray) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.userInteractionEnabled = YES;
        [radialView addPopoutView:imageView withIndentifier:keywordArray[index]];
        index ++;
    }

    self.radialView = radialView;
    
    [self.view addSubview:radialView];
    [radialView enableDevelopmentMode:self];
}
-(void)radialMenu:(YFRadialMenu *)radialMenu didSelectPopoutWithIndentifier:(NSString *)identifier{
    NSLog(@"%@",identifier);
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];


    request.location  = [AMapGeoPoint locationWithLatitude:_location.latitude longitude:_location.longitude];
    
    request.keywords            = identifier;
    request.radius = 5000;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.radialView removeFromSuperview];
}
//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token {
    if (string == nil) {
        return NULL;
    }

    if (token == nil) {
        token = @",";
    }

    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }

    else {
        str = [NSString stringWithString:string];
    }

    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D *) malloc(count * sizeof(CLLocationCoordinate2D));

    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i] doubleValue];
        coordinates[i].latitude = [[components objectAtIndex:2 * i + 1] doubleValue];
    }

    return coordinates;
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self.locationManager stopUpdatingLocation];
}
#pragma mark - 基础定位

- (void)settingLocation {
    self.locationManager = [[AMapLocationManager alloc] init];

    _mapView.showsUserLocation = NO; // 显示用户位置

    _mapView.mapType = MAMapTypeStandard; // 普通地图

    _mapView.userTrackingMode = MAUserTrackingModeFollow;

    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;

    self.locationManager.delegate = self;
    _mapView.rotateEnabled = false; // 是否支持旋转

    self.locationManager.distanceFilter = 50;         // 设置定位最小更新距离 (米)
    self.locationManager.locatingWithReGeocode = YES; // 后台定位是否返回逆地理信息，默认NO

//    [self.locationManager startUpdatingLocation]; // 开始定位

}


#pragma mark -  // 百度地图经纬度转换为高德地图经纬度
- (CLLocationCoordinate2D)getGaoDeCoordinateByBaiDuCoordinate:(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(coordinate.latitude - 0.006, coordinate.longitude - 0.0065);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击大头针弹出的气泡
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {

    if ([annotation isKindOfClass:[XXPointAnnotation class]]) {

        static NSString *pointReuseIndentifier = @"pointReuseIndentifierWW";
        MAAnnotationView *annotationView =
        (MAAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView =
            [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }

        annotationView.frame = CGRectMake(0, 0, 100, 100);
        annotationView.canShowCallout = YES; //设置气泡可以弹出，默认为NO
        annotationView.draggable = YES; //设置标注可以拖动，默认为NO
        annotationView.selected = YES;
        //设置大头针显示的图片
        annotationView.image = [UIImage imageNamed:@"dingweitubio"];
        annotationView.annotation.title = self.title;
        annotationView.annotation.subtitle = self.addressStr;
        annotationView.canShowCallout = YES;
        MapPopupView * popView = [MapPopupView viewFromXib];
        popView.userInteractionEnabled = NO;
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
        popView.frame = rightButton.frame;
        [rightButton addSubview:popView];
        [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

            [self.mapNavigationView showMapNavigationViewWithtargetLatitude:_location.latitude targetLongitute:_location.longitude toName:_addressStr];  // 导航到楼盘

            [self.view addSubview:_mapNavigationView];;
        }];
        annotationView.rightCalloutAccessoryView = rightButton;

#pragma mark - 以上是楼盘的
        return annotationView;

    }
    else if ([annotation isKindOfClass:[POIAnnotation class]]) {

        static NSString *pointReuseIndentifier = @"pointReuseIndentifier1";
        
        MAAnnotationView *annotationView =
        (MAAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView =
            [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        annotationView.frame = CGRectMake(0, 0, 100, 100);
        
        annotationView.canShowCallout = YES; //设置气泡可以弹出，默认为NO
        annotationView.draggable = YES; //设置标注可以拖动，默认为NO
        //设置大头针显示的图片
        annotationView.image = [UIImage imageNamed:@"dingweitubio"];
        
        
        MapPopupView * popView = [MapPopupView viewFromXib];
        popView.userInteractionEnabled = NO;
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
        popView.frame = rightButton.frame;
        [rightButton addSubview:popView];


        [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
#pragma mark - 这是附近的东西的



            NSLog(@"kk -%lf",annotation.coordinate.latitude);
            NSLog(@"kkiiii -%lf",annotation.coordinate.longitude);


            [self.mapNavigationView showMapNavigationViewWithtargetLatitude:annotation.coordinate.latitude targetLongitute:annotation.coordinate.longitude toName:annotation.title];

            [self.view addSubview:_mapNavigationView];;
        }];
        
        annotationView.rightCalloutAccessoryView = rightButton;
        
        return annotationView;
    }
    return nil;
    
    
}
#pragma mark - 点击大头针调用
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    NSLog(@"%ld",(long)view.tag);

    
}
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{}
#pragma mark - AMapLocationManagerDelegate   接收处置位置更新 定位结果

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
        self.mapView.centerCoordinate = location.coordinate;
    
    
    NSLog(@"经纬度:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    _myLocation = location.coordinate;
    
}

@end

