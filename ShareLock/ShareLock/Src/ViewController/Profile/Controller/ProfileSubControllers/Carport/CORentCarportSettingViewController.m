//
//  CORentCarportSettingViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/25.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportSettingViewController.h"
#import "CORentCarportHistoryViewController.h"

@interface CORentCarportSettingViewController ()

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *contactsTextField;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UISwitch *switchView;



@end

@implementation CORentCarportSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"共享锁设置";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setupView{
    
    CGFloat yPos = kNaigationBarHeight;
    yPos += 12;
    
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftSpace, 52)];
    UIView *leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftSpace, 52)];
    UIView *leftView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftSpace, 52)];
    
    UILabel *lableLeft1 = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, 100, 52)];
    lableLeft1.textColor = kMainFontColor;
    lableLeft1.textAlignment = NSTextAlignmentRight;
    lableLeft1.text = @"基  础  价   格:";
    lableLeft1.font = kFontSizeThree;
    [self.view addSubview:lableLeft1];
    
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lableLeft1.frame)+10, yPos, kScreenWidth-50-kLeftSpace-CGRectGetMaxX(lableLeft1.frame)-20, 52)];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.font = kFontSizeThree;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.text = [NSString stringWithFormat:@"%0.2f",self.model.rent/100];
    _phoneTextField.placeholder = @"价格";
    _phoneTextField.layer.borderWidth = 1.0f;
    _phoneTextField.layer.borderColor = kBlcokColor.CGColor;
    _phoneTextField.layer.masksToBounds = YES;
    _phoneTextField.layer.cornerRadius = 3.0f;
    _phoneTextField.leftView = leftView1;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phoneTextField];
    


    
    UILabel *lableRight1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-kLeftSpace-50, yPos, 50, 52)];
    lableRight1.textColor = kMainFontColor;
    lableRight1.textAlignment = NSTextAlignmentLeft;
    lableRight1.text = @"元/小时";
    lableRight1.font = kFontSizeThree;
    [self.view addSubview:lableRight1];
    
    yPos += 52;
    yPos += 6;

    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = kLineHeight;
    bottomLineLayer.borderColor = kLineColor.CGColor;
    bottomLineLayer.frame = CGRectMake(kLeftSpace, yPos, kScreenWidth-2*kLeftSpace, kLineHeight);
    [self.view.layer addSublayer:bottomLineLayer];
    
    yPos += 6;
    yPos += kLineHeight;
    
    
    UILabel *lableLeft2 = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, 100, 52)];
    lableLeft2.textColor = kMainFontColor;
    lableLeft2.textAlignment = NSTextAlignmentRight;
    lableLeft2.text = @"高峰时段折扣:";
    lableLeft2.font = kFontSizeThree;
    [self.view addSubview:lableLeft2];
    
    _contactsTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lableLeft2.frame)+10, yPos, kScreenWidth-50-kLeftSpace-CGRectGetMaxX(lableLeft2.frame)-20, 52)];
    _contactsTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _contactsTextField.font = kFontSizeThree;
    _contactsTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _contactsTextField.text = [NSString stringWithFormat:@"%0.1f",self.model.hot_time_rate];
    _contactsTextField.placeholder = @"折扣";
    _contactsTextField.layer.borderWidth = 1.0f;
    _contactsTextField.layer.borderColor = kBlcokColor.CGColor;
    _contactsTextField.layer.masksToBounds = YES;
    _contactsTextField.layer.cornerRadius = 3.0f;
    _contactsTextField.leftView = leftView2;
    _contactsTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_contactsTextField];
    
    UILabel *lableRight2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-kLeftSpace-50, yPos, 50, 52)];
    lableRight2.textColor = kMainFontColor;
    lableRight2.textAlignment = NSTextAlignmentLeft;
    lableRight2.text = @"倍";
    lableRight2.font = kFontSizeThree;
    [self.view addSubview:lableRight2];
    
    yPos += 52;
    yPos += 6;

    //加一条底部的灰色线条
    CALayer *bottomLineLayer2 = [CALayer layer];
    bottomLineLayer2.borderWidth = kLineHeight;
    bottomLineLayer2.borderColor = kLineColor.CGColor;
    bottomLineLayer2.frame = CGRectMake(kLeftSpace, yPos, kScreenWidth-2*kLeftSpace, kLineHeight);
    [self.view.layer addSublayer:bottomLineLayer2];
    
    yPos += 6;
    yPos += kLineHeight;
    
    UILabel *lableLeft3 = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, 100, 52)];
    lableLeft3.textColor = kMainFontColor;
    lableLeft3.textAlignment = NSTextAlignmentRight;
    lableLeft3.text = @"低峰时段折扣:";
    lableLeft3.font = kFontSizeThree;
    [self.view addSubview:lableLeft3];
    
    _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lableLeft3.frame)+10, yPos, kScreenWidth-50-kLeftSpace-CGRectGetMaxX(lableLeft3.frame)-20, 52)];
    _addressTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _addressTextField.font = kFontSizeThree;
    _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressTextField.text = [NSString stringWithFormat:@"%0.1f",self.model.cold_time_rate];
    _addressTextField.placeholder = @"折扣";
    _addressTextField.layer.borderWidth = 1.0f;
    _addressTextField.layer.borderColor = kBlcokColor.CGColor;
    _addressTextField.layer.masksToBounds = YES;
    _addressTextField.layer.cornerRadius = 3.0f;
    _addressTextField.leftView = leftView3;
    _addressTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_addressTextField];
    
    UILabel *lableRight3 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-kLeftSpace-50, yPos, 50, 52)];
    lableRight3.textColor = kMainFontColor;
    lableRight3.textAlignment = NSTextAlignmentLeft;
    lableRight3.text = @"倍";
    lableRight3.font = kFontSizeThree;
    [self.view addSubview:lableRight3];
    
    yPos += 52;
    yPos += 6;
    
    //加一条底部的灰色线条
    CALayer *bottomLineLayer3 = [CALayer layer];
    bottomLineLayer3.borderWidth = kLineHeight;
    bottomLineLayer3.borderColor = kLineColor.CGColor;
    bottomLineLayer3.frame = CGRectMake(kLeftSpace, yPos, kScreenWidth-2*kLeftSpace, kLineHeight);
    [self.view.layer addSublayer:bottomLineLayer3];
    
    yPos += kLineHeight;
    
    
    UILabel *lableLeft4 = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPos, 100, 52)];
    lableLeft4.textColor = kMainFontColor;
    lableLeft4.textAlignment = NSTextAlignmentRight;
    lableLeft4.text = @"开  启  共   享:";
    lableLeft4.font = kFontSizeThree;
    [self.view addSubview:lableLeft4];
    
    
     _switchView = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lableLeft3.frame)+20, yPos+(52-28)/2, 100.0f, 28.0f)];
//    _switchView = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-50-kLeftSpace, yPos+(52-28)/2, 50.0f, 28.0f)];

    if (self.model.status == 2) {//共享中
        _switchView.on = YES;//设置初始为ON的一边
    }else{
        _switchView.on = NO;//设置初始为ON的一边
    }
    [_switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [self.view addSubview: _switchView];

    
    yPos += 52;
    yPos += 6;
    
    
    [self setupFooterView];
    
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    [self.view addSubview:footerView];
    
}


-(void)commitAction:(UIButton *)sender{
//    [ProgressHUD shwoProgress:self.view];
    
    

    [[BusinessManager sharedManager].parkingLockManager requestSetLockWithLockId:self.model.lock_id rent:[NSString stringWithFormat:@"%d",[_phoneTextField.text intValue] *100] enable:_switchView.on hot_time_rate:_contactsTextField.text cold_time_rate:_addressTextField.text success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
//            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
    } failure:^(NSError *error) {
        [ProgressHUD hideProgress:self.view];
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:[ProgressHUD tipFromError:error] afterDelay:1];


    }];
    

    
}

#pragma mark-充值历史
- (void)onNavigationRightFirstButtonClicked:(UIButton *)sender {
    CORentCarportHistoryViewController *ctr = [[CORentCarportHistoryViewController alloc]init];
    ctr.lock_id = self.model.lock_id;
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)switchAction:(id)sender
{
    DDLogVerbose(@"%d",_switchView.on);

//    UISwitch *switchButton = (UISwitch*)sender;
//    BOOL isButtonOn = [switchButton isOn];
//    if (isButtonOn) {
//        DDLogVerbose(@"开");
//    }else {
//        DDLogVerbose(@"关");
//    }
}




@end
