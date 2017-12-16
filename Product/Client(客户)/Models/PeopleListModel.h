//
//  PeopleListModel.h
//  Product
//
//  Created by HJ on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleListModel : NSObject
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * l_name;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * record_id;
@property (nonatomic, strong) NSString * time;
@property (nonatomic ,strong) NSString *type; //  1  前三后四  2  不处理

@end
