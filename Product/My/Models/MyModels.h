//
//  MyModels.h
//  Product
//
//  Created by Sen wang on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModels : NSObject

@end

#pragma mark - 个人中心 Model
@interface PersonalDataModel : NSObject
/** 个人介绍 */
@property (nonatomic, copy) NSString *introduce;
/** 身份证号 */
@property (nonatomic, copy) NSString *id_card;
/** 工作年限 */
@property (nonatomic, copy) NSString *work_limit;
/** 身份证正反面照片 */
@property (nonatomic, copy) NSString *pic_z;
@property (nonatomic, copy) NSString *pic_fan;
/** 真实姓名 */
@property (nonatomic, copy) NSString *real_name;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 出生时间 */
@property (nonatomic, copy) NSString *date;
/** 家乡 */
@property (nonatomic, copy) NSString *home;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *url;
/** 头像 */
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, strong) NSArray *labelArr;
/** 门店名称 */
@property (nonatomic, strong) NSString *m_name;

/** 实名认证 */ // 1 已认证
@property (nonatomic, copy) NSString *attestation;

@end

#pragma mark - 标签页 Model

@interface TagsGroupModel : NSObject
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSArray *tagesGroupArr;
@property (nonatomic, copy) NSString *type_name;

@end

@interface TagsModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bname;

@end

#pragma mark - 积分商城的 Model

@interface IntegralMall_Model : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *present_points;

@end

#pragma mark - 我的伙伴 A model

@interface MyPartner_Model : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger type; // 判断是 第几级

@end

#pragma mark - 商品详情

@interface GoodsModel : MyModels

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *dizhi;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *delails;
@property (nonatomic, copy) NSString *time;

@end

@interface JiFenXQ : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *product;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *client;
@property (nonatomic, copy) NSString *type;

@end

@interface DuiHuan : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *present_points;
@property (nonatomic, copy) NSString *status;

@end

@interface WorkTypeModel : NSObject

@property (nonatomic, copy) NSString *l_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *time;

@end

@interface JiFenGXModel : NSObject

@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *type;

@end

@interface YaoQingModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type_id;

@end

#pragma mark - 店铺Model

@interface DianPu : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * address;

@end

