//
//  COMyWalletDepositViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/26.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COMyWalletDepositViewController.h"
#import "COPayTypeCell.h"
#import "COPayTypeModel.h"
#import "CORealNameViewController.h"
#import "WRNavigationBar.h"
#import "COMyWalletViewController.h"
#import "ZXNPublicBicycleController.h"


@interface COMyWalletDepositViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
/** 支付类型集合 */
@property (nonatomic ,strong) NSMutableArray *payTypeArray;
/** 支付类型 */
@property (nonatomic ,assign) PayType payType;

@property (weak, nonatomic) IBOutlet UIButton *settingBtn;


@end

@implementation COMyWalletDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"押金充值";
    [self showCustomNavigationBackWrite];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self setupView];
    
    
    self.payType = PAY_TYPE_WECHAT;
    [self reloadPayBtn];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    // 设置导航栏标题颜色
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:1];
}



//返回
- (void)onNavigationBackButtonClicked:(UIButton *)sender {
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *controller in viewControllers) {
        if ([controller isKindOfClass:[COMyWalletViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }else if ([controller isKindOfClass:[ZXNPublicBicycleController class]]){
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


//获取数据
-(void)getData{
    _payTypeArray = [NSMutableArray arrayWithCapacity:2];
    
    COPayTypeModel *model1 = [[COPayTypeModel alloc]init];
    model1.payType = PAY_TYPE_WECHAT;
    model1.title = @"微信";
    model1.icon = @"user_deposit_wechat";
    
    COPayTypeModel *model2 = [[COPayTypeModel alloc]init];
    model2.payType = PAY_TYPE_ALIPAY;
    model2.title = @"支付宝";
    model2.icon = @"user_deposit_alipay";
    
    [_payTypeArray addObject:model1];
    [_payTypeArray addObject:model2];
    
}
-(void)setupView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 170)];
    headerView.backgroundColor = kThemeColor;
    [self.view addSubview:headerView];

    
    //流程背景视图
    UIView *flowBg = [[UIView alloc]initWithFrame:CGRectMake(20, 40, kScreenWidth-40, 60)];
    flowBg.backgroundColor = [UIColor clearColor];
    [headerView addSubview:flowBg];
    
    
    CGFloat yPos = 60;
    CGFloat width = (kScreenWidth-40)/4;
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((width-22)/2+6, yPos+11, kScreenWidth-40-(width-22)-6, 2)];
    lineView.backgroundColor = kLineColor;
    [flowBg addSubview:lineView];
    
    UIImageView *flowImage1 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2, yPos, 22, 22)];
    flowImage1.image = [UIImage imageNamed:@"user_ attestation_finish"];
    [flowBg addSubview:flowImage1];
    
    UIImageView *flowImage2 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+width, yPos, 22, 22)];
    flowImage2.image = [UIImage imageNamed:@"user_ attestation_stating"];
    [flowBg addSubview:flowImage2];
    
    
    UIImageView *flowImage3 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+2*width, yPos, 22, 22)];
    flowImage3.image = [UIImage imageNamed:@"user_ attestation_nostating"];
    [flowBg addSubview:flowImage3];
    
    
    UIImageView *flowImage4 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+3*width, yPos, 22, 22)];
    flowImage4.image = [UIImage imageNamed:@"user_ attestation_nostating"];
    [flowBg addSubview:flowImage4];
    
    yPos += 22;
    yPos += 15;
    

    //手机验证
    UILabel *flowLable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, width, 14)];
    flowLable1.font = kFontSizeFour;
    flowLable1.textColor = [UIColor whiteColor];
    flowLable1.textAlignment = NSTextAlignmentCenter;
    flowLable1.text = @"手机验证";
    [flowBg addSubview:flowLable1];
    
    //押金充值
    UILabel *flowLable2 = [[UILabel alloc]initWithFrame:CGRectMake(width, yPos, width, 14)];
    flowLable2.font = kFontSizeFour;
    flowLable2.textColor = [UIColor whiteColor];
    flowLable2.textAlignment = NSTextAlignmentCenter;
    flowLable2.text = @"押金充值";
    [flowBg addSubview:flowLable2];
    
    //实名认证
    UILabel *flowLable3 = [[UILabel alloc]initWithFrame:CGRectMake(2*width, yPos, width, 14)];
    flowLable3.font = kFontSizeFour;
    flowLable3.textColor = [UIColor whiteColor];
    flowLable3.textAlignment = NSTextAlignmentCenter;
    flowLable3.text = @"实名认证";
    [flowBg addSubview:flowLable3];
    
    
    //注册完成
    UILabel *flowLable4 = [[UILabel alloc]initWithFrame:CGRectMake(3*width, yPos, width, 14)];
    flowLable4.font = kFontSizeFour;
    flowLable4.textColor = [UIColor whiteColor];
    flowLable4.textAlignment = NSTextAlignmentCenter;
    flowLable4.text = @"注册完成";
    [flowBg addSubview:flowLable4];
    
    
    //押金
    UILabel *yaJing = [[UILabel alloc]initWithFrame:CGRectMake(kLeftSpace, CGRectGetMaxY(headerView.frame), 100, 50)];
    yaJing.font = kFontSizeFour;
    yaJing.textColor = kMainFontColor;
    yaJing.textAlignment = NSTextAlignmentLeft;
    yaJing.text = @"押金（可退）";
    [self.view addSubview:yaJing];
    
    //金额
    UILabel *jingE = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-180-kLeftSpace, CGRectGetMaxY(headerView.frame), 180, 50)];
    jingE.font = kFontSizeOne;
    jingE.textColor = kMainFontColor;
    jingE.textAlignment = NSTextAlignmentRight;
    jingE.text = @"¥199.00";
    [self.view addSubview:jingE];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kLeftSpace, CGRectGetMaxY(jingE.frame), kScreenWidth- 2*kLeftSpace, kLineHeight)];
    line.backgroundColor = kLineColor;
    [self.view addSubview:line];
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(line.frame), kScreenWidth, 128) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.scrollEnabled = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"COPayTypeCell" bundle:nil]  forCellReuseIdentifier:kCOPayTypeCellIdentify];

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-按钮事件

//改变充值状态
-(void)reloadPayBtn{
    if (self.payType > 0 ) {
        _settingBtn.backgroundColor = kThemeColor;
        _settingBtn.enabled = YES;
        
    }else{
        _settingBtn.backgroundColor = kBlcokColor;
        _settingBtn.enabled = NO;
        
    }
}


//充值
-(void)payAction:(UIButton *)sender{
    [ProgressHUD shwoProgress:self.view];
    [[BusinessManager sharedManager].parkingLockManager requestCreateDepositOrderWithType:self.payType success:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            
            //更新用户信息
            [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict2) {
                if ([dict[@"ret"] intValue] == 0) {
                    [ProgressHUD  hideProgress:self.view];

                    if (kUserInfoModel.authentication == 0) {//未实名认证
                        CORealNameViewController *forgetPasswordVC = [[CORealNameViewController alloc] init];
                        [self.navigationController pushViewController:forgetPasswordVC animated:YES];
                    }else{
                        [self onNavigationBackButtonClicked:nil];
                    }
                }

            } failure:^{
                [ProgressHUD  hideProgress:self.view];
            }];


        }else{
            [ProgressHUD  hideProgress:self.view];

        }
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
    } failure:^{
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:@"请求失败" afterDelay:1];
        
        [ProgressHUD hideProgress:self.view];
    }];
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _payTypeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOPayTypeCellIdentify];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.payTypeArray[indexPath.row];
    if (self.payType == cell.model.payType) {
        cell.selectStata.image = [UIImage imageNamed:@"user_deposit_selected"];
    }else{
        cell.selectStata.image = [UIImage imageNamed:@"user_deposit_unselected"];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kLeftSpace, 49, kScreenWidth- 2*kLeftSpace, 1)];
    line.backgroundColor = kLineColor;
    [cell.contentView addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    COPayTypeModel *model1 = self.payTypeArray[indexPath.row];
    self.payType = model1.payType;
    [self.tableview reloadData];
    [self reloadPayBtn];
    
}

@end
