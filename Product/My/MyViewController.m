//
//  ViewController.m
//  经纪人
/**
 Certification_VC * vc = [[Certification_VC alloc]init];
 [self.navigationController pushViewController:vc animated:YES];
*/
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyViewController.h"
#import "MineCollectionViewCell.h"
#import "MineCollectionView.h"
#import "Certification_VC.h"
#import "MainWebViewController.h"
#import "MyPartner_VC.h"
#import "MyInvitationViewController.h"
#import "AdviceViewController.h"
#import "MyCommission_VC.h"
#import "SetupViewController.h"
#import "PersonalData_VC.h"
#import "IntegralMall_VC.h" // 积分商城
#import "MyConcern_VC.h"    // 我的关注

@interface MyViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) MineCollectionView *collectionView;

@property (nonatomic, strong) NSString *jifen;
@property (nonatomic, strong) NSString *GGPic;
@property (nonatomic, strong) NSString *GGUrl;

@end
static NSString *identifier = @"homeCell";

@implementation MyViewController
- (instancetype)init {
    if (self = [super init]) {
    }

    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar
        lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")]];
    [self loadUserInfoData];
    [self setUI];
}
- (void)loadUserInfoData {
    kUserData;
    NSDictionary *dic = [[NSDictionary alloc]
        initWithObjectsAndKeys:@"mine", @"opt", userInfo.token, @"token", nil];
    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"PersonalServlet"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"用户信息 = = %@", objc);
            kInspectSignInType;
            if (code == 200) {
                self.jifen = [NSString stringWithFormat:@"%@", data[@"jifen"][@"integral"]];
                self.GGPic = [NSString stringWithFormat:@"%@", data[@"pic"][@"pic"]];
                self.GGUrl = [NSString stringWithFormat:@"%@", data[@"pic"][@"url"]];
                [self sendView];
                [self threeView];
            } else {
                kShowMessage;
            }
        }
        withFailuerBlock:^(id error){

        }];
}
- (void)viewDidLoad {
    [super viewDidLoad];


    [self fourView];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"个人中心";
    UIButton *attendbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    attendbutton.frame = CGRectMake(0, 0, 45, 30);
    [attendbutton addTarget:self
                     action:@selector(positioningClick)
           forControlEvents:UIControlEventTouchUpInside];
    [attendbutton setTitle:@"签到" forState:UIControlStateNormal];
    attendbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithCustomView:attendbutton];

    UIButton *attendbutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    attendbutton1.frame = CGRectMake(0, 0, 45, 30);
    [attendbutton1 addTarget:self
                      action:@selector(setBtn)
            forControlEvents:UIControlEventTouchUpInside];
    [attendbutton1 setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    attendbutton1.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithCustomView:attendbutton1];
}

- (void)setUI {
    kUserData;
    UIImageView *imageView = [PosTool imageViewWithImageName:@"图层4"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(120);
    }];

    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconButton sd_setImageWithURL:[NSURL URLWithString:userInfo.pic]
                          forState:0
                  placeholderImage:kImageNamed(@"icon")];
    [self.view addSubview:iconButton];
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(imageView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    kViewRadius(iconButton, 60 / 2);
    [iconButton addTarget:self
                   action:@selector(iconButtonAction)
         forControlEvents:UIControlEventTouchUpInside];

    NSString *nameStr = @"昵称";
    if (!kStringIsEmpty(userInfo.name)) {
        nameStr = userInfo.name;
    }
    UILabel *sbuTitleLB = [PosTool labelWithTextColr:@"ffffff"
                                            fontName:@"PingFangSC-Regular"
                                            fontSize:17
                                         defaultText:nameStr];
    [imageView addSubview:sbuTitleLB];
    [sbuTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconButton.mas_right).offset(10);
        make.top.mas_equalTo(iconButton.mas_top).offset(15);
    }];

    UIImageView *LogoView = [PosTool imageViewWithImageName:@"房子"];

    [imageView addSubview:LogoView];
    [LogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sbuTitleLB);
        make.bottom.mas_equalTo(iconButton);
    }];

    

    UILabel *nameLB = [PosTool labelWithTextColr:@"ffffff"
                                        fontName:@"PingFangSC-Regular"
                                        fontSize:15
                                     defaultText:userInfo.m_name];
    [imageView addSubview:nameLB];

    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LogoView.mas_right).offset(5);
        make.centerY.mas_equalTo(LogoView);
    }];
    UIButton *cccButtion = [[UIButton alloc] init];
    cccButtion.backgroundColor = [UIColor clearColor];
    [cccButtion tapPeformBlock:^{
        NSLog(@"点击店铺了");
    }];
    [self.view addSubview:cccButtion];
    cccButtion.sd_layout.leftEqualToView(LogoView)
        .rightEqualToView(LogoView)
        .topEqualToView(nameLB)
        .bottomEqualToView(nameLB);

    UIButton *rechargeBtn = [[UIButton alloc]init];
    if ([userInfo.attestation intValue] == 0) {

        [rechargeBtn setImage:[UIImage imageNamed:@"weishiming"] forState:UIControlStateNormal];
    } else {
        [rechargeBtn setImage:[UIImage imageNamed:@"yishiming"] forState:UIControlStateNormal];
    }

    [rechargeBtn addTarget:self
                    action:@selector(rechargeAction)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechargeBtn];
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(cccButtion);
    }];
}

- (void)iconButtonAction {
    PersonalData_VC *personalDataVC = [[PersonalData_VC alloc] init];
    [self.navigationController pushViewController:personalDataVC animated:YES];
}
- (void)sendView {
    kUserData;
    UIView *_senView = [[UIView alloc] init];
    _senView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_senView];
    [_senView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];

    UILabel *recommendLB =
        [PosTool labelWithTextColr:@"000000"
                          fontName:@"PingFangSC-Regular"
                          fontSize:15
                       defaultText:[NSString stringWithFormat:@"个人推荐码:%@",
                                                              userInfo.zjyqm]];

    [_senView addSubview:recommendLB];
    [recommendLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];

    UIImageView *JUImageView = [PosTool imageViewWithImageName:@"矩形4"];
    [_senView addSubview:JUImageView];
    [JUImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];

    UILabel *integralLB = [PosTool labelWithTextColr:@"000000"
                                            fontName:@"PingFangSC-Regular"
                                            fontSize:15
                                         defaultText:@"积分"];
    [_senView addSubview:integralLB];
    [integralLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JUImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
    }];

    UIButton *numBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [numBT setImage:[UIImage imageNamed:@"youjiantou"] forState:UIControlStateNormal];
    [numBT addTarget:self
                  action:@selector(rechargeAction)
        forControlEvents:UIControlEventTouchUpInside];
    [_senView addSubview:numBT];
    [numBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
    }];

    UILabel *jfLB = [PosTool labelWithTextColr:@"000000"
                                      fontName:@"PingFangSC-Regular"
                                      fontSize:15
                                   defaultText:self.jifen];
    [_senView addSubview:jfLB];
    [jfLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(numBT.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
    }];

    UIImageView *numImage1 = [PosTool imageViewWithImageName:@"Integral"];
    [_senView addSubview:numImage1];
    [numImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(jfLB.mas_left).offset(-5);
        make.centerY.mas_equalTo(0);
    }];

    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_senView addSubview:pushButton];

    [pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numImage1);
        make.right.equalTo(_senView);
        make.height.equalTo(@50);
        make.centerY.equalTo(numImage1);
    }];
    kWeakSelf;
    [[pushButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {

            IntegralMall_VC *vc = [IntegralMall_VC viewControllerFromNib];

            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    UIImageView *numImage = [PosTool imageViewWithImageName:@"矩形4"];
    [_senView addSubview:numImage];
    [numImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

- (void)threeView {

    UIButton *threeimage = [[UIButton alloc] init];
    [self.view addSubview:threeimage];
    [threeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(170);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(75);
    }];
    UIButton *ljxq = [[UIButton alloc] init];
    [ljxq setImage:kImageNamed(@"liaojiexiangqing") forState:UIControlStateNormal];
    [ljxq sizeToFit];
    [ljxq addTarget:self
                  action:@selector(toGGWebView)
        forControlEvents:UIControlEventTouchUpInside];
    [threeimage addSubview:ljxq];
    [ljxq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(threeimage.mas_centerY);
        make.right.equalTo(@-30);
    }];

    [threeimage sd_setImageWithURL:[NSURL URLWithString:self.GGPic] forState:0];
    threeimage.contentMode = UIViewContentModeScaleAspectFill;
    threeimage.clipsToBounds = YES;
    [threeimage addTarget:self
                   action:@selector(toGGWebView)
         forControlEvents:UIControlEventTouchUpInside];
}
- (void)toGGWebView {
    MainWebViewController *VC = [[MainWebViewController alloc] init];
    VC.urlString = self.GGUrl;
    VC.navigationItem.title = @"合作推广";
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)fourView {
    int hhh = 90;
    if (kiPhone5s) {
        hhh = 70;
    }
    self.collectionView = [MineCollectionView getViewWithNumberOfCols:5
                                                              panding:16
                                                               margin:13
                                                            rowMargin:25
                                                            topMargin:15
                                                           itemHeight:hhh
                                                             delegate:self
                                                           dataSource:self];
    [self.view addSubview:self.collectionView];
    _collectionView.scrollEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MineCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:identifier];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(275);
        make.bottom.mas_equalTo(0);
    }];
}

//签到
- (void)positioningClick {

    MainWebViewController *vc = [[MainWebViewController alloc] init];
    vc.navigationItem.title = @"签到领积分";
    kUserData;
    NSString *strToken = [userInfo.token stringByReplacingOccurrencesOfString:@"|" withString:@","];

    vc.urlString = kString(@"http://121.43.176.154:8080/h5/signPage.html?token=%@", strToken);
    [(YMNavgatinController *) self.navigationController
        pushViewController:vc
                      type:YMNavgatinControllerTypeBlue
                  animated:YES];
}

//设置
- (void)setBtn {

    SetupViewController *vc = [[SetupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark collectionView data source delegate
#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    kUserData;
    return [userInfo.status intValue] == 1 ? 5 : 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MineCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    kUserData;
    NSArray *imageNameArray = @[
        @"我的佣金", @"我的伙伴", @"积分商城", @"我的关注", @"我的邀请",
        @"联系客服", @"帮助反馈"
    ];

    NSArray *titleArray = @[
        @"我的佣金", @"我的伙伴", @"积分商城", @"我的关注", @"我的邀请",
        @"联系客服", @"帮助反馈"
    ];

    if ([userInfo.status intValue] == 1) { /// 游客
        imageNameArray = @[ @"积分商城", @"我的关注", @"我的邀请", @"联系客服", @"帮助反馈" ];
        titleArray = @[ @"积分商城", @"我的关注", @"我的邀请", @"联系客服", @"帮"
                                                                                            @"助反"
                                                                                            @"馈" ];
    }
    [cell setupWithImageName:imageNameArray[indexPath.item] title:titleArray[indexPath.item]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", indexPath.item);

    int yyy = (int) indexPath.item;
    UIViewController *vc = nil;
    kUserData;
    if ([userInfo.status intValue] == 1) {
        yyy += 2;
    }
    if (yyy == 0) {
        vc = [[MyCommission_VC alloc] init];

    } else if (yyy == 1) {
        vc = [[MyPartner_VC alloc] init];

    } else if (yyy == 2) {
        vc = [IntegralMall_VC viewControllerFromNib];

    } else if (yyy == 3) {
        vc = [[MyConcern_VC alloc] init];

    } else if (yyy == 4) {
        vc = [[MyInvitationViewController alloc] init];

    } else if (yyy == 5) {
        // MARK: ------ 联系客服 ------
        [XXHelper makePhoneCallWithTelNumber:@"10010"];
    }else{
            vc = [[AdviceViewController alloc] init];
    }

    if(vc){
        [self.navigationController pushViewController:vc animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }

}



#pragma mark -  实名认证
-(void)rechargeAction{
    kUserData;
    if ([userInfo.attestation intValue] == 0) { // 未认证

    Certification_VC * vc = [[Certification_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
