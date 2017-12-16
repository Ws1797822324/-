//
//  IntegralRuleS_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IntegralRuleS_VC.h"

#import "IntegralRule_Cell.h"

@interface IntegralRuleS_VC ()<UITableViewDataSource,UITableViewDelegate>

- (IBAction)confirmAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic ,strong) NSArray *dataArr;

@end

@implementation IntegralRuleS_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.bounces = NO;
    kUserData;
    NSDictionary * dic = @{
                           kOpt : @"jifen",
                           kToken : userInfo.token
                           };
    [XXNetWorkManager requestWithMethod:POST withParams:dic withUrlString:@"News" withHud:@"积分规则" withProgressBlock:^(float requestProgress) {

    } withSuccessBlock:^(id objc, int code, NSString *message, id data) {
        if (code == 200) {
            _dataArr = [JiFenGXModel mj_objectArrayWithKeyValuesArray:data];
            [_tableview reloadData];
        }


    } withFailuerBlock:^(id error) {

    }];
    kViewRadius(self.view, 5);
    kViewRadius(_confirmButton, 4);
    kWeakSelf;

    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([IntegralRule_Cell class]) bundle:nil] forCellReuseIdentifier:@"IntegralRule_Cell"];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IntegralRule_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRule_Cell"];
    cell.model = _dataArr[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)confirmAction:(UIButton *)sender {
    self.click();
//    [self.navigationController dismissPopupViewControllerWithanimationType:0];
}

@end
