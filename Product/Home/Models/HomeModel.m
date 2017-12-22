//
//  HomeModel.m
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"ID" : @"id" };
}

@end

@implementation InformationModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
        @"ID" : @"id",
    };
}

@end

@implementation CityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
        @"districtListArr" : @"districtList",
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"districtListArr" : [DistrictListModel class] };
}

@end

@implementation DistrictListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
        @"jeidaoArr" : @"jeidaoAry",
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"jeidaoArr" : [JeidaoModel class] };
}

@end

@implementation JeidaoModel

@end

@implementation PirceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"ID" : @"id" };
}
@end

@implementation HuXingModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"ID" : @"id" };
}
@end

@implementation JZLXModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"ID" : @"id" };
}

@end

@implementation HouseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"ID" : @"id",
              @"tagsArr" : @"label",
              };
}

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"tagsArr" : [Label class],
             };
}

@end

@implementation PropertiesDetails_Model


+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
             @"ID" : @"id",
             @"picArr" : @"pic",
             @"mdArr" : @"md",
             @"tjArr" : @"tj",
             @"hxArr" : @"hx",
             @"labelArr" : @"label",

             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"picArr" : [Pic class],
        @"mdArr" : [Md class],
        @"tjArr" : [Tj class],
        @"hxArr" : [Hx class],
        @"labelArr" : [Label class],
    };
}


@end
@implementation Label

@end

@implementation PropertiesXinxi_Model

@end
@implementation Pic

@end
@implementation Hx

@end
@implementation Md

@end
@implementation Tj
@end
@implementation Huxingxinxi
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"picArr" : @"pic"
             };
}
+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"picArr" : [Pic class],
             };
}
@end

@implementation Tuijian

@end

@implementation YongJinFA

@end
@implementation TianQiModel

@end

@implementation BaoBeiChengJiao

@end
@implementation KHGZModel

@end
@implementation City
+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"cityAry" : [cityAry class]
             };
}
@end
@implementation cityAry

@end
@implementation Banner

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"content" : @"url"
             };
}


@end
@implementation DataModel
@end

