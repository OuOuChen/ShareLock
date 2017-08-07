//
//  COMessageViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/11.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COMessageViewController.h"

@interface COMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;

@end

@implementation COMessageViewController


#pragma mark - 懒加载


- (UITableView *)tableview
{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.startTip = YES;
        _tableview.tipTitle = @"这里什么都没有，去看看别的吧~";
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的消息";
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell description]];
    }
    
    return cell;
}

@end
