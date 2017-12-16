//
//  NewsModel.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             };
}

@end
