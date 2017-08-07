//
//  CORentCarportEarningsViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/29.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportEarningsViewController.h"
#import "COCarportListCell.h"
#import "CORentCarportNewViewController.h"
#import "CORentCarportSettingViewController.h"

#import "COEarningsCell.h"
#import "CORentCarportHistoryViewController.h"
#import "YBPopupMenu.h"
#import "COSettingBankInfoViewController.h"

@interface CORentCarportEarningsViewController ()<YBPopupMenuDelegate,COEarningsCellDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@property (nonatomic, strong) YBPopupMenu *popupMenu;

@end

@implementation CORentCarportEarningsViewController

#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"暂无收益~";
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = kBlcokColor;
        
    }
    return _tableview;
}


#pragma mark-按钮事件

-(void)appleAction:(UIButton *)sender{
    CORentCarportNewViewController *ctr = [[CORentCarportNewViewController alloc]init];
    [self.navigationController pushViewController:ctr animated:YES];
    
}

#pragma mark - 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = kBlcokColor;
    self.title = @"车位收益";
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"COEarningsCell" bundle:nil]  forCellReuseIdentifier:kCOEarningsCellIdentify];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getNewData{
    
    [[BusinessManager sharedManager].parkingLockManager requestProfitWithLockId:_model.lock_id success:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COEarningsModel mj_objectArrayWithKeyValuesArray:dict[@"datas"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        }
    } failure:^{
        
    }];
    

    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COEarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOEarningsCellIdentify];
    cell.delegate = self;
    
    cell.model = self.dataSource[indexPath.section];

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    COEarningsModel *model = self.dataSource[indexPath.section];

    CORentCarportHistoryViewController *ctr = [[CORentCarportHistoryViewController alloc]init];
    ctr.lock_id = self.model.lock_id;
    ctr.model = model;
    [self.navigationController pushViewController:ctr animated:YES];
    
    
    
}

#pragma mark - COEarningsCellDelegate

// 提现
- (void)withdrawClicked:(COEarningsCell *)itemCell{
    
    if (kUserInfoModel.bank_name.length > 0  && kUserInfoModel.bank_name.length > 0 ) {
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:@"正在提现" isTouched:NO inView:self.view];
        [[BusinessManager sharedManager].parkingLockManager requesWithdrawWithProfitId:itemCell.model.profit_id success:^(NSDictionary *dict) {
            [ProgressHUD hideProgress:self.view];
            if ([dict[@"ret"] intValue] == 0) {
                [self getNewData];
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

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if (index == 0) {//运营设置
        
    }else{//价格设置
        CORentCarportSettingViewController *setting = [[CORentCarportSettingViewController alloc]init];
        setting.model = self.model;
        [self.navigationController pushViewController:setting animated:YES];
    }
    
}



@end
