//
//  COMyWalletPayViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/26.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COMyWalletPayViewController.h"
#import "COPayTypeCell.h"
#import "COMoneyCollectionViewCell.h"
#import "COPayTypeModel.h"
#import "WebViewController.h"

@interface COMyWalletPayViewController ()<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

/** 充值金额集合 */
@property (nonatomic ,strong) NSArray *payMoneyArray;
/** 支付类型集合 */
@property (nonatomic ,strong) NSMutableArray *payTypeArray;
/** 支付类型 */
@property (nonatomic ,assign) PayType payType;
/** 充值金额 */
@property (nonatomic ,strong) NSString *selectPay;


@end

@implementation COMyWalletPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"COMoneyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCOPayMoneyCellIdentify];
    [self.tableView registerNib:[UINib nibWithNibName:@"COPayTypeCell" bundle:nil]  forCellReuseIdentifier:kCOPayTypeCellIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getData];
    



}

//获取数据
-(void)getData{
    _payMoneyArray = @[@"100",@"50",@"20",@"10",@"5",@"2"];
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
    
    [self.collectionView reloadData];
    [self.tableView reloadData];
    
    
    
    self.selectPay = _payMoneyArray[0];
    self.payType = PAY_TYPE_WECHAT;

    [self reloadPayBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-按钮事件

//充值协议
- (IBAction)payDeal:(id)sender {
    WebViewController *webViewCtr = [[WebViewController alloc]init];
    webViewCtr.webURL = @"http://www.baidu.com";
    [self.navigationController pushViewController:webViewCtr animated:YES];
}

//去充值
- (IBAction)payClick:(id)sender {

    [ProgressHUD shwoProgress:self.view];

    [[BusinessManager sharedManager].parkingLockManager requestCreateRechargeorderWithType:self.payType amount:[self.selectPay intValue]*100 success:^(NSDictionary *dict) {
        [ProgressHUD  hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
    } failure:^{
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:@"请求失败" afterDelay:1];
        
        [ProgressHUD hideProgress:self.view];
    }];
    
}

//改变充值状态
-(void)reloadPayBtn{
    if (self.payType > 0 && [self.selectPay intValue] > 0) {
        _payBtn.backgroundColor = kThemeColor;
        _payBtn.enabled = YES;

    }else{
        _payBtn.backgroundColor = kBlcokColor;
        _payBtn.enabled = NO;

    }
}

#pragma mark UICollectionViewDataSource, UICollectionViewDelegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.payMoneyArray.count;
}

// UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    COMoneyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCOPayMoneyCellIdentify forIndexPath:indexPath];
    
    cell.titleName.text = [NSString stringWithFormat:@"%@元",self.payMoneyArray[indexPath.row]];
    if ([self.selectPay isEqualToString:self.payMoneyArray[indexPath.row]]) {
        cell.titleName.backgroundColor = kThemeColor;
    }else{
        cell.titleName.backgroundColor = kBlcokColor;
    }
    
    return cell;
}


// Item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenWidth-3*kLeftSpace)/2 ;
    return CGSizeMake(width, 50);
}

// 距离边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}


// collectionView 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectPay = self.payMoneyArray[indexPath.row];
    [self.collectionView reloadData];
    [self reloadPayBtn];

    
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    COPayTypeModel *model1 = self.payTypeArray[indexPath.row];
    self.payType = model1.payType;
    [self.tableView reloadData];
    [self reloadPayBtn];

}



@end
