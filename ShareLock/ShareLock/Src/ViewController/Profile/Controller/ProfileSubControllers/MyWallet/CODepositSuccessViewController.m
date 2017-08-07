//
//  CODepositSuccessViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/29.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CODepositSuccessViewController.h"

@interface CODepositSuccessViewController ()

@end

@implementation CODepositSuccessViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"押金退款";
    [self setupView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化子视图

-(void)setupView{
    
    CGFloat yPos = kNaigationBarHeight;
    yPos += 30;
    
    UIImage *image = [UIImage imageNamed:@"deposit_success_icon"];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-image.size.width)/2, yPos, image.size.width, image.size.height)];
    iconImageView.image = image;
    [self.view addSubview:iconImageView];
    
    yPos += image.size.height;
    yPos += 20;

    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"申请退款成功";
    titleLable.font = kFontSizeTwo;
    [self.view addSubview:titleLable];
    
    yPos += 40;
    yPos += 20;
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    descLable.textColor = [UIColor blackColor];
    descLable.textAlignment = NSTextAlignmentCenter;
    descLable.text = @"¥ 199";
    descLable.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:descLable];
    
    yPos += 40;
    yPos += 20;

    UILabel *typeLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    typeLable.textColor = kGrayColor;
    typeLable.textAlignment = NSTextAlignmentCenter;
    typeLable.font = kFontSizeFour;
    typeLable.text = @"退款将在1-7个工作日内到账";
    [self.view addSubview:typeLable];

    yPos += 40;
    yPos += 40;

    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, yPos, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    
    
}


#pragma mark-确定

-(void)okAction:(UIButton *)sender{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

}




@end
