//
//  MyModels.m
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyModels.h"

@implementation MyModels

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
             @"ID" : @"id",

             };
}

@end

@implementation PersonalDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
             @"labelArr" : @"label",

             };
}
+ (NSDictionary *)mj_objectClassInArray {

    return @{ @"labelArr" : [TagsModel class] };
}



@end
@implementation TagsGroupModel

+ (NSDictionary *)mj_objectClassInArray {

    return @{ @"tagesGroupArr" : [TagsModel class] };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
        @"tagesGroupArr" : @"labels"

    };
}

@end
@implementation TagsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
        @"ID" : @"id",

    };
}
@end

@implementation IntegralMall_Model

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"ID" : @"id",
    };
}

@end

@implementation MyPartner_Model

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"ID" : @"id",
    };
}

@end
@implementation GoodsModel

@end
@implementation JiFenXQ

@end



@implementation DuiHuan

@end
@implementation WorkTypeModel

@end
@implementation JiFenGXModel
@end
@implementation YaoQingModel
@end@implementation DianPu


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             };
}
@end

