//
//  ThreePartiesShareTools.h
//  EasyCarToBuy
//
//  Created by HJ on 2017/9/27.
//  Copyright © 2017年 HYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreePartiesShareTools : NSObject

+ (void)ShareToWXWith:(NSString *)title descri:(NSString *)destriString url:(NSString *)url img:(UIImage *)img;

+ (void)ShareToWXZoneWith:(NSString *)title descri:(NSString *)destriString url:(NSString *)url img:(UIImage *)img;

+ (void)ShareQQ:(NSString *)title descri:(NSString *)des url:(NSString *)url imgUrl:(NSString *)imgurl;

+ (void)ShareQQZone:(NSString *)title descri:(NSString *)des url:(NSString *)url  imgUrl:(NSString *)imgurl;

+ (void)ShareWBTitle:(NSString *)title url:(NSString *)url scope:(NSString *)sco imgData:(NSData *)imgdata;

//+ (void)shareToAilPayWithTitle:(NSString *)title url:(NSString *)url des:(NSString *)des imgUrl:(NSString *)imgUrl type:(int)type;

@end
