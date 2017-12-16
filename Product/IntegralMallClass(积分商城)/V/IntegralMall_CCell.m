//
//  IntegralMall_CCell.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IntegralMall_CCell.h"

@implementation IntegralMall_CCell

- (void)awakeFromNib {
    kViewRadius(self.exchangeBtn, 4);
    [super awakeFromNib];

    //        PromptView * tempView = [PromptView viewFromXib];
//        kViewRadius(tempView, 5);
//        kViewRadius(_image_View, 5);
//        KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
//
//        KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter));
//
//    //        [popView showWithLayout:popLayout];

        // Initialization code
}
-(void)setModel:(IntegralMall_Model *)model {
    _model = model;
    _exchangeBtn.tag = [model.ID integerValue];
    _jifenL.text = model.present_points;
    [_numButton setTitle:model.present_points forState:UIControlStateNormal];
    [_image_View sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:kImageNamed(@"background_12")];
    [_image_View zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
}
- (IBAction)duiHuan:(UIButton *)sender {

    [LBXAlertAction showAlertWithTitle:[NSString stringWithFormat:@"花费%@积分兑换该商品",_jifenL.text] msg: nil buttonsStatement:@[@"确定",@"取消"] chooseBlock:^(NSInteger buttonIdx) {

        if (buttonIdx == 0) {
            kUserData;
            NSDictionary * dic = @{
                                   kOpt : @"exchange",
                                   kToken : userInfo.token,
                                   @"id" : kString(@"%ld", sender.tag),
                                   };

            [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:@"兑换商品" withProgressBlock:^(float requestProgress) {

            } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                NSLog(@"dddddd - %@",objc);
                kInspectSignInType;
                kShowMessage;
                if (code == 200) {
                    [LBXAlertAction showAlertWithTitle:@"兑换成功" msg:nil buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {


                    }];
                }
                if (code == 201) {
                    [LBXAlertAction showAlertWithTitle:@"兑换失败" msg:@"去努力工作积累积分吧" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                    }];
                }

                if (code == 202) {
                    [LBXAlertAction showAlertWithTitle:@"积分不足" msg:@"去努力工作积累积分吧" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                    }];
                }

                if (code == 203) {
                    [LBXAlertAction showAlertWithTitle:@"礼品不存在" msg:@"您来晚啦" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                    }];


                }


            } withFailuerBlock:^(id error) {

            }];
        }
    }];

}



@end
