//
//  PropertiesDetailsBBBB_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PropertiesDetailsBBBB_VC.h"

@interface PropertiesDetailsBBBB_VC ()<UICollectionViewDelegate>

@end

@implementation PropertiesDetailsBBBB_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:kImageNamed(@"navigationbar_back") highImage:kImageNamed(@"navigationbar_back") target:self action:@selector(popove) withTitle:@"反击"];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)popove
{
    
    [(YMNavgatinController *)self.navigationController popViewControllerAnimated:YES type:1];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:0];

    [self.tableview scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionNone animated:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

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
