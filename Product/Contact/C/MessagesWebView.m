//
//  MessagesWebView.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MessagesWebView.h"
#import <WebKit/WebKit.h>

@interface MessagesWebView ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation MessagesWebView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"通知详情";
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;

    [webView loadHTMLString:_h5Str baseURL:nil];


    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
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
