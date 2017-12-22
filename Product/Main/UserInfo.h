//
//  UserInfoi.h
//  Product
//
//  Created by Sen wang on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *LoginType;
@property (nonatomic ,strong) NSString *m_name;  // 门店名称

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *tissue;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *attestation;   // 实名认证  1 已认证  0 未认证
@property (nonatomic, copy) NSString *invitation_code;
@property (nonatomic ,copy) NSString *zjyqm;

@property (nonatomic ,copy) NSString *yh_attestation;  // 银行卡认证   1  以  0 未
/** 1 游客   2 经纪人 */
@property (nonatomic ,copy) NSString *status;


/** 定位的位置(南京) */
@property (nonatomic ,copy) NSString *position;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *lng;



@property (nonatomic ,copy) NSDictionary *dicCity;
@property (nonatomic ,copy) NSDictionary *dicPriceF;
@property (nonatomic ,copy) NSDictionary *dicPriceS;

@property (nonatomic ,copy) NSDictionary *dicHuXing;
@property (nonatomic ,copy) NSDictionary *dicJZLX;

@property (nonatomic ,strong) NSString *sfz_z; // 身份证正面照图片地址
@property (nonatomic ,strong) NSString *sfz_f;  // 反面

@property (nonatomic ,strong) NSString *sfz_name;  // 真实姓名
@property (nonatomic ,strong) NSString *sfz_code;  // 身份证号

@property (nonatomic ,strong) NSArray *dizhiArr; // 请佣详情页面的地址   单选

@property (nonatomic ,strong) NSDictionary *jisuanqiDic; // 计算器

@property (nonatomic ,strong) NSString *kefuPhone;


@end
