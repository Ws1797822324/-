

//
//  NewStayparticularsViewController.m
//  Product
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewStayparticularsViewController.h"
#import "PosTool.h"
#import "CommissionDetailsModel.h"
@interface NewStayparticularsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CommissionDetailsModel *model;

@end

@implementation NewStayparticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"佣金详情"];
    [self setUI];
    [self loadRequest];
}
- (void)loadRequest {
    kUserData;

    NSDictionary *dic =
        [[NSDictionary alloc] initWithObjectsAndKeys:@"Commissioninfo", @"opt", self.ids, @"id",
                                                     userInfo.token, @"token",self.wsType ,@"type", nil];
    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"Commission"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            
            if (code == 200) {
                self.model = [CommissionDetailsModel mj_objectWithKeyValues:data];
                [self.tableView reloadData];
            } else {
                kShowMessage;
            }

        }
        withFailuerBlock:^(id error){

        }];
}
- (void)setUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark UITableViewDataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];

        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    }

    [self setCellWithIndexPath:indexPath cell:cell];
    return cell;
}

- (void)setCellWithIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell {
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    if (indexPath.row < 5) {
        if ([self.type isEqualToString:@"1"]) {
            NSArray *holders = @[
                @"姓名", @"项目", @"成交时间", @"经纪人", @"已结佣金"
            ];
            UILabel *nameLB = [PosTool labelWithTextColr:@"969696"
                                                fontName:@""
                                                fontSize:14
                                             defaultText:holders[indexPath.row]];
            [cell.contentView addSubview:nameLB];
            nameLB.textColor = [UIColor lightGrayColor];
            [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.centerY.mas_equalTo(0);
            }];

        } else {
            NSArray *holders = @[
                @"姓名", @"项目", @"成交时间", @"经纪人", @"待结佣金"
            ];
            UILabel *nameLB = [PosTool labelWithTextColr:@"969696"
                                                fontName:@""
                                                fontSize:14
                                             defaultText:holders[indexPath.row]];
            [cell.contentView addSubview:nameLB];
            nameLB.textColor = [UIColor lightGrayColor];
            [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.centerY.mas_equalTo(0);
            }];
        }
    }
    if (indexPath.row == 0) {
        UILabel *moneyLB = [[UILabel alloc] init];
        moneyLB.text = self.model.kh_name;
        moneyLB.font = [UIFont systemFontOfSize:17];
        moneyLB.textColor = kRGB_HEX(0x808080);
        [cell.contentView addSubview:moneyLB];
        [moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);

        }];
    } else if (indexPath.row == 1) {
        UILabel *moneyLB1 = [[UILabel alloc] init];
        moneyLB1.text = self.model.l_id;
        moneyLB1.font = [UIFont systemFontOfSize:17];
        moneyLB1.textColor = kRGB_HEX(0x808080);
        [cell.contentView addSubview:moneyLB1];
        [moneyLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);

        }];

    } else if (indexPath.row == 2) {
        UILabel *moneyLB2 = [[UILabel alloc] init];
        moneyLB2.text = self.model.nodealtime;
        moneyLB2.font = [UIFont systemFontOfSize:17];
        moneyLB2.textColor = kRGB_HEX(0x808080);
        [cell.contentView addSubview:moneyLB2];
        [moneyLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);

        }];

    } else if (indexPath.row == 3) {
        UILabel *moneyLB3 = [[UILabel alloc] init];
        moneyLB3.text = self.model.name;
        moneyLB3.font = [UIFont systemFontOfSize:17];
        moneyLB3.textColor = kRGB_HEX(0x808080);
        [cell.contentView addSubview:moneyLB3];
        [moneyLB3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);

        }];

    } else {
        UILabel *moneyLB5 = [[UILabel alloc] init];
        moneyLB5.text = self.model.brokerage;
        moneyLB5.font = [UIFont systemFontOfSize:17];
        moneyLB5.textColor = [UIColor redColor];
        [cell.contentView addSubview:moneyLB5];
        [moneyLB5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);

        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;

}

@end
