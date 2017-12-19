//
//  SetupViewController.m
//  Product
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#define colorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


#import "SetupViewController.h"
#import "PosTool.h"
#import "OldPhoneViewController.h"
#import "OldPasswordViewController.h"
#import "AdviceViewController.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
@interface SetupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    [self setUI];
}

-(void)setUI{
    
    self.tableView = [PosTool tableViewWithStyle:UITableViewStylePlain dataSource:self delegate:self];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = colorWithRGB(54, 157, 252);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(cashout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-64);
    }];



    
}
#pragma mark UITableViewDataSource/delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }
    
    return  3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 8)];
    view.backgroundColor = kRGB_HEX(0xfafafa);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        
    }
    
    [self setCellWithIndexPath:indexPath cell:cell];
    
    return cell;
}



-(void)setCellWithIndexPath:(NSIndexPath*)indexPath cell:(UITableViewCell*)cell{
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    if (indexPath.section==0) {
        UILabel* numerLB = [PosTool labelWithTextColr:@"0D0D0F" fontName:@"STHeitiSC-Light" fontSize:15 defaultText:@"清除缓存"];
        [cell.contentView addSubview:numerLB];
        [numerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        
        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
        //
        NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
        

        UILabel* numerLB1 = [PosTool labelWithTextColr:@"0D0D0F" fontName:@"STHeitiSC-Light" fontSize:15 defaultText:[NSString stringWithFormat:@"%@", currentVolum]];
        [cell.contentView addSubview:numerLB1];
        [numerLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-25);
            make.centerY.mas_equalTo(0);
        }];


    }else if (indexPath.section==1){
        NSArray* holders = @[@"修改绑定手机",@"修改密码"];
        UILabel* nameLB=[PosTool labelWithTextColr:@"0D0D0F" fontName:@"STHeitiSC-Light"fontSize:16 defaultText:holders[indexPath.row]];
        [cell.contentView addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            UILabel  *phoneLB=[[UILabel alloc]init];
            kUserData;
            phoneLB.text= userInfo.phone;
            phoneLB.textColor = kRGB_HEX(0x0D0D0F);
            phoneLB.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:phoneLB];
            [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(0);
            }];
        }
        
    }else{
        
        NSArray* holders = @[@"关于我们",@"客服热线",@"用户反馈"];
        UILabel* nameLB=[PosTool labelWithTextColr:@"0D0D0F" fontName:@"STHeitiSC-Light"fontSize:16 defaultText:holders[indexPath.row]];
        [cell.contentView addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    
    
}
//退出登录操作
-(void)cashout:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
  #pragma mark - 退出登录
        kUserData;
        userInfo.LoginType = @"114690";   // 是否登录的条件改变
        [UserInfoTool saveAccount:userInfo];
        LoginViewController * loginVC = [LoginViewController viewControllerFromNib];

        [JPUSHService setAlias:@"0" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        } seq:0];
        NSSet * setS = [NSSet setWithObject:@"0"];
        [JPUSHService setTags:setS completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        } seq:0];

        YMNavgatinController * navLiginVC = [[YMNavgatinController alloc] initWithRootViewController:loginVC];
        [UIView animateWithDuration:0.2f animations:^{
            [UIApplication sharedApplication].keyWindow.rootViewController =navLiginVC ;
        }];
    
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:skipAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
}

-(void)tagsAliasCallback {
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // MARK: ------ 清除缓冲存 ------
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
                //定时器 2s 后显示提示语
                [[RACScheduler mainThreadScheduler]afterDelay:2.f schedule:^{
                    
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    [XXProgressHUD showSuccess:@"清除缓存成功"];
                }];
            }];
            dispatch_async(
                           dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                           , ^{
                               
                               NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                               NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                               
                               for (NSString *p in files) {
                                   NSError *error;
                                   NSString *path = [cachPath stringByAppendingPathComponent:p];
                                   if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   }
                               }
                           });
            

            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:skipAction];
        [self presentViewController:alertController animated:YES completion:nil];


    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            OldPhoneViewController *vc=[[OldPhoneViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row==1){
            //修改密码
            OldPasswordViewController *vc=[[OldPasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //关于我们
        if (indexPath.row==0) {
            AboutUsViewController *vc=[[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row==1){
            [XXHelper makePhoneCallWithTelNumber:@"10086"];
        }else{
            
            AdviceViewController *vc=[[AdviceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}



-(void)clearCacheSuccess
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"缓存清理成功！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [alertView show];
    });
}


#pragma mark - 计算出图片缓存的大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

@end
