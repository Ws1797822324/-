//
//  Client_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Client_VC.h"
#import "ReportedPeopleViewController.h"
#import "MyPeopleTableViewController.h"
#import "SearchViewController.h"

@interface Client_VC ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *baobei_L;
@property (weak, nonatomic) IBOutlet UILabel *daikan_L;
@property (weak, nonatomic) IBOutlet UILabel *daiqueren_L;
@property (weak, nonatomic) IBOutlet UILabel *daigenjin_L;
@property (weak, nonatomic) IBOutlet UILabel *chengjiao_L;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation Client_VC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadRequest];
}
- (void)viewDidLoad {


    [super viewDidLoad];

    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];


    self.navigationItem.title = @"客户中心";
    _baobei_L.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    _daikan_L.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    _daiqueren_L.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    _daigenjin_L.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    _chengjiao_L.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"search")highImage:kImageNamed(@"search")target:self action:@selector(rightAction) withTitle:@""];

}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {


        [self loadRequest];
    }
}
- (void)rightAction
{
    SearchViewController * VC = [[SearchViewController alloc] init];
    VC.type = @"人";
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)loadRequest
{
    kUserData;
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"count",@"opt",userInfo.token,@"token", nil];
    NSString * url = [NSString stringWithFormat:@"%@ClientServlet",kBaseURL];
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:url withHud:@"加载客户数据" withProgressBlock:^(float requestProgress) {
        
    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code==200) {
            self.dataArray = data;
            if (self.dataArray.count==5) {
                _baobei_L.text = [NSString stringWithFormat:@"%@",self.dataArray[0]];
                _daikan_L.text = [NSString stringWithFormat:@"%@",self.dataArray[1]];
                _daiqueren_L.text = [NSString stringWithFormat:@"%@",self.dataArray[2]];
                _daigenjin_L.text = [NSString stringWithFormat:@"%@",self.dataArray[3]];
                _chengjiao_L.text = [NSString stringWithFormat:@"%@",self.dataArray[4]];
            }
        }else{
            kShowMessage;
        }
        
    } withFailuerBlock:^(id error) {
        
    }];
   
}

- (IBAction)UpDatePeopleClick:(UIButton *)sender {
    ReportedPeopleViewController * VC = [[ReportedPeopleViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
    
- (IBAction)MyPeopleClick:(UIButton *)sender {
    
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"我的客户";
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (IBAction)YBBClick:(id)sender {
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"已报备";
    VC.flag = @"1";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)YDKClick:(id)sender {
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"已带看";
    VC.flag = @"2";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)DQRClick:(id)sender {
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"待确认";
    VC.flag = @"3";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)DGJClick:(id)sender {
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"待跟进";
    VC.flag = @"4";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)YCJClick:(id)sender {
    MyPeopleTableViewController * VC = [[MyPeopleTableViewController alloc] init];
    VC.title = @"已成交";
    VC.flag = @"5";
    [self.navigationController pushViewController:VC animated:YES];
}
    
@end
