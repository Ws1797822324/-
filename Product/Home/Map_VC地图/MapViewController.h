//
//  MapViewController.h
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface MapViewController : UIViewController
@property (strong, nonatomic)   MAMapView *mapView;



@property (nonatomic ,assign) CLLocationCoordinate2D location;


@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,strong) NSString *addressStr;


@end
