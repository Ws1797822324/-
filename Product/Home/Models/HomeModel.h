//
//  HomeModel.h
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 房屋
@interface HomeModel : NSObject

@end

@interface InformationModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *browse;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic ,copy) NSString *type;


@end

#pragma mark - 筛选条件的 model  区域
@interface CityModel : NSObject

@property (nonatomic, copy) NSArray *districtListArr;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@end

#pragma mark - 区
@interface DistrictListModel : NSObject //
@property (nonatomic, copy) NSString *districtId;
@property (nonatomic, copy) NSString *disName;
@property (nonatomic, copy) NSArray *jeidaoArr;

@end

#pragma mark - 街道
@interface JeidaoModel : NSObject
@property (nonatomic, copy) NSString *jeidaoName;
@property (nonatomic, copy) NSString *jeidaoId;

@end

#pragma mark - 筛选条件的 model  价格

@interface PirceModel : NSObject
@property (nonatomic, copy) NSString *min;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *unit;

@end
#pragma mark - 筛选条件的 model  户型

@interface HuXingModel : NSObject
@property (nonatomic, copy) NSString *house_type;
@property (nonatomic, copy) NSString *ID;

@end

#pragma mark - 筛选条件的 model  建筑类型

@interface JZLXModel : NSObject
@property (nonatomic, copy) NSString *tenement;
@property (nonatomic, copy) NSString *ID;

@end

#pragma mark - 推荐楼盘 Model

@interface HouseModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *juli;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *price;
@property (nonatomic ,copy) NSArray *tagsArr;


@end
#pragma mark - 楼盘详情页面

@interface PropertiesDetails_Model : HomeModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *he_time;
@property (nonatomic, copy) NSString *open_time;
@property (nonatomic, copy) NSString *exe_dttj;
@property (nonatomic, copy) NSArray *picArr;
@property (nonatomic, copy) NSArray *hxArr;
@property (nonatomic, copy) NSString *sc_status;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSArray *mdArr;
@property (nonatomic, copy) NSString *exe_yj;
@property (nonatomic, copy) NSString *price_min_s;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSArray *tjArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic ,copy) NSArray *labelArr;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *weixinid;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;



@end
@interface Label : NSObject
@property (nonatomic ,copy) NSString *name;

@end

@interface Pic : NSObject

@property (nonatomic, copy) NSString *pic_kx;
@property (nonatomic ,copy) NSString *picurl;


@end

@interface Hx : NSObject
@property (nonatomic, copy) NSString *room_office;
@property (nonatomic, copy) NSString *pic_hx;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *id_hs;
@property (nonatomic ,copy) NSString *minareaname;


@end

@interface Md : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;

@end

@interface Tj : HomeModel
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price_min_s;

@end

#pragma mark - 楼盘信息

@interface PropertiesXinxi_Model : HomeModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *age_limit;
@property (nonatomic, copy) NSString *open_time;
@property (nonatomic, copy) NSString *households;
@property (nonatomic, copy) NSString *brand; // 品牌
@property (nonatomic, copy) NSString *carport;
@property (nonatomic, copy) NSString *greening_rate;
@property (nonatomic, copy) NSString *covered_area;
@property (nonatomic, copy) NSString *developers;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *completion_date;
@property (nonatomic, copy) NSString *plot_ratio;
@property (nonatomic, copy) NSString *property_fee;
@property (nonatomic, copy) NSString *decoration;
@property (nonatomic, copy) NSString *p_m_company;
@property (nonatomic ,copy) NSString * building_types;
@property (nonatomic ,copy) NSString * building_state;

@end

#pragma mark - 户型信息 户型详情
@interface Huxingxinxi :NSObject
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , copy) NSString              *  ID;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSArray              * picArr;
@property (nonatomic , copy) NSString              * room_office;
@property (nonatomic , copy) NSString              * minareaname;
@property (nonatomic , strong) NSString            * sc_status;

@end
#pragma mark - 户型信息 户型详情 中的推荐

@interface Tuijian :NSObject
@property (nonatomic , copy) NSString              * pic_hx;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * id_hs;
@property (nonatomic , copy) NSString              * room_office;

@end

#pragma mark - 佣金方案  楼盘动态合用 Model

@interface YongJinFA :NSObject
@property (nonatomic , copy) NSString              * commission;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *content;



@end

#pragma mark - 天气

@interface TianQiModel : NSObject

@property (nonatomic ,copy) NSString *weather;  // 啥天

@property (nonatomic ,copy) NSString *temperature; // 温度

@property (nonatomic ,copy) NSDictionary *weather_id;

@end

#pragma mark - 报备成交列表
@interface BaoBeiChengJiao : HomeModel

@property (nonatomic ,copy) NSString *ID;

@property (nonatomic ,copy) NSString *l_name;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic , copy) NSString  * phone;
@property (nonatomic , copy) NSString  * record_id;
@property (nonatomic ,copy) NSString *status;
@property (nonatomic ,copy) NSString *time;



@end

@interface KHGZModel : NSObject

@property (nonatomic ,copy) NSString *developers_rule;
@property (nonatomic ,copy) NSString *look_rule;
@property (nonatomic , copy) NSString  * settle_ac_rule;

@end

#pragma mark - 城市请求 啊啊
@interface City : NSObject

@property (nonatomic ,strong) NSArray *cityAry;
@property (nonatomic ,strong) NSString *provinceName;

@end

@interface cityAry : NSObject

@property (nonatomic ,strong) NSString *cityName;

@end

#pragma mark - 轮播图

@interface Banner : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * extra;
@property (nonatomic , copy) NSString              * type;

@end




