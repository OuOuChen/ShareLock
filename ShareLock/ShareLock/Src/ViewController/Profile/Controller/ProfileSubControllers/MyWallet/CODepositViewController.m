//
//  CODepositViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/27.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CODepositViewController.h"
#import "CODepositSuccessViewController.h"

@interface CODepositViewController ()

@end

@implementation CODepositViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"押金";
    [self setupView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化子视图

-(void)setupView{
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNaigationBarHeight, kScreenWidth, kScreenHeight)];
    bgImageView.image = [UIImage imageNamed:@"deposit_bg"];
    [self.view addSubview:bgImageView];
    
    
    CGFloat yPos = 100;
    
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 20)];
    descLable.textColor = kMinorFontColor;
    descLable.textAlignment = NSTextAlignmentCenter;
    descLable.text = @"已交纳押金(元)";
    descLable.font = kFontSizeFour;
    [bgImageView addSubview:descLable];
    
    yPos += 20;
    yPos += 10;

    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    titleLable.textColor = kThemeColor;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = [NSString stringWithFormat:@"199"];
    titleLable.font = [UIFont boldSystemFontOfSize:40.0];
    [bgImageView addSubview:titleLable];
    
    yPos += 40;
    yPos += 10;
    


    
    
    [self setupFooterView];
    
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = [UIColor clearColor];
    [settingBtn setTitle:@"押金退款" forState:UIControlStateNormal];
    [settingBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeTwo;
    [settingBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    [self.view addSubview:footerView];
    
}

#pragma mark-押金退款

-(void)payAction:(UIButton *)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定申请押金退款吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DDLogVerbose(@"buttonIndex:%d",buttonIndex);
    if (buttonIndex == 1) {//确定
        [ProgressHUD shwoProgress:self.view];

        [[BusinessManager sharedManager].parkingLockManager requestApplyDrawback:^(NSDictionary *dict) {
            [ProgressHUD  hideProgress:self.view];
            if ([dict[@"ret"] intValue] == 0) {
                CODepositSuccessViewController *ctr = [[CODepositSuccessViewController alloc]init];
                [self.navigationController pushViewController:ctr animated:YES];            }
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        } failure:^{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:@"请求失败" afterDelay:1];

            [ProgressHUD hideProgress:self.view];



        }];
        

    }
}





@end
