//
//  MainWebViewController.m
//  Product
//
//  Created by HJ on 2017/11/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MainWebViewController.h"
#import <WebKit/WebKit.h>
@interface MainWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation MainWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavHeight)];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];

    [self.view addSubview:webView];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.navigationItem.title isEqualToString:@"注册协议"]) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XXProgressHUD showLoading:@"加载中..."];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
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
