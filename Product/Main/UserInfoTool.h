//
//  UserInfoTool.h
//  Product
//
//  Created by Sen wang on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface UserInfoTool : NSObject


/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(UserInfo *)account;


/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (UserInfo *)account;

@end
