//
//  PeopleDetailsModel.m
//  Product
//
//  Created by HJ on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PeopleDetailsModel.h"

@implementation PeopleDetailsModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"lpArr" : @"lp"
             };
}

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"lpArr" : [LP class]
             };
}
@end

@implementation LP

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             };
}
@end

@implementation FWXQ

@end



