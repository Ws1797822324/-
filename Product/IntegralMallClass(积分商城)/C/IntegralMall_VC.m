//
//  IntegralMall_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IntegralMall_VC.h"

#import "IntegralMall_CCell.h"

#import "MyIntegral_VC.h"
#import "GoodsParticulars_VC.h"
#import "MyExchange_VC.h"

@interface IntegralMall_VC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic ,assign) NSInteger page;

@end

@implementation IntegralMall_VC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _dataArr = [NSMutableArray array];
    [self requestDataRefresh:YES];
}
- (void)viewDidLoad {
    self.navigationItem.title = @"积分商城";
    [super viewDidLoad];
    kWeakSelf

        [[self.exchangeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
            subscribeNext:^(__kindof UIControl *_Nullable x) {
                NSLog(@"我的兑换");
            }];

    self.collerctionView.dataSource = self;
    self.collerctionView.delegate = self;
    CGFloat itemWidth = (kWidth - 10) / 2;

    self.layout.itemSize = CGSizeMake(itemWidth, itemWidth * 0.9);
    // 设置最小行间距
    _layout.minimumLineSpacing = 10;
    // 设置垂直间距
    _layout.minimumInteritemSpacing = 0;
    _layout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5);

    //    _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    [self.collerctionView registerNib:[UINib nibWithNibName:NSStringFromClass([IntegralMall_CCell class]) bundle:nil]
           forCellWithReuseIdentifier:@"IntegralMall_CCell_ID"];
    [[self.integralButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
            MyIntegral_VC *vc = [MyIntegral_VC viewControllerFromNib];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    [[self.exchangeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl *_Nullable x) {
            MyExchange_VC *vc = [[MyExchange_VC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];


    self.collerctionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataRefresh:YES];
    }];
    self.collerctionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataRefresh:NO];
        
    }];
}
// MARK: ------ 积分商城请求 ------
- (void)requestDataRefresh:(BOOL)type {
    kUserData
    if (type) {
        _dataArr = [NSMutableArray array];
        _page = 0;
    }
    NSDictionary *params = @{ kOpt : @"shop",
                              kToken : userInfo.token,
                              @"row" : @"10",
                              @"page" :kString(@"%ld", _page)
                              };
    [XXNetWorkManager requestWithMethod:POST
        withParams:params
        withUrlString:kPersonalServlet
        withHud:@"商品加载..."
        withProgressBlock:^(float requestProgress) {

        }
        withSuccessBlock:^(id objc, int code, NSString *message, id data) {
            kInspectSignInType
            kShowMessage
            kWeakSelf
            if (code == 200) {
                _page ++ ;

                if (type) {
                    _dataArr = [IntegralMall_Model mj_objectArrayWithKeyValuesArray:data];
                } else {
                    [_dataArr addObjectsFromArray:[IntegralMall_Model mj_objectArrayWithKeyValuesArray:data]];
                }
                [_integralButton setTitle:objc[@"message"] forState:UIControlStateNormal];
            }
            if (_dataArr.count == 0) {
                UIAlertController * ac = [UIAlertController alertControllerWithTitle:@" sorry 暂时没有可兑换商品" message:@"改天再来" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:true];
                }];
                UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"刷新页面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.collerctionView reloadData];
                }];

                [ac addAction:a1];
                [ac addAction:a2];
                
                [weakSelf presentViewController:ac animated:YES completion:^{
                    
                }];
                                      
            }
            [weakSelf.collerctionView reloadData];
            NSLog(@"积分商城请求-- \n%@", objc);

        }
        withFailuerBlock:^(id error){

        }];
    [self.collerctionView.mj_header endRefreshing];
    [self.collerctionView.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1.0f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    IntegralMall_CCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"IntegralMall_CCell_ID" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsParticulars_VC *vc = [GoodsParticulars_VC viewControllerFromNib];
    vc.ID = [_dataArr[indexPath.row] ID];
    vc.jifen = [_dataArr[indexPath.row] present_points];
    [self.navigationController pushViewController:vc animated:true];
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
