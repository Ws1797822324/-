//
//  HomeTableViewHeaderView.h
//  WWSS
//
//  Created by  海跃尚 on 17/11/2.
//  Copyright © 2017年  海跃尚. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ADRollView.h"

@interface HomeTableViewHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *advertisementView;

// 滚动广告   热点资讯
@property (weak, nonatomic) IBOutlet UIView *adRollView;
// 位置
@property (weak, nonatomic) IBOutlet UILabel *position_L;
@property (weak, nonatomic) IBOutlet UIButton *chooseCityButton;
// 周
@property (weak, nonatomic) IBOutlet UILabel *week_L;
// 日期
@property (weak, nonatomic) IBOutlet UILabel *date_L;
// 附近楼盘
@property (weak, nonatomic) IBOutlet UILabel *nearbyProperties_L;
// 一键查看
@property (weak, nonatomic) IBOutlet UIButton *quick_Btn;
// 天气
@property (weak, nonatomic) IBOutlet UIButton *weather_ImgV;
@property (weak, nonatomic) IBOutlet UIButton *weather_text;
@property (weak, nonatomic) IBOutlet UIButton *temperature;

// 全部楼盘
@property (weak, nonatomic) IBOutlet UIButton *allPropertiesBtn;
// 周边楼盘
@property (weak, nonatomic) IBOutlet UIButton *aroundPropertiesBtn;
// 报备客户
@property (weak, nonatomic) IBOutlet UIButton *BBKHBtn;
// 报备成交
@property (weak, nonatomic) IBOutlet UIButton *BBCJBtn;
// 房贷计算器
@property (weak, nonatomic) IBOutlet UIButton *FDJSQBtn;

@end
