//
//  COEzStopViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COEzStopViewController.h"
#import "COEzStopCell.h"

@interface COEzStopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@property (nonatomic ,assign)  int page ;


@end

@implementation COEzStopViewController

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
        _tableview.backgroundColor = kBlcokColor;
        [self.tableview registerNib:[UINib nibWithNibName:@"COEzStopCell" bundle:nil]  forCellReuseIdentifier:kCOEzStopCellIdentify];

        
    }
    return _tableview;
}

#pragma mark-生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    
    

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
    [[BusinessManager sharedManager].parkingLockManager requestRentHistoryListWithModel:self.page success:^(NSDictionary *dict) {
        [self.tableview.mj_header endRefreshing];
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COResponseEzStopModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        }
    } failure:^{
        [self.tableview.mj_header endRefreshing];
    }];
    
}

-(void)getMoreData{
    
    
    [[BusinessManager sharedManager].parkingLockManager requestRentHistoryListWithModel:self.page +1 success:^(NSDictionary *dict) {
        [self.tableview.mj_footer endRefreshing];
        
        if ([dict[@"ret"] intValue] == 0) {
            
            NSArray *moreArr = [COResponseEzStopModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            if (moreArr.count > 0) {
                self.page ++;
                [self.dataSource addObjectsFromArray:moreArr];
                [self.tableview reloadData];
            }
        }else{
            [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        }
    } failure:^{
        [self.tableview.mj_footer endRefreshing];
        
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


@end
