//
//  PersonalDataThird_Cell.m
//  Product
//
//  Created by Sen wang on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonalDataThird_Cell.h"

@implementation PersonalDataThird_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    kUserData;
    
    [[_maleButton rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDictionary * params = @{
                                  @"opt" : @"sex",
                                  kToken: userInfo.token,
                                  @"sex" : @"0"
                                  };
        [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kPersonalServlet withHud:@"性别修改中..." withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            if (code == 200) {
                [XXProgressHUD showSuccess:message];
                [_maleButton setImage:kImageNamed(@"xuanzhong") forState: UIControlStateNormal];
                [_womanButton setImage:kImageNamed(@"weixuanzhong") forState: UIControlStateNormal];
            } else {
                [XXProgressHUD showError:message];

            }
        } withFailuerBlock:^(id error) {
            
        }];
        
        
    }];
    [[_womanButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDictionary * params = @{
                                  @"opt" : @"sex",
                                  kToken: userInfo.token,
                                  @"sex" : @"1"
                                  };
        [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:kPersonalServlet withHud:@"性别修改中..." withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            if (code == 200) {
                [XXProgressHUD showSuccess:message];
                [_womanButton setImage:kImageNamed(@"xuanzhong") forState: UIControlStateNormal];
                [_maleButton setImage:kImageNamed(@"weixuanzhong") forState: UIControlStateNormal];
            } else {
                [XXProgressHUD showError:message];

            }
        } withFailuerBlock:^(id error) {
            
        }];
        
       
    }];
    // Initialization code
}
-(void)setSexType:(NSString *)sexType {
    _sexType = sexType;

    if ([sexType intValue] == 0) {
        [_maleButton setImage:kImageNamed(@"xuanzhong") forState: UIControlStateNormal];
        [_womanButton setImage:kImageNamed(@"weixuanzhong") forState: UIControlStateNormal];

    } else {
        [_womanButton setImage:kImageNamed(@"xuanzhong") forState: UIControlStateNormal];
        [_maleButton setImage:kImageNamed(@"weixuanzhong") forState: UIControlStateNormal];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
