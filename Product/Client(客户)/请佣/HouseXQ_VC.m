//
//  HouseXQ_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HouseXQ_VC.h"

#import "HouseXQ_Cell.h"

@interface HouseXQ_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) FWXQ *model;

@end

@implementation HouseXQ_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"房屋信息";
    self.view.backgroundColor = kAllRGB;
    [self.view addSubview: self.tableview];
    self.tableview.sd_layout
    .topSpaceToView(self.view, 10)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HouseXQ_Cell class]) bundle:nil] forCellReuseIdentifier:@"HouseXQ_Cell_ID"];
    // Do any additional setup after loading the view from its nib.
    kUserData;
    NSDictionary * dic = @{
                           kOpt : @"fw_xq",
                           kToken : userInfo.token,
                           @"id" : _ID,
                           @"type" : _baoBeiType

                           };

    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"CommissionServlet" withHud:@"房屋信息" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        XXLog(@"fangwi  -- %@",objc);
        if (code == 200) {
            NSDictionary * dic = data;
            if (!kDictIsEmpty(dic)) {
               _model = [FWXQ mj_objectWithKeyValues:data];
                [self.tableview cyl_reloadData];
            }
        }
    } withFailuerBlock:^(id error) {

    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseXQ_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseXQ_Cell_ID"];
    [cell configViewRow:indexPath.row model:_model];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
