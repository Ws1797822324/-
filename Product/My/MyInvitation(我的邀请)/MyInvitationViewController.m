//
//  MyInvitationViewController.m
//  经纪人
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyInvitationViewController.h"

@interface MyInvitationViewController () <UITableViewDataSource, UITableViewDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray  *dataArr;
@property (nonatomic ,assign) int  page;

@end

@implementation MyInvitationViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void)requestData:(BOOL)type {

    kUserData;
    kWeakSelf;

    if (type) {
        _page = 0;
        _dataArr = [NSMutableArray array];
    }
#pragma mark - 我的邀请查看
    NSDictionary * dic = @{
                           kOpt : @"find",
                           kToken : userInfo.token
                           };

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"OperateServlet" withHud:@"数据加载中" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        XXLog(@"邀请还没有做好了 - %@",objc);
        if (code == 200) {
            _page++;

            _dataArr = [YaoQingModel mj_objectArrayWithKeyValuesArray:data];
            if (type) {

            }
        }
        [weakSelf.tableview cyl_reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
        [weakSelf.tableview.mj_header endRefreshing];

    } withFailuerBlock:^(id error) {

    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的邀请";
    self.page = 0;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    self.tableview.delegate = self;
    kWeakSelf;
    [self.view addSubview:weakSelf.tableview];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData:YES];
    }];
    [self.tableview.mj_header beginRefreshing];
//    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf requestData:NO];
//    }];
    self.tableview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    } else {
        return _dataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray * arr1 = @[@"shouji",@"QQ",@"weChat"];
        NSArray * arr2 = @[@"邀请手机联系人",@"邀请QQ好友",@"邀请微信好友"];
        
        UITableViewCell *cell1 = [[UITableViewCell alloc] init];
        cell1.imageView.image = kImageNamed(arr1[indexPath.row]);
        cell1.textLabel.text = arr2[indexPath.row];
        
        return cell1;
    } else {

        UITableViewCell *cell1 = [[UITableViewCell alloc] init];
        cell1.textLabel.text = [_dataArr[indexPath.row] name];

        return cell1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view1 = [[UIView alloc] init];

        view1.backgroundColor = kRGB_HEX(0xD6D6D6);
        view1.frame = CGRectMake(0, 0, kScreenWidth, 45);
        UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 70, view1.height - 10)];
        l1.text = @"已邀请";
        l1.textColor = kRGB_HEX(0x424242);
        [view1 addSubview:l1];
        return view1;
    } else {
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 0) {
        return 45;
    } else {
        return 0.001;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    kUserData;
    if (indexPath.section == 0 && indexPath.row == 0) {

        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sms)]];


        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
        // 设置短信内容
        vc.body = kString(@"http://121.43.176.154:8080/h5/invite.html?type=1user_id=%@", userInfo.ID);

        // 设置收件人列表
        vc.recipients = @[];  // 号码数组
        // 设置代理
        vc.messageComposeDelegate = self;
        // 显示控制器

        UIBarButtonItem * btn = [UIBarButtonItem rightbarButtonItemWithNorImage:nil highImage:nil target:self action:@selector(duanxinAction) withTitle:@"取消"];
        [[[vc viewControllers] lastObject] navigationItem].rightBarButtonItem = btn;
        [self presentViewController:vc animated:YES completion:nil];

    }
    if (indexPath.section == 0 && indexPath.row == 1) {

                //创建分享消息对象
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                //创建图片内容对象
                //如果有缩略图，则设置缩略图
                UIImage * thumimage =kImageNamed(@"logo");
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"卖哪邀请您加入我们" descr:nil thumImage:thumimage];
            UserInfo *user = [UserInfoTool account];
                shareObject.webpageUrl = kString(@"http://121.43.176.154:8080/h5/invite.html?type=2user_id=%@", user.ID);
                //分享消息对象设置分享内容对象
                messageObject.shareObject = shareObject;

                //调用分享接口
                [[UMSocialManager defaultManager] shareToPlatform:4 messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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

    if (indexPath.section == 0 && indexPath.row == 2) {

        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //创建图片内容对象

        //如果有缩略图，则设置缩略图
        UIImage * thumimage =kImageNamed(@"logo");
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"卖哪邀请您加入我们" descr:nil thumImage:thumimage];
        UserInfo *user = [UserInfoTool account];
        shareObject.webpageUrl = kString(@"http://121.43.176.154:8080/h5/invite.html?type=3user_id=%@", user.ID);
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;

        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:4 messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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

}

-(void) duanxinAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
