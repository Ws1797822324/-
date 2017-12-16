//
//  MineCollectionView.m
//  经纪人
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define COLOR_WHITE POSColor(255, 255, 255)

#import "MineCollectionView.h"

@implementation MineCollectionView

+ (instancetype)getViewWithNumberOfCols:(NSInteger)numberOfCols
                                panding:(CGFloat)panding
                                 margin:(CGFloat)margin
                              rowMargin:(CGFloat)rowMargin
                              topMargin:(CGFloat)topMargin
                             itemHeight:(CGFloat)itemHeight
                               delegate:(id<UICollectionViewDelegate>)delegate
                             dataSource:(id<UICollectionViewDataSource>)dataSource {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    MineCollectionView *collectionView =
        [[MineCollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];

    CGFloat itemWidth = (SCREEN_WIDTH - 2 * panding - (numberOfCols - 1) * margin) / numberOfCols;

    layout.itemSize = CGSizeMake(itemWidth, itemHeight);

    layout.minimumLineSpacing = rowMargin;

    layout.sectionInset = UIEdgeInsetsMake(topMargin, panding, margin, topMargin);

    collectionView.delegate = delegate;

    collectionView.dataSource = dataSource;

    collectionView.showsVerticalScrollIndicator = NO;

    collectionView.backgroundColor = [UIColor whiteColor];

    return collectionView;
}

@end
