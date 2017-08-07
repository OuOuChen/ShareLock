//
//  COyWalletPayHistoryViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/24.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COyWalletPayHistoryViewController.h"
#import "COPayHistoryCell.h"

@interface COyWalletPayHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@property (nonatomic ,assign)  int page ;

@end

@implementation COyWalletPayHistoryViewController

#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"这里什么都没有，去看看别的吧~";
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableview registerNib:[UINib nibWithNibName:@"COPayHistoryCell" bundle:nil]  forCellReuseIdentifier:kCOPayHistoryCelldentify];

        
    }
    return _tableview;
}

#pragma mark-生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    self.title = @"充值历史";
    
    
    //设置下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.tableview.mj_header beginRefreshing];
    
    //设置上拉加载更多
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-网络请求

-(void)getNewData{
    self.page = 1;
    [[BusinessManager sharedManager].parkingLockManager requestGetRechargeOrderListWithModel:self.page success:^(NSDictionary *dict) {
        [self.tableview.mj_header endRefreshing];
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COPayHistoryModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        }
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:[ProgressHUD tipFromError:error] afterDelay:1];

    }];
    
}

-(void)getMoreData{
    
    
    [[BusinessManager sharedManager].parkingLockManager requestGetRechargeOrderListWithModel:self.page +1 success:^(NSDictionary *dict) {
        [self.tableview.mj_footer endRefreshing];
        
        if ([dict[@"ret"] intValue] == 0) {
            
            NSArray *moreArr = [COPayHistoryModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            if (moreArr.count > 0) {
                self.page ++;
                [self.dataSource addObjectsFromArray:moreArr];
                [self.tableview reloadData];
            }
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        }
    } failure:^(NSError *error) {
        [self.tableview.mj_footer endRefreshing];
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


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
    COPayHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOPayHistoryCelldentify];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
    
    return cell;
    
}

@end
