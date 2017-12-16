//
//  BaseViewController.m
//  Product
//
//  Created by  海跃尚 on 17/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () 

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ self configTableView];
    // Do any additional setup after loading the view.
}

-(void)configTableView {
    _tableview =[[UITableView alloc]init];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    _tableview.mj_header.automaticallyChangeAlpha = YES;

    [XXHelper deleteExtraCellLine:_tableview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [XXProgressHUD hideHUD];

}

#pragma mark - CYLTableViewPlaceHolderDelegate

-(UIView *)makePlaceHolderView {
    kWeakSelf
    PlaceHolderView * placeHolderV = [PlaceHolderView viewFromXib];
    [[placeHolderV.reloadDataButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.tableview.mj_header beginRefreshing];
    }];
    return placeHolderV;
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
