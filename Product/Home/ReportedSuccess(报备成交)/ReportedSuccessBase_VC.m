//
//  ReportedSuccessBase_VC.m
//  Product
//
//  Created by Sen wang on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReportedSuccessBase_VC.h"

#import "ReportedSuccessList_VC.h"

#import "ReportedSuccessViewController.h"

@interface ReportedSuccessBase_VC ()

@end

@implementation ReportedSuccessBase_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报备成交";
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

- (IBAction)leftButton:(id)sender {

    ReportedSuccessList_VC * vc = [[ReportedSuccessList_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)rightButton:(id)sender {

    ReportedSuccessViewController * vc = [[ReportedSuccessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
}
@end
