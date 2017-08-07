//
//  COMyCouponViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COMyCouponViewController.h"
#import "COCouponCell.h"

@interface COMyCouponViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@property (nonatomic ,strong)  CORequestMyCouponModel *requestModel ;



@end

@implementation COMyCouponViewController

#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"这里什么都没有，去看看别的吧~";
        _tableview.delegate = self;
        _tableview.backgroundColor = kBlcokColor;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableview registerNib:[UINib nibWithNibName:@"COCouponCell" bundle:nil]  forCellReuseIdentifier:kCOCouponCellIdentify];

        
    }
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlcokColor;
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    self.requestModel =  [[CORequestMyCouponModel alloc]init];

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

#pragma mark - network

-(void)getNewData{
    self.requestModel.page = 1;
    self.requestModel.status = 1;
    [[BusinessManager sharedManager].parkingLockManager requestMyCouponListWithModel:self.requestModel success:^(NSDictionary *dict) {
        [self.tableview.mj_header endRefreshing];
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COResponseMyCouponModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
        }
    } failure:^{
        [self.tableview.mj_header endRefreshing];
    }];
    
}

-(void)getMoreData{

    self.requestModel.page ++;

    [[BusinessManager sharedManager].parkingLockManager requestMyCouponListWithModel:self.requestModel success:^(NSDictionary *dict) {
        [self.tableview.mj_footer endRefreshing];

        if ([dict[@"ret"] intValue] == 0) {
            
            NSArray *moreArr = [COResponseMyCouponModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            if (moreArr.count > 0) {
                [self.dataSource addObjectsFromArray:moreArr];
                [self.tableview reloadData];
            }else{
                self.requestModel.page --;
            }
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
            self.requestModel.page --;
        }
    } failure:^{
        [self.tableview.mj_footer endRefreshing];
        self.requestModel.page --;

    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOCouponCellIdentify];
    
    cell.model = self.dataSource[indexPath.section];
    
    
    return cell;
}


@end
