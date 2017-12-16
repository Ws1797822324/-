//
//  PropertiesDetails_VC.m
//  Product
//
//  Created by  海跃尚 on 17/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetails_VC.h"

#import "PropertiesDetails_HeaderCell.h"
#import "PropertiesDetails_HeaderTimeCell.h"
#import "PropertiesDetails_ChoiceCell.h"
#import "PropertiesDetails_ImportantCell.h"
#import "PropertiesDetails_SellAdvantage.h"
#import "RecommendProperties_CCell.h"
#import "MapViewController.h"
#import "HouseData_TVC.h"
#import "PropertiesDetails_FootView.h"
#import "ReportedPeopleViewController.h"
#import "HouseDetails_VC.h"
#import "MD_Cell.h"
#import <MessageUI/MessageUI.h>

#import "BrokeragePlan_VC.h" /// 佣金方案
#import "HouseDynamic_TVC.h"  /// 楼盘动态

#import "PropertiesDetailsBBBB_VC.h"

#import "LookImgArrayViewController.h"  // 大图查看图片

@interface PropertiesDetails_VC () <SDCycleScrollViewDelegate, UICollectionViewDelegate,buttonActionDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton * buttonImg;
@property (nonatomic, strong) UILabel * imgNameL;

@property (nonatomic, strong) UILabel * imgNumL;

@property (nonatomic, strong) NSMutableArray * imagesURLStrings;

@property (nonatomic, strong) SDCycleScrollView * scrollView;

@property(nonatomic, strong) UICollectionView * collectionView;

@property(nonatomic, assign) NSInteger footeViewHeight;

@property (nonatomic ,strong) PropertiesDetails_Model *PDmodel;
@property (nonatomic ,strong) NSMutableArray *tagsArr; //  标签
@property (nonatomic ,assign) int mdType;
@property (nonatomic ,strong) NSMutableArray *mdArray;
@property (nonatomic ,strong) NSMutableArray *mdArr;

@property (nonatomic ,strong) PropertiesDetails_SellAdvantage * sellView ;

@property (nonatomic, strong) NSString * item1Str;

@end

@implementation PropertiesDetails_VC

-(UIButton *)buttonImg {
    if (!_buttonImg) {
        _buttonImg = [[UIButton alloc]init];
        _buttonImg.userInteractionEnabled = NO;
        [_buttonImg setImage:kImageNamed(@"background_6") forState:0];
        [_buttonImg sizeToFit];
        _buttonImg.x = 15;
        _buttonImg.y = 2;
    }
    return _buttonImg;
}

- (PropertiesDetails_SellAdvantage*)sellView{
    if (!_sellView) {
        _sellView = [PropertiesDetails_SellAdvantage viewFromXib];
        _sellView.delegate = self;
        [_sellView buttonColor:1];
    }
    return _sellView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.item1Str = @"yiguanzhu";
    [self configTableview];

    [self requestData];

}
#pragma mark -------- 关注
-(void) itemGButtonAction {
    NSLog(@"关注按钮");
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"attention",@"opt",self.houseID,@"l_id",@"1",@"type",userInfo.token,@"token", nil];
    NSDictionary * deleDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"gz_delete",@"opt",self.houseID,@"l_id",@"1",@"type",userInfo.token,@"token", nil];
    
    NSString * url = [NSString stringWithFormat:@"%@OperateServlet",kBaseURL];
    if([self.item1Str isEqualToString:@"guanzhu"]){
        [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
            
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
        [XXNetWorkManager requestWithMethod:POST withParams:deleDic withUrlString:url withHud:nil withProgressBlock:^(float requestProgress) {
            
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
            vc.body = kString(@"http://121.43.176.154:8080/h5/recommendInfoDetail.html?ids=%@", _houseID);

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
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"楼盘分享" descr:nil thumImage:thumimage];


            shareObject.webpageUrl = kString(@"http://121.43.176.154:8080/h5/recommendInfoDetail.html?ids=%@", _houseID);
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:kImageNamed(@"background_Nav")] WithScrollView:scrollView AndValue:0.1];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];


    self.mdType = 0;
    _mdArray = [NSMutableArray array];

    _mdArr = [Md mj_objectArrayWithKeyValuesArray:@[@{@"type" : @"", @"content" : @"暂时未知"},@{@"type" : @"", @"content" : @"暂时未知"},@{@"type" : @"", @"content" : @"暂时未知"},@{@"type" : @"", @"content" : @"暂时未知"}]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

-(void)configTableview {

    kWeakSelf;
    [self.view addSubview: weakSelf.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(-kNavHeight);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    PropertiesDetails_FootView * footView = [PropertiesDetails_FootView viewFromXib];
    [self.view addSubview:footView];
    [[footView.phoneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [XXHelper makePhoneCallWithTelNumber:_PDmodel.phone];
        #pragma mark - 拨打电话
    }];

    [[footView.baoBeiButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"详情页面报备客户");
        ReportedPeopleViewController * vc = [[ReportedPeopleViewController alloc]init];

        [(YMNavgatinController *)weakSelf.navigationController pushViewController:vc type:YMNavgatinControllerTypeBlue animated:YES];
    }];
#pragma mark - 跳转微信
    [[footView.weChatButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _PDmodel.weixinid;

        [LBXAlertAction showAlertWithTitle:@"跳转到微信" msg:kString(@"微信ID %@", _PDmodel.weixinid) buttonsStatement:@[@"跳转",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
            if (buttonIdx == 0) {
                NSString *str =@"weixin://qr/JnXv90fE6hqVrQOU9yA0";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }];
    }];
    footView.sd_layout
    .topSpaceToView(self.tableview,0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PropertiesDetails_HeaderCell class]) bundle:nil] forCellReuseIdentifier:@"PropertiesDetails_HeaderCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PropertiesDetails_HeaderTimeCell class]) bundle:nil] forCellReuseIdentifier:@"PropertiesDetails_HeaderTimeCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PropertiesDetails_ChoiceCell class]) bundle:nil] forCellReuseIdentifier:@"PropertiesDetails_ChoiceCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PropertiesDetails_ImportantCell class]) bundle:nil] forCellReuseIdentifier:@"PropertiesDetails_ImportantCell_ID"];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MD_Cell class]) bundle:nil] forCellReuseIdentifier:@"MDCell_ID"];

    
}
-(void)configImageView:(UIView*)view {
    
    self.navigationItem.title = @"楼盘详情";
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth / 2) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
    cycleScrollView.autoScroll = NO;

    cycleScrollView.delegate = self;

    cycleScrollView.pageControlType = YES;
    [view addSubview:cycleScrollView];

    cycleScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.scrollView = cycleScrollView;
    
    self.imgNameL = [[UILabel alloc] init];
    
    self.imgNumL = [[UILabel alloc] init];
    
    [view addSubview:self.imgNameL];
    [view addSubview:self.imgNumL];
    
    [_imgNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.left.equalTo(view.mas_left).offset(20);
    }];
    [_imgNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.right.equalTo(view).offset(-30);
    }];
    _imgNameL.textColor = [UIColor whiteColor];
    _imgNumL.backgroundColor = kRGBColor(152, 152, 152, 0.8);
    _imgNumL.textColor = [UIColor whiteColor];
    _imgNumL.font = kFont(20);
    _imgNameL.font = kFont(20);
    kViewRadius(_imgNumL, 12);
    _imagesURLStrings.count == 0 ? (_imgNumL.hidden = YES) : (_imgNumL.hidden = NO);
    _imagesURLStrings.count == 0 ? (_imgNameL.hidden = YES) : (_imgNameL.hidden = NO);

    int  nStr =  0;
    _imagesURLStrings.count == 0 ? ( nStr =   0) :  (nStr =  (int)cycleScrollView.firstIndex + 1);

    self.imgNumL.text = [NSString stringWithFormat:@"  %d/%d  ",nStr,(int)_imagesURLStrings.count];
    self.imgNameL.text = _PDmodel.name;

}

#pragma mark  --- SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    LookImgArrayViewController * VC = [[LookImgArrayViewController alloc] init];
    VC.imgArray = (NSMutableArray *)self.imagesURLStrings;
    VC.num = index + 1;
    VC.myClick=^(int num){

        [self.scrollView.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:num - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

    
    };
    CATransition * animation = [CATransition animation];
    animation.duration = 0.5;    //  时间
    animation.type = @"kCATransitionFade";
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:VC animated:NO completion:^{
    }];
}
// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.imgNumL.text = [NSString stringWithFormat:@"  %d/%d  ",(int)index + 1,(int)self.imagesURLStrings.count];


}



#pragma mark -- UITableViewDelegate,UITableViewDataSource 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } else if(section == 1 || section == 2) {
    
        return 1;
    } else if (section == 5) {   // section === 5 站位区
            return 0;
        }
    else if (section == 3) {
        return _PDmodel.hxArr.count;
    }
    else {

        return 1;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PropertiesDetails_HeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PropertiesDetails_HeaderCell_ID"];
            NSString * str1 = @"";
            [_PDmodel.price_min_s intValue ] == 0 ? (str1 = @"价格待定") : (str1 = kString(@"%@元左右/㎡", _PDmodel.price_min_s));
            kStringIsEmpty(_PDmodel.price_min_s) ? str1 = @"价格待定" : (str1 = kString(@"%@元左右/㎡", _PDmodel.price_min_s));

            cell.price_L.text = str1;
            [cell cinfigTagsView:_tagsArr];
            [self configImageView:cell.imageViewTool];
            
            return cell;
   
        } else {

            PropertiesDetails_HeaderTimeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"PropertiesDetails_HeaderTimeCell_ID"];
            
            cell.address_L.text = _PDmodel.address;
            cell.open_Time_L.text = kStringIsEmpty(_PDmodel.open_time) ? @"待定" : _PDmodel.open_time;
            XXLog(@"kkkkkl - %@",_PDmodel.open_time);
            XXLog(@"kkkkkl  2 - %@",_PDmodel.he_time);
            XXLog(@"kkkkkl  3 - %@",_PDmodel.end_time);
            NSString * str1 = _PDmodel.he_time;
            NSString * str2 = _PDmodel.end_time;
            if (kStringIsEmpty(str1) || (kStringIsEmpty(str2))) {
                cell.teamwork_Time.text = @"待定";
            } else {
                cell.teamwork_Time.text =[NSString stringWithFormat:@"%@-%@",str1,str2];;
            }
            return cell;
        }
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        PropertiesDetails_ChoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PropertiesDetails_ChoiceCell_ID"];
        [cell configData:indexPath.section faNum:_PDmodel.exe_yj dtNum:_PDmodel.exe_dttj];
        return cell;
    } else if (indexPath.section == 3) {
        
        PropertiesDetails_ImportantCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PropertiesDetails_ImportantCell_ID"];
        cell.hxModel = _PDmodel.hxArr[indexPath.row];
        return cell;
    }

    else {

        MD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDCell_ID"];
        Md * dic = _mdArr[_mdType];
        cell.md_Label.text =dic.content;

        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    } else if (section == 3) {
        return 50.f;
    } else if (section == 4) {
        return 85.f;
    } else if (section == 5) {
        return 100;
    } else if (section == 1 || section == 2)
    {
        kUserData;
        if ([userInfo.status intValue]==1) {
            return 0;
        } else {
            return 10;
        }
    }
    else {

        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [UIView new];
    } else if (section == 3) {
        UIView *tempView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        tempView.backgroundColor = kRGB_HEX(0xF3F3F3);
        [tempView1 addSubview:tempView];
        tempView1.backgroundColor = [UIColor whiteColor];
        UILabel * label1= [[UILabel alloc]initWithFrame:CGRectMake(20, 13, kWidth, 34)];
        label1.text =  @"在售户型";
        [tempView1 addSubview:label1];
        return tempView1;
    } else if (section == 4) {
        UIView *tempView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 85)];
        [tempView1 addSubview:self.sellView];
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        tempView.backgroundColor = kRGB_HEX(0xF3F3F3);
        [self.sellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.height.mas_equalTo(35);
        }];
        [tempView1 addSubview:tempView];
        tempView1.backgroundColor = [UIColor whiteColor];
        UILabel * label1= [[UILabel alloc]initWithFrame:CGRectMake(20, 13, kWidth, 34)];
        label1.text =  @"楼盘卖点";
        [tempView1 addSubview:label1];
        return tempView1;
    }
    if (section == 5) {
        return self.buttonImg;
    }else {

        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        tempView.backgroundColor = kRGB_HEX(0xF3F3F3);
        return tempView;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 5) {
        UIView * View = [[UIView alloc]init];
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        View.backgroundColor = [UIColor whiteColor];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) collectionViewLayout:layout];
        layout.itemSize = CGSizeMake((kWidth)/2, 150);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        View.backgroundColor =[UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.collectionViewLayout = layout;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendProperties_CCell class]) bundle:nil] forCellWithReuseIdentifier:@"RecommendProperties_CCell_ID"];
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, _footeViewHeight);
        View.frame = CGRectMake(0, 0, kWidth, _footeViewHeight);
        [View addSubview:_collectionView];
        return View;
    } else {
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 5) {
        return _footeViewHeight;
    }
    else {
        return 0.001;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {

        if (_tagsArr.count == 0) {
            return 240;
        }
       CGFloat tagsH =  [SQButtonTagView returnViewHeightWithTagTexts:_tagsArr viewWidth:kWidth - 40 eachNum:0 Hmargin:10 Vmargin:5 tagHeight:20 tagTextFont:kBoldFont(12)];
        return 240 + 10 + tagsH;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 110;
    }
    if (indexPath.section == 1 || indexPath.section == 2) {
        kUserData;
        if ([userInfo.status intValue]==1) {  // 游客
            return 0.000001;
        } else {

            return   44.f;
        }
    }
     if (indexPath.section == 3) {
         return 100;
    }
    if (indexPath.section == 4) {
        Md * dic = _mdArr[_mdType];
        return 16 + [XXHelper calculteTheSizeWithContent:dic.content width:kWidth - 40 font:15];;
    }  else {
        return 0.01;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld - %ld",indexPath.section , indexPath.row);

    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0 && indexPath.row == 0) {
        HouseData_TVC * tvc = [[HouseData_TVC alloc]init];
        tvc.houseID = self.houseID;
        [(YMNavgatinController *)self.navigationController pushViewController:tvc type:YMNavgatinControllerTypeBlue animated:true];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        MapViewController * vc = [[MapViewController alloc]init];
        vc.title = _PDmodel.name;
        CLLocationCoordinate2D Location1;
        Location1.latitude = [_PDmodel.latitude floatValue];
        Location1.longitude = [_PDmodel.longitude floatValue];
        vc.location = Location1;
        vc.addressStr = _PDmodel.address;
        
        [(YMNavgatinController *)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeBlue  animated:true];
    }
    if (indexPath.section == 1) {
        BrokeragePlan_VC * vc = [[BrokeragePlan_VC alloc]init];
        vc.ID = self.houseID;
        [(YMNavgatinController *)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeBlue  animated:true];
    }
    if (indexPath.section == 2) {
        HouseDynamic_TVC * vc = [[HouseDynamic_TVC alloc]init];
        vc.ID = _houseID;
        [(YMNavgatinController *)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeBlue  animated:true];
    }
    if (indexPath.section == 3) {
        HouseDetails_VC * vc = [[HouseDetails_VC alloc]init];
        vc.wuId = [_PDmodel.hxArr[indexPath.row] id_hs];
        [(YMNavgatinController *)self.navigationController pushViewController:vc type:YMNavgatinControllerTypeClear  animated:true];
    }
}

#pragma mark - 楼盘详情页面请求
-(void)requestData {
    kWeakSelf;
    kUserData;
    NSDictionary * params = @{
                              kOpt : @"loupanxinxi",
                              kToken : userInfo.token,
                              @"id" : _houseID
                              };
    [XXNetWorkManager requestWithMethod:POST withParams:params withUrlString:@"Houses" withHud:@"信息更新中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        NSLog(@" 楼盘详情 - %@",objc);
        kShowMessage;
        if (code == 200) {
            _PDmodel = [PropertiesDetails_Model mj_objectWithKeyValues:data];
             _imagesURLStrings = [NSMutableArray array];
            _tagsArr = [NSMutableArray array];
            for (Pic *picDic in _PDmodel.picArr) {
                [_imagesURLStrings addObject:picDic.pic_kx];
            }
            for (Label * dic  in _PDmodel.labelArr) {
                [_tagsArr addObject:dic.name ];
            }


            for (Md * mdmodel in _PDmodel.mdArr) {
                if ([mdmodel.type isEqualToString:@"交通配套"]) {
                    [_mdArr replaceObjectAtIndex:0 withObject:mdmodel];
                }
                if ([mdmodel.type isEqualToString:@"教育资源"]) {
                    [_mdArr replaceObjectAtIndex:1 withObject:mdmodel];
                }
                if ([mdmodel.type isEqualToString:@"医疗健康"]) {
                    [_mdArr replaceObjectAtIndex:2 withObject:mdmodel];
                }
                if ([mdmodel.type isEqualToString:@"餐饮购物"]) {
                    [_mdArr replaceObjectAtIndex:3 withObject:mdmodel];
                }
            }
            _footeViewHeight = _PDmodel.tjArr.count * 0.5 * 150;

            if ([_PDmodel.sc_status intValue] == 0) {  // 未关注
                self.item1Str = @"guanzhu";
            }
            UIBarButtonItem * item1 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(self.item1Str) highImage:kImageNamed(self.item1Str) target:self action:@selector(itemGButtonAction) withTitle:@""];
            UIBarButtonItem * item2 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"fenxiang") highImage:kImageNamed(@"fenxiang") target:self action:@selector(itemFButtonAction) withTitle:@""];
            self.navigationItem.rightBarButtonItems = @[item2,item1];
            
            [weakSelf.tableview reloadData];
        }
    } withFailuerBlock:^(id error) {

    }];
}
#pragma mark ---- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _PDmodel.tjArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendProperties_CCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendProperties_CCell_ID" forIndexPath:indexPath];
    cell.tjModel = _PDmodel.tjArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PropertiesDetailsBBBB_VC * shiVc = [[PropertiesDetailsBBBB_VC alloc]init];
    shiVc.houseID = [_PDmodel.tjArr[indexPath.row] ID];
    [(YMNavgatinController *)self.navigationController pushViewController:shiVc type:YMNavgatinControllerTypeClear animated:YES];
}
-(void)clockButton:(NSInteger)index {
    
    _mdType = (int)index-1;
    NSIndexPath *uu = [NSIndexPath indexPathForRow:0 inSection:4];
    [self.tableview reloadRowsAtIndexPaths:@[uu] withRowAnimation:UITableViewRowAnimationAutomatic];

}
@end
