//
//  COMyWalletViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COMyWalletViewController.h"
#import "COMyWalletPayViewController.h"
#import "COyWalletPayHistoryViewController.h"
#import "CODepositViewController.h"
#import "COMyWalletDepositViewController.h"

@interface COMyWalletViewController ()

@property (nonatomic ,strong)  NSMutableArray *dataSource;

@end

@implementation COMyWalletViewController

#pragma mark - 懒加载



#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupView];
    [self showCustomNavigationRightButtonWithTitle:@"充值历史" image:nil hightlightImage:nil];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view clearSubviews];

    //请求用户信息
    [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            [self setupView];
        }
    } failure:^{
        
    }];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:kRedColor] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:kRedColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化子视图

-(void)setupView{
    CGFloat yPos = kNaigationBarHeight;
    yPos += 100;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = [NSString stringWithFormat:@"%0.2f元",kUserInfoModel.balance];
    titleLable.font = [UIFont boldSystemFontOfSize:40.0];
    [self.view addSubview:titleLable];
    
    yPos += 40;
    yPos += 10;
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 20)];
    descLable.textColor = kMinorFontColor;
    descLable.textAlignment = NSTextAlignmentCenter;
    descLable.text = @"我的余额(元)";
    descLable.font = kFontSizeFour;
    [self.view addSubview:descLable];
    
    yPos += 50;
    
    UIView *yaJinBg = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 50)];
    yaJinBg.userInteractionEnabled = YES;
    [self.view addSubview:yaJinBg];
    
    // 添加手势
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(depositClick)];
    [yaJinBg addGestureRecognizer:tapGestureRec];
    
    UILabel *yaJinLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, 0, 100, 50)];
    yaJinLable.textColor = kMainFontColor;
    yaJinLable.textAlignment = NSTextAlignmentLeft;
    yaJinLable.text = @"押金";
    yaJinLable.font = kFontSizeThree;
    [yaJinBg addSubview:yaJinLable];
    
    
    
    
    UIImage *image = [UIImage imageNamed:@"more_icon"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-image.size.width-kLeftSpace, (50-image.size.height)/2, image.size.width, image.size.height)];
    imageView.image = image;
    [yaJinBg addSubview:imageView];
    
    UILabel *typeLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)-100-10, 0, 100, 50)];
    typeLable.textColor = kGrayColor;
    typeLable.textAlignment = NSTextAlignmentRight;
    typeLable.font = kFontSizeFour;
    [yaJinBg addSubview:typeLable];
    if (kUserInfoModel.deposited == 1) {//已经交纳押金
        typeLable.text = @"已交押金";
    }else{
        typeLable.text = @"未交押金";
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kLeftSpace, 49, kScreenWidth- 2*kLeftSpace, 1)];
    line.backgroundColor = kLineColor;
    [yaJinBg addSubview:line];
    yPos += 50;

    
    [self setupFooterView];
    
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"去充值" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    [self.view addSubview:footerView];
    
}

#pragma mark-充值

-(void)payAction:(UIButton *)sender{
    
    COMyWalletPayViewController *ctr = [[COMyWalletPayViewController alloc]init];
    [self.navigationController pushViewController:ctr animated:YES];
}


#pragma mark-充值历史
- (void)onNavigationRightFirstButtonClicked:(UIButton *)sender {
    COyWalletPayHistoryViewController *ctr = [[COyWalletPayHistoryViewController alloc]init];
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark-押金
-(void)depositClick{
    if (kUserInfoModel.deposited == 1) {//已经交纳押金
        CODepositViewController  *ctr = [[CODepositViewController alloc]init];
        [self.navigationController pushViewController:ctr animated:YES];
    }else{
        COMyWalletDepositViewController  *ctr = [[COMyWalletDepositViewController alloc]init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
}
@end
