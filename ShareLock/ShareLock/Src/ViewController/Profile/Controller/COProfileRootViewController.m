//
//  COProfileRootViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COProfileRootViewController.h"
#import "COMyWalletViewController.h"
#import "COEzStopViewController.h"
#import "CORentCarportViewController.h"
#import "COFeedbackViewController.h"
#import "COMyCouponViewController.h"
#import "COProfileItemModel.h"
#import "COProfileCell.h"
#import "COPushBaseViewController.h"
#import "COAnimateViewController.h"
#import "COSettingViewController.h"
#import "COBaseNavigationController.h"
#import "COProfileInfoViewController.h"
#import "CORealNameViewController.h"
#import "COCarportListCell.h"
#import "CORentCarportShareEarningsViewController.h"


@interface COProfileRootViewController ()<UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** headerIcon */
//@property (nonatomic, weak) UIImageView *headerIcon;

/** footerView */
@property (nonatomic, strong) UIView *footerView;

/** data */
@property (nonatomic, strong) NSArray *data;

@end

@implementation COProfileRootViewController

static UIWindow *window_;
/**
 * 根据底部控制器展示
 */
+ (void)showWithRootViewController:(UIViewController *)rootViewController {
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.backgroundColor = [UIColor clearColor];
    window_.hidden = NO;
    
    COAnimateViewController *vc = [[COAnimateViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.rootViewController = rootViewController;
    COBaseNavigationController *nav = [[COBaseNavigationController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor clearColor];
    window_.rootViewController = nav;
    [window_ addSubview:nav.view];
}

/**
 * 隐藏
 */
+ (void)hide {
    window_.hidden = YES;
    window_.rootViewController = nil;
    window_ = nil;
}

#pragma mark-网络数据

-(void)loadNewData{
    //请求用户信息
    [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            [self setupData];
            [self setupHeaderView];
            
        }
    } failure:^{
        
    }];
}

#pragma mark-懒加载

- (NSArray *)data {
    if (!_data) {
        self.data = [NSArray array];
    }
    return _data;
}

#pragma mark-生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    
    //设置头部视图
    [self setupHeaderView];
    //设置底部视图
    [self setFooterViewFrame];
    //设置初始化数据
    [self setupData];
    //获取网络数据
    [self loadNewData];

}



- (void)setupTableUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    self.footerView = [[UIView alloc]init];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footerView];
    


}

-(void)setupHeaderView{
    UIView *headerView = [[UIView alloc] init];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = kRGB(245, 247, 250);
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
    self.tableView.tableHeaderView = headerView;
    
    // 添加两个手势
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalDetailsClick)];
    [headerView addGestureRecognizer:tapGestureRec];
    
    
    /** 头像图片 */
    
    NSURL *imageUrl =  [NSURL URLWithString:kUserInfoModel.img_url];
    UIImageView *headerIcon = [[UIImageView alloc] init];
    [headerIcon sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"avatar_login"]];
    headerIcon.frame = CGRectMake(15, 39, 72, 72);
    headerIcon.layer.cornerRadius = 36;
    headerIcon.clipsToBounds = YES;
    [headerView addSubview:headerIcon];
    
    
    // 手机号
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerIcon.frame)+20, 39, self.view.frame.size.width-CGRectGetMaxX(headerIcon.frame)-72-20, 72)];
    nameLabel.textColor = kMainFontColor;
    nameLabel.font = kFontSizeThree;
    nameLabel.text = kUserInfoModel.nick_name;
    [headerView addSubview:nameLabel];
    

}



-(void)setFooterViewFrame{
    
    self.footerView.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);

    [self.footerView clearSubviews];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    line.backgroundColor = kLineColor;
    [self.footerView addSubview:line];
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(0, 0, 80, 44);
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:kNormalFontColor forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeFour;
    [settingBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:settingBtn];
}



- (void)setupData {
    
    
    COProfileItemModel *myWallet = [COProfileItemModel itemWithIcon:@"menu_wallet" title:@"我的钱包" subtitle:[NSString stringWithFormat:@"%0.2f元",kUserInfoModel.balance] destVcClass:[COMyWalletViewController class]];
    
    COProfileItemModel *myCoupon = [COProfileItemModel itemWithIcon:@"menu_promo" title:@"停车记录" subtitle:@"" destVcClass:[COEzStopViewController class]];
    
    COProfileItemModel *myTrip = [COProfileItemModel itemWithIcon:@"menu_trips" title:@"出租车位" subtitle:nil destVcClass:[CORentCarportViewController class]];
    
    COProfileItemModel *myFriend = [COProfileItemModel itemWithIcon:@"menu_invite" title:@"意见反馈" subtitle:nil destVcClass:[COFeedbackViewController class]];
    
//    COProfileItemModel *mySticker = [COProfileItemModel itemWithIcon:@"menu_sticker" title:@"我的优惠劵" subtitle:[NSString stringWithFormat:@"%d",kUserInfoModel.coupon] destVcClass:[COMyCouponViewController class]];
    COProfileItemModel *mySticker = [COProfileItemModel itemWithIcon:@"menu_sticker" title:@"我的优惠劵" subtitle:[NSString stringWithFormat:@"%@",@""] destVcClass:[COMyCouponViewController class]];

    self.data = @[myWallet, myCoupon, myTrip, myFriend, mySticker];
    [self.tableView reloadData];
}

-(void)settingAction:(UIButton *)sender{
    COSettingViewController *vc = [[COSettingViewController alloc] init];
    vc.title = @"设置";
    vc.animateViewController = (COAnimateViewController *)self.parentViewController;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark-个人信息

//个人信息
- (void)personalDetailsClick {
    
    COProfileInfoViewController *vc = [[COProfileInfoViewController alloc] init];
    vc.title = @"个人信息";
    vc.animateViewController = (COAnimateViewController *)self.parentViewController;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    COProfileCell *cell = [COProfileCell cellWithTableView:tableView];
    cell.item = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    COProfileItemModel *item = self.data[indexPath.row];
    if (item.destVcClass == nil) return;
    
    if ([item.title isEqualToString:@"出租车位"]) {
        
        [self getNewData:item];
    }else{
        COPushBaseViewController *vc = [[item.destVcClass alloc] init];
        vc.title = item.title;
        vc.animateViewController = (COAnimateViewController *)self.parentViewController;
        [self.parentViewController.navigationController pushViewController:vc animated:YES];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getNewData:(COProfileItemModel *)item{
    [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:kLoading isTouched:NO inView:self.view];
    [[BusinessManager sharedManager].parkingLockManager requestViewShare:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            NSMutableArray *arr= [COViewShareModel mj_objectArrayWithKeyValuesArray:dict[@"locks"]];
            COViewShareModel *model = [self getViewShareModel:arr];
            if (model) {
                CORentCarportShareEarningsViewController *ctr = [[CORentCarportShareEarningsViewController alloc]init];
                ctr.shareModelArray = arr;
                ctr.model = model;
                [self.navigationController pushViewController:ctr animated:YES
                 ];
            }else{
                COPushBaseViewController *vc = [[item.destVcClass alloc] init];
                vc.title = item.title;
                vc.animateViewController = (COAnimateViewController *)self.parentViewController;
                [self.parentViewController.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
        }
    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
    
}

-(COViewShareModel *)getViewShareModel:(NSArray *)array
{
    for (COViewShareModel *model in array) {
        if (model.status == ShareStatusWokring ||model.status == ShareStatusSuspend) {//暂停共享
            return model;
            break;
        }
    }
    return nil;
}

@end
