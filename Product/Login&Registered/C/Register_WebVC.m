//
//  Register_WebVC.m
//  Product
//
//  Created by Sen wang on 2017/12/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Register_WebVC.h"
#import <WebKit/WebKit.h>


@interface Register_WebVC () <WKNavigationDelegate,WKUIDelegate>

@end

@implementation Register_WebVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:kRGB_HEX(0x66A8FC)];

}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册协议";
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - kNavHeight)];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;


        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://121.43.176.154:8080/h5/userHttp.html"]]];




    [self.view addSubview:webView];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
