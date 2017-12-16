//
//  HomeTableViewHeaderView.m
//  WWSS
//
//  Created by  海跃尚 on 17/11/2.
//  Copyright © 2017年  海跃尚. All rights reserved.
//

#import "HomeTableViewHeaderView.h"

@interface HomeTableViewHeaderView ()




@end



@implementation HomeTableViewHeaderView



-(void)awakeFromNib {
    
    [super awakeFromNib];    
    NSString * str1 = [[XXHelper currentTime] stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    NSString * str2 = [str1 stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    _date_L.text = [str2 stringByReplacingCharactersInRange:NSMakeRange(10, 9) withString:@"日"];

    _week_L.text = [XXHelper currentWeekString];
    }





@end
