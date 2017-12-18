//
//  PeopleDetailsModel.h
//  Product
//
//  Created by HJ on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleDetailsModel : NSObject
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * nucleus;
@property (nonatomic, strong) NSString * max_area;
@property (nonatomic, strong) NSString * record_id;
@property (nonatomic, strong) NSString * min_area;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * min_price_budget;
@property (nonatomic, strong) NSArray * lpArr;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * max_price_budget;
@property (nonatomic ,copy) NSString *yh_attestation;



@end

@interface LP : NSObject

@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * record_id;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * price_max_s;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * com_status;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic ,copy) NSString *yh_attestation;
@property (nonatomic ,copy) NSString *apply;


@end
