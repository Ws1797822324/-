//
//  MyAnnotation.h
//  CustomeAnnotationView
//
//  Created by 王龙 on 16/3/19.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

#import <Foundation/Foundation.h>



//注意导入框架

#import <MapKit/MapKit.h>

//该模型是大头针模型 所以必须实现协议MKAnnotation协议 和CLLocationCoordinate2D中的属性coordinate
@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *title;

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict;


@end
