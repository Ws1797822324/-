//
//  SearchViewController.m
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "AllPeopleTableViewCell.h"
#import "PeopleListModel.h"
#import "PropertiesDetails_VC.h"
#import "PeopleDetailsViewController.h"



@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *TF_search;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *searchtableView;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *rows;
@end

@implementation SearchViewController
- (UITableView *)searchtableView {
    if (!_searchtableView) {
        _searchtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _searchtableView.delegate = self;
        _searchtableView.dataSource = self;
        _searchtableView.tableFooterView = [[UIView alloc] init];
        [_searchtableView
                       registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]]
            forCellReuseIdentifier:@"HomeCell_ID"];
        [_searchtableView registerNib:[UINib nibWithNibName:@"AllPeopleTableViewCell"
                                                     bundle:[NSBundle mainBundle]]
               forCellReuseIdentifier:@"AllPeopleTableViewCell"];
        if ([self.type isEqualToString:@"人"]) {
            _searchtableView.mj_footer = [MJRefreshBackNormalFooter
                footerWithRefreshingTarget:self
                          refreshingAction:@selector(loadMorePeopleData)];
        } else {
            _searchtableView.mj_footer =
                [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                     refreshingAction:@selector(loadMoreData)];
        }
    }
    return _searchtableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:kRGB_HEX(0x66a8fc)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdNavUI];
    self.navigationController.navigationBar.translucent = NO;

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        self.searchtableView.contentInsetAdjustmentBehavior =
            UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }

    self.view.backgroundColor = [UIColor whiteColor];
    self.rows = @"10";
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    self.topLabel.backgroundColor = kRGB_HEX(0xfafafa);
    self.topLabel.text = @"  搜索历史";
    self.topLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.topLabel];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 40 - 20, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"delete_icon"] forState:0];
    [btn addTarget:self
                  action:@selector(deleAllClick)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    [self getLoadData];
}
- (void)deleAllClick {
    NSArray *array1 =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [array1 lastObject];
    NSString *documentPath;
    if ([self.type isEqualToString:@"人"]) {
        documentPath = [documents stringByAppendingPathComponent:@"peopleList.xml"];
    } else {
        documentPath = [documents stringByAppendingPathComponent:@"houseList.xml"];
    }
    self.dataArray = (NSMutableArray *) @[];
    [self.dataArray writeToFile:documentPath atomically:YES];
    [self.tableView reloadData];
}
- (void)saveStringWith:(NSString *)string {
    NSArray *array1 =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [array1 lastObject];
    NSString *documentPath;
    if ([self.type isEqualToString:@"人"]) {
        documentPath = [documents stringByAppendingPathComponent:@"peopleList.xml"];
    } else {
        documentPath = [documents stringByAppendingPathComponent:@"houseList.xml"];
    }
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:documentPath];
    if (self.dataArray.count == 0) {
        self.dataArray = (NSMutableArray *) @[ string ];
    } else {
        [self.dataArray addObject:string];
    }

    BOOL isyes =
        [[XXHelper arrayWithMemberIsOnly:_dataArray] writeToFile:documentPath atomically:YES];
    NSLog(@"是否保存成功%d resultArray = %@", isyes, self.dataArray);
}
- (void)getLoadData {
    NSArray *array1 =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [array1 lastObject];
    NSString *documentPath;
    if ([self.type isEqualToString:@"人"]) {
        documentPath = [documents stringByAppendingPathComponent:@"peopleList.xml"];
    } else {
        documentPath = [documents stringByAppendingPathComponent:@"houseList.xml"];
    }

    self.dataArray = [NSMutableArray arrayWithContentsOfFile:documentPath];
    NSLog(@"现有本地resultArray = %@", self.dataArray);
    if (self.dataArray.count == 0) { // 没有数据
        [self.view addSubview:self.tipView];
    } else { // 显示数据
        [self.view addSubview:self.tableView];
    }
}
- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 40)];
        UILabel *label =
            [[UILabel alloc] initWithFrame:CGRectMake(0, (kHeight - 80) / 2, kWidth, 40)];
        [_tipView addSubview:label];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"还没有搜索历史哦~";
        label.textColor = kRGB_HEX(0x575757);
    }
    return _tipView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 40)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.dataArray.count;
    } else if (tableView == self.searchtableView) {
        return self.searchDataArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        return 44;
    } else if (tableView == self.searchtableView) {
        if ([self.type isEqualToString:@"房屋"]) {
            HouseModel *model = _searchDataArray[indexPath.row];
            if (model.tagsArr.count == 0) {
                return 85;
            } else {
                NSMutableArray *arrr = [NSMutableArray array];
                for (Label *jj in model.tagsArr) {
                    [arrr addObject:jj.name];
                }
                return 70 + [SQButtonTagView returnViewHeightWithTagTexts:arrr
                                                                viewWidth:kWidth - 170
                                                                  eachNum:0
                                                                  Hmargin:10
                                                                  Vmargin:5
                                                                tagHeight:20
                                                              tagTextFont:kBoldFont(12)];
            }
        } else {
            return 65;
        }
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hjhjcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"hjhjcell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = kRGB_HEX(0x333333);
    if (tableView == self.tableView) {
        cell.textLabel.text = self.dataArray[indexPath.row];
    } else if (tableView == self.searchtableView) {
        if ([self.type isEqualToString:@"房屋"]) {
            HomeCell *homecell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell_ID"];

            HouseModel *model = _searchDataArray[indexPath.row];
            homecell.model = model;

            homecell.tagsView.hidden = 0;
            if (model.tagsArr.count > 0) {
                homecell.tagsView.hidden = 1;
                [homecell tagsData:model.tagsArr];
            } else {
                homecell.tagsView_H.constant = 2;
                [homecell.tagsView removeFromSuperview];
            }

            homecell.selectionStyle = UITableViewCellSelectionStyleNone;
            return homecell;
        } else {
            AllPeopleTableViewCell *peopleCell =
                [tableView dequeueReusableCellWithIdentifier:@"AllPeopleTableViewCell"];
            PeopleListModel *model = self.searchDataArray[indexPath.row];

            NSMutableString * str = [[NSMutableString alloc]initWithString:model.phone];

            [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];


            peopleCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,str];
            peopleCell.timeLabel.text = [model.time stringByReplacingOccurrencesOfString:@".0" withString:@""];

            return peopleCell;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
        NSString *str = self.dataArray[indexPath.row];
        self.TF_search.text = str;
        [self.TF_search becomeFirstResponder];

        if ([_type isEqualToString:@"房屋"]) {
            [self loadRequest];
        }
        if ([_type isEqualToString:@"人"]) {
            [self loadPeopleData];
        }

    } else if (tableView == self.searchtableView) {

        if ([_type isEqualToString:@"房屋"]) {

            PropertiesDetails_VC *propertiesDetails = [[PropertiesDetails_VC alloc] init];
            HouseModel *model = _searchDataArray[indexPath.row];
            propertiesDetails.houseID = model.ID;
            [(YMNavgatinController *) self.navigationController
                pushViewController:propertiesDetails
                              type:YMNavgatinControllerTypeClear
                          animated:YES];
        }

        if ([_type isEqualToString:@"人"]) {

            PeopleListModel * model = self.searchDataArray[indexPath.row];
            PeopleDetailsViewController * VC = [[PeopleDetailsViewController alloc] init];
            VC.ids = model.ID;
            VC.baibeiType = @"1";
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    [self.view addSubview:self.searchtableView];

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.TF_search.text isEqualToString:@""]) {
        [self.searchtableView removeFromSuperview];
    }
}
#pragma mark------------ 搜索框
- (void)createdNavUI {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(searchClick)];
    self.navigationItem.rightBarButtonItem = item;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 7, kWidth - 100, 33)];
    self.TF_search = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, kScreenWidth - 120, 33)];
    self.TF_search.placeholder = @"  请输入小区房或房源编号";
    self.TF_search.backgroundColor = kRGBColor(71, 149, 238, 0.8);
    self.TF_search.alpha = 0.5;
    self.TF_search.delegate = self;
    self.TF_search.returnKeyType = UIReturnKeySearch;
    [self.TF_search setValue:kRGBColor(157, 201, 247, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.TF_search setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.TF_search.font = [UIFont systemFontOfSize:13];

    [view addSubview:self.TF_search];
    self.TF_search.borderStyle = UITextBorderStyleRoundedRect;
    kViewRadius(self.TF_search, 15);
    //创建左侧视图
    UIImage *im = [UIImage imageNamed:@"search"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    iv.center = lv.center;
    [lv addSubview:iv];

    self.TF_search.leftViewMode = UITextFieldViewModeAlways;
    self.TF_search.leftView = lv;

    self.navigationItem.titleView = view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchClick];
    return YES;
}
#pragma mark--------------- 搜索事件
- (void)searchClick {
    if (!kStringIsEmpty(self.TF_search.text)) {
        [self saveStringWith:self.TF_search.text]; // 本地保存
        [self.tableView reloadData];

        if ([self.type isEqualToString:@"人"]) {
            [self loadPeopleData];
        } else {
            [self loadRequest];
        }
        [self.TF_search resignFirstResponder];
    } else {
        [XXProgressHUD showMessage:@"请输入搜索文字"];
    }
}
#pragma mark----------- 加载更多
- (void)loadMorePeopleData {
    self.page = [NSString stringWithFormat:@"%d", [self.page intValue] + 1];
    kUserData;
    NSDictionary *dic = [[NSDictionary alloc]
        initWithObjectsAndKeys:@"my_client", @"opt", self.TF_search.text, @"name", userInfo.token,
                               kToken, self.page, @"page", self.rows, @"row", nil];

    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"ClientServlet"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"objc  = = %@", objc);
            NSArray *array = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count == 0) {
                [XXProgressHUD showMessage:@"已经没有内容啦"];
            } else {
                [self.searchDataArray addObjectsFromArray:array];
                [self.searchtableView reloadData];
            }
        }
        withFailuerBlock:^(id error){

        }];
    [self.searchtableView.mj_footer endRefreshing];
}
- (void)loadPeopleData {
    self.page = @"0";
    kUserData;
    NSDictionary *dic = [[NSDictionary alloc]
        initWithObjectsAndKeys:@"my_client", @"opt", self.TF_search.text, @"name", userInfo.token,
                               kToken, self.page, @"page", self.rows, @"row", nil];
    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"ClientServlet"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {

            NSLog(@"objc  = = %@", objc);

            if (code == 200) {

                self.searchDataArray = [PeopleListModel mj_objectArrayWithKeyValuesArray:data];
            }
            if (self.searchDataArray.count == 0) {
                [XXProgressHUD showMessage:@"暂无搜索内容"];
            } else {
                [self.searchtableView reloadData];
            }
        }
        withFailuerBlock:^(id error){

        }];
}

- (void)loadMoreData {
    self.page = [NSString stringWithFormat:@"%d", [self.page intValue] + 1];
    kUserData;
    NSDictionary *dic = @{
        @"lat" : kStringIsEmpty(userInfo.lat) ? @"32.164575" : userInfo.lat,
        @"lng" : kStringIsEmpty(userInfo.lng) ? @"118.691732" : userInfo.lng,
        @"opt" : @"mohuchaxun",
        @"name" : self.TF_search.text,
        kToken : userInfo.token,
        @"page" : _page,
        @"row" : _rows
    };

    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"Houses"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"objc  = = %@", objc);

            NSArray *array = [HouseModel mj_objectArrayWithKeyValuesArray:data];
            if (array.count == 0) {
                [XXProgressHUD showError:@"已经没有内容啦"];
            } else {
                [self.searchDataArray addObjectsFromArray:array];
                [self.searchtableView reloadData];
            }
        }
        withFailuerBlock:^(id error){

        }];
    [self.searchtableView.mj_footer endRefreshing];
}
- (void)loadRequest {

    self.page = @"0";
    kUserData;

    NSDictionary *dic = @{
        @"lat" : kStringIsEmpty(userInfo.lat) ? @"32.164575" : userInfo.lat,
        @"lng" : kStringIsEmpty(userInfo.lng) ? @"118.691732" : userInfo.lng,
        @"opt" : @"mohuchaxun",
        @"name" : self.TF_search.text,
        kToken : userInfo.token,
        @"page" : _page,
        @"row" : _rows
    };
    [XXNetWorkManager requestWithMethod:POST
        withParams:dic
        withUrlString:@"Houses"
        withHud:nil
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            NSLog(@"objc  = = %@", objc);
            self.searchDataArray = [HouseModel mj_objectArrayWithKeyValuesArray:data];
            if (self.searchDataArray.count == 0) {
                [XXProgressHUD showMessage:@"暂无搜索内容"];
            } else {
                [self.searchtableView reloadData];
            }
        }
        withFailuerBlock:^(id error){

        }];
}

@end
