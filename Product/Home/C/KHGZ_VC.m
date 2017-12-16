//
//  KHGZ_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KHGZ_VC.h"
#import "KHGZ_Cell.h"

@interface KHGZ_VC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) KHGZModel *model;

@end

@implementation KHGZ_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    kViewRadius(_confirmBtn, 4);
    kViewRadius(self.view, 5);
    self.tableview.bounces = NO;
    [XXHelper deleteExtraCellLine:_tableview];
    [_tableview registerNib:[KHGZ_Cell nib] forCellReuseIdentifier:@"KHGZ_Cell"];
    kUserData;
    kWeakSelf;
    NSDictionary * dict = @{
                            kOpt : @"khgz",
                            kToken : userInfo.token,
                            @"l_id" : _l_id
                            };
    [XXNetWorkManager requestWithMethod:POST withParams:dict withUrlString:@"News" withHud:@"客户规则..." withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {

        if (code == 200) {
            _model = [KHGZModel mj_objectWithKeyValues:data[0]];
            XXLog(@"kkkkhhhhh -- %@",_model);

            [_tableview reloadData];

        }

    } withFailuerBlock:^(id error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KHGZ_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"KHGZ_Cell"];
    NSArray * arr = @[@"结佣规则",@"带看规则",@"开发商规则"];

    cell.title_L.text = arr[indexPath.row];
    if(indexPath.row == 0) {

        cell.text_L.text = _model.settle_ac_rule;
    }
    if(indexPath.row == 1) {

        cell.text_L.text = _model.look_rule;
    }
    if(indexPath.row == 2) {

        cell.text_L.text = _model.developers_rule;
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (IBAction)confirmBtn:(UIButton *)sender {
    self.clickAction();
}
@end
