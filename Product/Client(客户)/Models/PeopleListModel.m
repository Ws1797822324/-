//
//  PeopleListModel.m
//  Product
//
//  Created by HJ on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PeopleListModel.h"

@implementation PeopleListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id"
             };
}

@end
