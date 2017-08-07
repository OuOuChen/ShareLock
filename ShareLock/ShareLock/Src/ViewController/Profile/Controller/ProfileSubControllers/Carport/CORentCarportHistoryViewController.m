//
//  CORentCarportHistoryViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/25.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportHistoryViewController.h"
#import "COEzStopCell.h"
#import "WRNavigationBar.h"
#import "COSettingBankInfoViewController.h"
#import "COEarningsCell.h"

@interface CORentCarportHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;
@property (nonatomic ,strong)  UILabel *titleLable;
@property (nonatomic ,strong)  UIButton *settingBtn;



@property (nonatomic ,assign)  int page ;

@end

@implementation CORentCarportHistoryViewController

#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,170+64, kScreenWidth, kScreenHeight-50-170-64) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"暂无收益~";
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor whiteColor];
        [self.tableview registerNib:[UINib nibWithNibName:@"COEzStopCell" bundle:nil]  forCellReuseIdentifier:kCOEzStopCellIdentify];
        
        
    }
    return _tableview;
}

#pragma mark-生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showCustomNavigationBackWrite];

    self.title = [NSString stringWithFormat:@"%d/%d月收益详情",_model.year,_model.month];
    

    self.dataSource = [[NSMutableArray alloc] init];
    
    [self setupHeaderView];
    [self.view addSubview:self.tableview];
    [self setupFooterView];


    
    
    
    //设置下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.tableview.mj_header beginRefreshing];
    
    //设置上拉加载更多
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    // 设置导航栏标题颜色
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self getNewData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:1];
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = kLineHeight;
    bottomLineLayer.borderColor = kLineColor.CGColor;
    bottomLineLayer.frame = CGRectMake(0, 0, kScreenWidth, 1);
    [footerView.layer addSublayer:bottomLineLayer];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingBtn.frame = CGRectMake(kLeftSpace, 5, kScreenWidth - 2*kLeftSpace, 40);
    _settingBtn.backgroundColor = kRedColor;
    [_settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _settingBtn.titleLabel.font = kFontSizeThree;
    [_settingBtn addTarget:self action:@selector(withdrawClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_settingBtn];
    
    
    [self.view addSubview:footerView];
    [self reloadBtnStatus];
    
}


-(void)reloadBtnStatus{
    if (_model.status == EarningsStatusNoWithdraw) {//提现
        [_settingBtn setTitle:@"我要提现" forState:UIControlStateNormal];
        _settingBtn.enabled = YES;
        _settingBtn.alpha = 1.0;
        
    }else if (_model.status == EarningsStatusAppleWithdraw){//申请提现中
        [_settingBtn setTitle:@"申请提现中" forState:UIControlStateNormal];
        _settingBtn.enabled = NO;
        _settingBtn.alpha = 0.6;
    }else{
        [_settingBtn setTitle:@"提现已完成" forState:UIControlStateNormal];
        _settingBtn.enabled = NO;
        _settingBtn.alpha = 0.6;
    }
}
//设置头部视图
-(void)setupHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 170+64)];
    headerView.backgroundColor = kRedColor;
    [self.view addSubview:headerView];
    
    CGFloat yPos = kNaigationBarHeight;
    yPos += 30;

    
    yPos += 10;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
//    _titleLable.text = [NSString stringWithFormat:@"%0.2f元",self.model.income/100];
    _titleLable.font = [UIFont boldSystemFontOfSize:40.0];
    [headerView addSubview:_titleLable];
    
    //初始化NSMutableAttributedString
    NSString *str1 = [NSString stringWithFormat:@"%0.2f",self.model.income/100];
    NSString *str2 = @"(元)";
    NSString *mark = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:mark];
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, str1.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str1.length)];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:kFontSizeFour range:NSMakeRange(str1.length,str2.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:NSMakeRange(str1.length,str2.length)];
    
    _titleLable.attributedText = attrStr;
    
    
    
    yPos += 40;
    yPos += 10;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-网络请求

#pragma mark - network

-(void)getNewData{
    self.page = 1;
    
    
    [[BusinessManager sharedManager].parkingLockManager requestLockBusinessWithLockId:self.lock_id year:self.model.year month:self.model.month page:self.page success:^(NSDictionary *dict) {
        [self.tableview.mj_header endRefreshing];
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COResponseEzStopModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"]afterDelay:1];

        }
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:[ProgressHUD tipFromError:error] afterDelay:1];
    }];
    


    
}

-(void)getMoreData{
    
    
    [[BusinessManager sharedManager].parkingLockManager requestLockBusinessWithLockId:self.lock_id year:self.model.year month:self.model.month page:self.page + 1 success:^(NSDictionary *dict) {
        [self.tableview.mj_footer endRefreshing];
        
        if ([dict[@"ret"] intValue] == 0) {
            
            NSArray *moreArr = [COResponseEzStopModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            if (moreArr.count > 0) {
                self.page ++;
                [self.dataSource addObjectsFromArray:moreArr];
                [self.tableview reloadData];
            }
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:[ProgressHUD tipFromError:error] afterDelay:1];
    }];
    
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COEzStopCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOEzStopCellIdentify];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
    
    return cell;
    
}

#pragma mark-提现

- (void)withdrawClicked:(UIButton *)sender{
    
    if (kUserInfoModel.bank_name.length > 0  && kUserInfoModel.bank_name.length > 0 ) {
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:@"正在提现" isTouched:NO inView:self.view];
        [[BusinessManager sharedManager].parkingLockManager requesWithdrawWithProfitId:_model.profit_id success:^(NSDictionary *dict) {
            [ProgressHUD hideProgress:self.view];
            if ([dict[@"ret"] intValue] == 0) {
//                [self.navigationController popViewControllerAnimated:YES];
                _model.status = EarningsStatusAppleWithdraw;
                [self reloadBtnStatus];

            }
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
            
        } failure:^{
            [ProgressHUD hideProgress:self.view];
            
        }];
    }else{
        COSettingBankInfoViewController *ctr = [[COSettingBankInfoViewController alloc]init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
    
}



@end
