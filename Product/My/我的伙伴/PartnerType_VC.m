//
//  PartnerType_VC.m
//  Product
//
//  Created by Sen wang on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PartnerType_VC.h"

#import "WorkType_VC.h"

@interface PartnerType_VC ()
- (IBAction)daikanBtn:(UIButton *)sender;

- (IBAction)chengjiaoBtn:(UIButton *)sender;
@end

@implementation PartnerType_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
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

- (IBAction)daikanBtn:(UIButton *)sender {
    
    WorkType_VC * vc = [[WorkType_VC alloc]init];
    vc.navigationItem.title = @"带看详情";
    vc.type_vc = @"0";
    vc.kh_ID = _khID;

    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chengjiaoBtn:(UIButton *)sender {
    
    WorkType_VC * vc = [[WorkType_VC alloc]init];
    vc.navigationItem.title = @"成交详情";
    vc.type_vc = @"1";
    vc.kh_ID = _khID;

    [self.navigationController pushViewController:vc animated:YES];

    
}
@end
