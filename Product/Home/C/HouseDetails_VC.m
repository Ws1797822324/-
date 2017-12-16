//
//  HouseDetails_VCViewController.m
//  Product
//
//  Created by Sen wang on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseDetails_VC.h"

#import "LookImgArrayViewController.h" // 大图查看图片
#import "HouseDetailsOne_Cell.h"
#import "PropertiesDetails_SellAdvantage.h"
#import "RecommendProperties_CCell.h"

#import "HouseDetailsBBBB_VC.h"

@interface HouseDetails_VC () <SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) UILabel *imgNameL;
@property (nonatomic, strong) UILabel *imgNumL;
@property (nonatomic, strong) NSMutableArray *imagesURLStrings;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger footeViewHeight;

@property (nonatomic ,strong) Huxingxinxi *xqModel;
@property (nonatomic ,strong) NSArray *tjArr;

@property (nonatomic, strong) NSString * item1Str;

@end

@implementation HouseDetails_VC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = NO;



    _imagesURLStrings = [NSMutableArray array];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")] WithScrollView:scrollView AndValue:0.1];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.navigationController.navigationBar lt_reset];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.item1Str = @"yiguanzhu";
    
    [self configTableview];
    [self requestData];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 户型详情里面的请求 在售户型

- (void)requestData {
    kUserData;
    kWeakSelf;
    NSDictionary *parmas = @{
        kOpt : @"huxingxiangqing",
        kToken : userInfo.token,
        @"id" : _wuId,
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:parmas
        withUrlString:@"Houses"
        withHud:@"刷新信息..."
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {


            if (code == 200) {
                _xqModel = [Huxingxinxi mj_objectWithKeyValues: data[@"huxingxinxi"]];
                _tjArr = [Tuijian mj_objectArrayWithKeyValuesArray:data[@"tuijian"]];
                NSLog(@"%@",_xqModel.minareaname);

                for (Pic * mm in _xqModel.picArr) {
                    [_imagesURLStrings addObject:mm.picurl];
                    
                }
                
                if (_tjArr.count >1) {
                    _footeViewHeight = 150 * _tjArr.count  * 0.5;
                    
                } else {
                    _footeViewHeight = 150 ;
                }
                
                [weakSelf.tableview reloadData];
                
                if ([_xqModel.sc_status intValue] == 0) {  // 未关注
                    self.item1Str = @"guanzhu";
                }
                UIBarButtonItem * item1 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(self.item1Str) highImage:kImageNamed(self.item1Str) target:self action:@selector(itemGButtonAction) withTitle:@""];
                UIBarButtonItem * item2 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"fenxiang") highImage:kImageNamed(@"fenxiang") target:self action:@selector(itemFButtonAction) withTitle:@""];
                self.navigationItem.rightBarButtonItems = @[item2,item1];
                
            }

        }
        withFailuerBlock:^(id error){

        }];
}
#pragma mark -------- 关注
-(void) itemGButtonAction {
    NSLog(@"关注按钮");
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"attention",@"opt",self.wuId,@"l_id",@"2",@"type",userInfo.token,@"token", nil];
    NSDictionary * deleDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"gz_delete",@"opt",self.wuId,@"l_id",@"2",@"type",userInfo.token,@"token", nil];
    

    if([self.item1Str isEqualToString:@"guanzhu"]){
        [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:nil withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            
            if (code==200) {
                [XXProgressHUD showSuccess:message];
                self.item1Str = @"yiguanzhu";
                UIBarButtonItem * item1 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(self.item1Str) highImage:kImageNamed(self.item1Str) target:self action:@selector(itemGButtonAction) withTitle:@""];
                UIBarButtonItem * item2 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"fenxiang") highImage:kImageNamed(@"fenxiang") target:self action:@selector(itemFButtonAction) withTitle:@""];
                self.navigationItem.rightBarButtonItems = @[item2,item1];
            }else{
                kShowMessage;
            }
        } withFailuerBlock:^(id error) {
            
        }];
    }else{
        [XXNetWorkManager requestWithMethod:POST withParams:deleDic withUrlString:@"OperateServlet" withHud:nil withProgressBlock:^(float requestProgress) {
            
        } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            
            if (code==200) {
                [XXProgressHUD showSuccess:message];
                self.item1Str = @"guanzhu";
                UIBarButtonItem * item1 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(self.item1Str) highImage:kImageNamed(self.item1Str) target:self action:@selector(itemGButtonAction) withTitle:@""];
                UIBarButtonItem * item2 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"fenxiang") highImage:kImageNamed(@"fenxiang") target:self action:@selector(itemFButtonAction) withTitle:@""];
                self.navigationItem.rightBarButtonItems = @[item2,item1];
            }else{
                kShowMessage;
            }
        } withFailuerBlock:^(id error) {
            
        }];
    }
    
}
#pragma mark --------- 分享
-(void) itemFButtonAction {

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sms)]];
    // 显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        if (platformType == 13) {
            MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
            // 设置短信内容
            vc.body = kString(@"http://121.43.176.154:8080/h5/recommendInfoDetail.html?ids=%@", _wuId);
            // 设置收件人列表
            vc.recipients = @[];  // 号码数组
            // 设置代理
            vc.messageComposeDelegate = self;
            // 显示控制器

            UIBarButtonItem * btn = [UIBarButtonItem rightbarButtonItemWithNorImage:nil highImage:nil target:self action:@selector(duanxinAction) withTitle:@"取消"];
            [[[vc viewControllers] lastObject] navigationItem].rightBarButtonItem = btn;
            [self presentViewController:vc animated:YES completion:nil];

        } else {

        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //创建图片内容对象

        //如果有缩略图，则设置缩略图
        UIImage * thumimage =kImageNamed(@"logo");
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"户型分享" descr:nil thumImage:thumimage];


        shareObject.webpageUrl = kString(@"http://121.43.176.154:8080/h5/recommendInfoDetail.html?ids=%@", _wuId);
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;

        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);

                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }

    }];

}


-(void) duanxinAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}
- (void)configTableview {

    self.tableview.backgroundColor = kAllRGB;

    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(-kNavHeight);
        make.bottom.equalTo(self.view).offset(0);
    }];

    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HouseDetailsOne_Cell class]) bundle:nil]
         forCellReuseIdentifier:@"HouseDetailsOne_Cell_ID"];

}


- (void)configImageView:(UIView *)view {

    self.navigationItem.title = @"在售户型";

    SDCycleScrollView *cycleScrollView =
        [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth / 2)
                                           delegate:self
                                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
    cycleScrollView.autoScroll = NO;
    cycleScrollView.delegate = self;
    cycleScrollView.firstIndex = 0;
    cycleScrollView.pageControlType = YES;
    [view addSubview:cycleScrollView];
    self.scrollView = cycleScrollView;

    self.imgNameL = [[UILabel alloc] init];

    self.imgNumL = [[UILabel alloc] init];

    [view addSubview:self.imgNameL];
    [view addSubview:self.imgNumL];

    [_imgNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-15);
        make.left.equalTo(view.mas_left).offset(20);
    }];
    [_imgNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-15);
        make.right.equalTo(view).offset(-30);
    }];
    _imgNameL.textColor = [UIColor whiteColor];
    _imgNumL.backgroundColor = kRGBColor(152, 152, 152, 0.8);
    _imgNumL.textColor = [UIColor whiteColor];
    _imgNumL.font = kFont(20);
    _imgNameL.font = kFont(17);
    kViewRadius(_imgNumL, 12);
    _imagesURLStrings.count == 0 ? (_imgNumL.hidden = YES) : (_imgNumL.hidden = NO);
    _imagesURLStrings.count == 0 ? (_imgNameL.hidden = YES) : (_imgNameL.hidden = NO);

    int  nStr =  0;
    _imagesURLStrings.count == 0 ? ( nStr =   0) :  (nStr =  (int)cycleScrollView.firstIndex + 1);
    self.imgNumL.text = [NSString stringWithFormat:@"  %d/%d  ",nStr,(int)_imagesURLStrings.count];

    self.imgNumL.text =
        [NSString stringWithFormat:@"  %d/%d  ",nStr, (int) _imagesURLStrings.count];
    self.imgNameL.text = _xqModel.minareaname;
}

#pragma mark--- SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long) index);

    LookImgArrayViewController *VC = [[LookImgArrayViewController alloc] init];
    VC.imgArray =  self.imagesURLStrings;
    VC.num = index + 1;
    VC.myClick = ^(int num) {

        [self.scrollView.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:num - 1 inSection:0]
                                         atScrollPosition:UICollectionViewScrollPositionNone
                                                 animated:YES];

    };
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5; //  时间
    animation.type = @"kCATransitionFade";
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:VC
                       animated:NO
                     completion:^{
                     }];
}
// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.imgNumL.text = [NSString stringWithFormat:@"  %d/%d  ", (int) index + 1, (int) self.imagesURLStrings.count];
}

#pragma mark-- UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 0;
    }
     else {

        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        HouseDetailsOne_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseDetailsOne_Cell_ID"];
        [self configImageView:cell.toolView1];

        cell.model = _xqModel;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
      else {

        return [UITableViewCell new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 265;
    }



    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    }

    if (section == 1) {
        UIView * v1 = [[UIView alloc]init];
        v1.backgroundColor = [UIColor whiteColor];
        v1.frame =CGRectMake(0, 0, kWidth, 90);
        UIButton *button = [[UIButton alloc] init];
        button.userInteractionEnabled = NO;
        [button setImage:kImageNamed(@"background_14") forState:0];
        [button sizeToFit];
        button.x = 20;
        button.y = 15;
        [v1 addSubview:button];
        return v1;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }
    if (section == 1) {
        return 90;
    }
    if (section == 2) {
        return 100;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 1) {
        UIView *View = [[UIView alloc] init];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        View.backgroundColor = [UIColor redColor];
        _collectionView =
            [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _footeViewHeight) collectionViewLayout:layout];
        layout.itemSize = CGSizeMake((kWidth)/2, 150);

        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        View.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.collectionViewLayout = layout;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendProperties_CCell class])
                                                    bundle:nil]
            forCellWithReuseIdentifier:@"RecommendProperties_CCell_ID"];
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, _footeViewHeight);
        View.frame = CGRectMake(0, 0, kWidth, _footeViewHeight);
        [View addSubview:_collectionView];

        return View;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 1) {

        return _footeViewHeight;
    } else {
        return 0.001;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tjArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommendProperties_CCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendProperties_CCell_ID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.tuijianModel = _tjArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


    HouseDetailsBBBB_VC * vc = [[HouseDetailsBBBB_VC alloc]init];

    vc.wuId = [_tjArr[indexPath.row] id_hs];
    [(YMNavgatinController *)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeClear  animated:true];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
