//
//  COSettingBankInfoViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/30.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COSettingBankInfoViewController.h"


@interface COSettingBankInfoViewController ()

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *contactsTextField;

@end

@implementation COSettingBankInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView{
    
    CGFloat yPos = 12+kNaigationBarHeight;
    
    
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 52)];
    leftView1.text = @"银行名称：";
    leftView1.font = kFontSizeThree;
    leftView1.textColor = kMainFontColor;
    leftView1.textAlignment = NSTextAlignmentRight;
    
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 52)];
    leftView2.text = @"银行卡号：";
    leftView2.font = kFontSizeThree;
    leftView2.textColor = kMainFontColor;
    leftView2.textAlignment = NSTextAlignmentRight;
    
    
    UIView *viewBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 52)];
    viewBg1.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg1];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _phoneTextField.keyboardType = UIKeyboardTypeDefault;
    _phoneTextField.font = kFontSizeThree;
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.text = kUserInfoModel.bank_name;
    _phoneTextField.placeholder = @"请输入银行名称";
    _phoneTextField.leftView = leftView1;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg1 addSubview:_phoneTextField];
    
    yPos += 52;
    yPos += 12;
    
    
    UIView *viewBg2 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 52)];
    viewBg2.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg2];
    
    _contactsTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _contactsTextField.keyboardType = UIKeyboardTypeNumberPad;
    _contactsTextField.font = kFontSizeThree;
    _contactsTextField.clearButtonMode = UITextFieldViewModeAlways;
    _contactsTextField.text = kUserInfoModel.bank_card;
    _contactsTextField.placeholder = @"请输入银行卡号";
    _contactsTextField.leftView = leftView2;
    _contactsTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg2 addSubview:_contactsTextField];
    
    yPos += 52;
    yPos += 12;
    
    

    
    [self setupFooterView];
    
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80-64, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"提交" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    [self.view addSubview:footerView];
    
}



-(void)commitAction:(UIButton *)sender{
    [ProgressHUD shwoProgress:self.view];
    CORequestSettingUserModel *model = [[CORequestSettingUserModel alloc]init];
    model.bank_name = _phoneTextField.text;
    model.bank_card = _contactsTextField.text;
    
    [[BusinessManager sharedManager].systemAccountManager requestSetUserInfoWithModel:model fileData:nil success:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            
            //请求用户信息
            [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
                [ProgressHUD hideProgress:self.view];

                [self.navigationController popToRootViewControllerAnimated:YES];

            } failure:^{
                [ProgressHUD hideProgress:self.view];

                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }else{
            [ProgressHUD hideProgress:self.view];

        }
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        
    } failure:^{
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:@"请求失败" afterDelay:1];
        
        [ProgressHUD hideProgress:self.view];
    }];
}

@end
