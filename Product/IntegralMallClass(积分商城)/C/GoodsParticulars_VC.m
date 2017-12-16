//
//  GoodsParticulars_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GoodsParticulars_VC.h"

@interface GoodsParticulars_VC ()
@property (nonatomic ,strong) GoodsModel *goodsModel;

@property (weak, nonatomic) IBOutlet UIImageView *img_View;
@property (weak, nonatomic) IBOutlet UILabel *goods_nameL;
@property (weak, nonatomic) IBOutlet UIButton *jifen_Btn;
@property (weak, nonatomic) IBOutlet UILabel *miaoshu_L;
@property (weak, nonatomic) IBOutlet UILabel *lj_time_L;
@property (weak, nonatomic) IBOutlet UILabel *address_L;
@property (weak, nonatomic) IBOutlet XXTextView *textView;
- (IBAction)duihuanButton:(UIButton *)sender;
@end

@implementation GoodsParticulars_VC


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kUserData;
    NSDictionary * dic = @{
                           kOpt : @"details",
                           @"id"  : _ID,
                           kToken : userInfo.token,

                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:@"数据刷新" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@"想看看看 %@",objc);
        if (code == 200) {
            _goodsModel = [GoodsModel mj_objectWithKeyValues:data];
            [_img_View sd_setImageWithURL:[NSURL URLWithString:_goodsModel.pic] placeholderImage:kImageNamed(@"erji")];
            [_jifen_Btn setTitle:_jifen forState:UIControlStateNormal];
            _goods_nameL.text = _goodsModel.name;
            _miaoshu_L.text = _goodsModel.delails;
            _lj_time_L.text = kString(@"领奖时间: %@",  _goodsModel.time);
            _address_L.text =   kString(@"领奖地点: %@", _goodsModel.dizhi);
        }
    } withFailuerBlock:^(id error) {

    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _textView.xx_placeholder =@"输入您的地址";
    _textView.xx_placeholderColor = kRGB_HEX(0x969696);
    self.navigationItem.title = @"商品详情";

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)duihuanButton:(UIButton *)sender {

    [LBXAlertAction showAlertWithTitle:[NSString stringWithFormat:@"花费%@积分兑换该商品",_jifen] msg: nil buttonsStatement:@[@"确定",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
        if (buttonIdx == 0) {
            kUserData;
            NSDictionary * dic = @{
                                   kOpt : @"exchange",
                                   kToken : userInfo.token,
                                   @"id" : _ID,
                                   @"address" : _textView.text

                                   };

            [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:@"兑换商品" withProgressBlock:^(float requestProgress) {

            } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
                NSLog(@"dddddd - %@",objc);
                kInspectSignInType;

                if (code == 200) {
                    [LBXAlertAction showAlertWithTitle:@"兑换成功" msg:nil buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                    }];
                }
                if (code == 201) {
                    [LBXAlertAction showAlertWithTitle:@"兑换失败" msg:@"去努力工作积累积分吧" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                    }];
                }

                if (code == 202) {
                    PromptView * tempView = [PromptView viewFromXib];
                    tempView.width = kWidth * 0.8;
                    tempView.height = kWidth * 0.8;
                            kViewRadius(tempView, 5);

                    KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];

                            KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter));

                               [popView showWithLayout:popLayout];

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
