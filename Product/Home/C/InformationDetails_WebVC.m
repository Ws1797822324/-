//
//  Information_WebVC.m
//  Product
//
//  Created by  海跃尚 on 17/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InformationDetails_WebVC.h"
#import <WebKit/WebKit.h>

@interface InformationDetails_WebVC () <WKNavigationDelegate,WKUIDelegate,MFMessageComposeViewControllerDelegate>
{

    
}

@end

@implementation InformationDetails_WebVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯详情";
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - kNavHeight)];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;

    if ([_model.type intValue] == 1) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.43.176.154:8080/h5/bannerContext.html?ids=%@",_model.ID]]]];

    } else {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.extra]]];

        
    }
    if ([_model.type intValue] == 3) {

        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.43.176.154:8080/h5/newsInfo.html?ids=%@",_model.ID]]]];

    }
    if (_classNameNum == 9964) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.content]]];

    }
    
    UIBarButtonItem * item2 = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"fenxiang") highImage:kImageNamed(@"fenxiang") target:self action:@selector(itemFButtonAction) withTitle:@""];
    self.navigationItem.rightBarButtonItem = item2;

    [self.view addSubview:webView];
}

#pragma mark --------- 分享
-(void) itemFButtonAction {

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sms)]];
    // 显示分享面板

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        if (platformType == 13) {
            MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
            // 设置短信内容
            vc.body = kString(@"http://121.43.176.154:8080/h5/newsInfo.html?ids=%@", _model.ID);

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
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"资讯分享" descr:nil thumImage:thumimage];


        shareObject.webpageUrl = kString(@"http://121.43.176.154:8080/h5/newsInfo.html?ids=%@", _model.ID);
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

-(void)duanxinAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XXProgressHUD showLoading:@"资讯加载中..."];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [XXProgressHUD hideHUD];
}
// 页面加载完成之后调用

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [XXProgressHUD hideHUD];
//    //修改字体大小 300%
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'" completionHandler:nil];
    
    //修改字体颜色  #9098b8
    //    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#222222'" completionHandler:nil];

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{

    [XXProgressHUD showError:@"页面加载失败!"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
