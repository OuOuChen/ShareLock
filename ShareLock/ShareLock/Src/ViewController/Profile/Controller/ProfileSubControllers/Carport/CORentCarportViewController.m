//
//  CORentCarportViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportViewController.h"
#import "COCarportListCell.h"
#import "CORentCarportNewViewController.h"
#import "CORentCarportSettingViewController.h"
#import "CORentCarportEarningsViewController.h"
#import "CORentCarportShareEarningsViewController.h"


@interface CORentCarportViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@end

@implementation CORentCarportViewController

#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-80) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"这里什么都没有，去看看别的吧~";
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = kBlcokColor;
        
    }
    return _tableview;
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"申请共享锁" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(appleAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    [self.view addSubview:footerView];
    
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
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    [self setupFooterView];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"COCarportListCell" bundle:nil]  forCellReuseIdentifier:kCOCarportListCellIdentify];

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
    [[BusinessManager sharedManager].parkingLockManager requestViewShare:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            self.dataSource = [COViewShareModel mj_objectArrayWithKeyValuesArray:dict[@"locks"]];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
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
    return 127;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COCarportListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCOCarportListCellIdentify];
    
    cell.model = self.dataSource[indexPath.section];
    if (cell.model.status != ShareStatusSubmit) {//已提交给平台
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    COViewShareModel *model =  self.dataSource[indexPath.section];

    if (model.status != ShareStatusSubmit) {
        CORentCarportShareEarningsViewController *ctr = [[CORentCarportShareEarningsViewController alloc]init];
        ctr.shareModelArray = self.dataSource;
        ctr.model = model;
        [self.navigationController pushViewController:ctr animated:YES
         ];
        
    }

}

@end
