//
//  COUseSuccessViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/31.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COUseSuccessViewController.h"

@interface COUseSuccessViewController ()

@end

@implementation COUseSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"租用结束";
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
    
    UIImage *image = [UIImage imageNamed:@"user_lock_sucess"];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-image.size.width)/2, yPos, image.size.width, image.size.height)];
    iconImageView.image = image;
    [self.view addSubview:iconImageView];
    
    yPos += image.size.height;
    yPos += 20;
    
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 20)];
    titleLable.textColor =kMainFontColor;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = [NSString stringWithFormat:@"成功支付:%0.2f元",self.mode.recharge/100];
    titleLable.font = kFontSizeTwo;
    [self.view addSubview:titleLable];
    
    yPos += 20;
    yPos += 20;
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 20)];
    descLable.textColor = kMainFontColor;
    descLable.textAlignment = NSTextAlignmentCenter;
    descLable.text =  [NSString stringWithFormat:@"租锁时间:%@",[self getRentTime]];
    descLable.font = kFontSizeTwo;
    [self.view addSubview:descLable];
    
    yPos += 20;
    yPos += 60;
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, yPos, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    
    
}

-(NSString *)getRentTime{
    int totolMinute = self.mode.rent_time;
    int hour = totolMinute /60;
    int minute = totolMinute %60;
    NSString *timeStr = [NSString stringWithFormat:@"%d小时%d分钟",hour,minute];
    return timeStr;
}

#pragma mark-确定

-(void)okAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
