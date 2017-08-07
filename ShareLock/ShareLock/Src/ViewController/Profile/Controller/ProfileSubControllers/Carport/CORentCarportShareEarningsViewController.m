//
//  CORentCarportShareEarningsViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/8/3.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportShareEarningsViewController.h"
#import "COCarportListCell.h"
#import "CORentCarportNewViewController.h"
#import "CORentCarportSettingViewController.h"
#import "CORentCarportEarningsViewController.h"
#import "WRNavigationBar.h"
#import "COEzStopCell.h"
#import "YJSelectionView.h"

@interface CORentCarportShareEarningsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)  UITableView *tableview;
@property (nonatomic ,strong)  NSMutableArray *dataSource;
@property (nonatomic ,strong)  UILabel *titleLable;



@property (nonatomic ,assign)  double totoal;



@end

@implementation CORentCarportShareEarningsViewController

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
        _tableview.backgroundColor = kBlcokColor;
        [self.tableview registerNib:[UINib nibWithNibName:@"COEzStopCell" bundle:nil]  forCellReuseIdentifier:kCOEzStopCellIdentify];

        
    }
    return _tableview;
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    footerView.userInteractionEnabled = YES;
    footerView.backgroundColor = [UIColor whiteColor];
    
    // 添加手势
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyClick)];
    [footerView addGestureRecognizer:tapGestureRec];
    
    
    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = kLineHeight;
    bottomLineLayer.borderColor = kLineColor.CGColor;
    bottomLineLayer.frame = CGRectMake(0, 0, kScreenWidth, 1);
    [footerView.layer addSublayer:bottomLineLayer];
    
    UIImage *icon = [UIImage imageNamed:@"menu_lock"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftSpace, (50-icon.size.height)/2, icon.size.width, icon.size.height)];
    imageView.image = icon;
    [footerView addSubview:imageView];
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+15, 0, 100, 50)];
    descLable.textColor = kGrayColor;
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.text = @"历史收益";
    descLable.font = kFontSizeFour;
    [footerView addSubview:descLable];
    
    
    UIImage *imageMore = [UIImage imageNamed:@"more_icon"];
    UIImageView *imageMoreView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-imageMore.size.width-kLeftSpace, (50-imageMore.size.height)/2, imageMore.size.width, imageMore.size.height)];
    imageMoreView.image = imageMore;
    [footerView addSubview:imageMoreView];
    
    [self.view addSubview:footerView];
    
    
}

-(void)setupHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 170+64)];
    headerView.backgroundColor = kRedColor;
    [self.view addSubview:headerView];
    
    CGFloat yPos = kNaigationBarHeight;
    yPos += 30;
    
    UILabel *descLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 20)];
    descLable.textColor = [UIColor whiteColor];
    descLable.textAlignment = NSTextAlignmentCenter;
    descLable.text = @"本月收益(元)";
    descLable.font = kFontSizeFour;
    [headerView addSubview:descLable];
    
    yPos += 20;
    yPos += 10;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, kScreenWidth - 2 * kLeftSpace, 40)];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = [NSString stringWithFormat:@"%0.2f元",self.totoal/100];
    _titleLable.font = [UIFont boldSystemFontOfSize:40.0];
    [headerView addSubview:_titleLable];
    
    yPos += 40;
    yPos += 10;
    

    
    
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
    
    [self showCustomNavigationBackWrite];

    [self showCustomNavigationRightButtonWithTitleColor:@"设置" image:nil hightlightImage:nil withColor:[UIColor whiteColor]];

    
//    self.title = [self getTitleStr];
    [self showCustomNavigationMiddeTitleButton:[self getTitleStr]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableview];
    
    [self setupHeaderView];
    [self setupFooterView];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"COCarportListCell" bundle:nil]  forCellReuseIdentifier:kCOCarportListCellIdentify];
    [self.shareModelArray addObject:@"添加新的车位锁"];

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getNewData{
    
    [[BusinessManager sharedManager].parkingLockManager requesCurProfitWithLockId:_model.lock_id success:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            if (![dict[@"total"] isKindOfClass:[NSNull class]]) {
                self.totoal = [dict[@"total"] doubleValue];

            }
            self.dataSource = [COShareEarningsModel mj_objectArrayWithKeyValuesArray:dict[@"lists"]];
            _titleLable.text = [NSString stringWithFormat:@"%0.2f元",self.totoal/100];
            [self.tableview reloadData];
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
        }    } failure:^{
        
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
    cell.shareEarningsModel = self.dataSource[indexPath.row];
    cell.orderNoLable.text = [NSString stringWithFormat:@"NO.%@",_model.lock_id != nil ? _model.lock_id : @""];

    
    return cell;
    
    
    return cell;
    
}


#pragma mark-历史账单

-(void)historyClick{
    CORentCarportEarningsViewController *ctr = [[CORentCarportEarningsViewController alloc]init];
    ctr.model = _model;
    [self.navigationController pushViewController:ctr animated:YES
     ];
    
}

#pragma mark-设置
- (void)onNavigationRightFirstButtonClicked:(UIButton *)sender {

    
    CORentCarportSettingViewController *setting = [[CORentCarportSettingViewController alloc]init];
    setting.model = self.model;
    [self.navigationController pushViewController:setting animated:YES];
    
    
}

#pragma mark-选择车位锁
- (void)onNavigationMiddleButtonTitleClicked:(UISegmentedControl *)sender
{

    __weak typeof(self) weakSelf = self;
    [YJSelectionView showWithTitle:@"选择车位锁" options:self.shareModelArray singleSelection:YES delegate:self inView:self.navigationController.view completionHandler:^(NSInteger index, NSArray *array) {
        NSLog(@"%ld", index);
        id object = array[index];
        if ([object isKindOfClass:[COViewShareModel class]]) {
            
            weakSelf.model = object;
            [weakSelf showCustomNavigationMiddeTitleButton:[weakSelf getTitleStr]];
            [weakSelf getNewData];

        }else{//申请共享锁
            CORentCarportNewViewController *ctr = [[CORentCarportNewViewController alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
        }

    }];
}



#pragma mark-others

//获取车锁尾号
-(NSString *)getTitleStr{
    
    NSString  *a = _model.lock_id;
    NSString *b = @"";
    NSInteger leng = a.length;
    if (leng>=4) {
        b = [a substringFromIndex:leng-4];
    }
    b = [NSString stringWithFormat:@"车锁尾号%@",b];
    return b;
}



@end
