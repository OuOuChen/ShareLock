//
//  CORentCarportNewViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORentCarportNewViewController.h"

@interface CORentCarportNewViewController ()

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *contactsTextField;
@property (nonatomic, strong) UITextField *addressTextField;

@end

@implementation CORentCarportNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请共享锁";

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
    
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 52)];
    leftView1.text = @"手机号：";
    leftView1.font = kFontSizeThree;
    leftView1.textColor = kMainFontColor;
    leftView1.textAlignment = NSTextAlignmentRight;
    
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 52)];
    leftView2.text = @"联系人：";
    leftView2.font = kFontSizeThree;
    leftView2.textColor = kMainFontColor;
    leftView2.textAlignment = NSTextAlignmentRight;
    
    UILabel *leftView3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 52)];
    leftView3.text = @"地    址：";
    leftView3.font = kFontSizeThree;
    leftView3.textAlignment = NSTextAlignmentRight;

    
    UIView *viewBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 52)];
    viewBg1.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg1];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.font = kFontSizeThree;
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.text = kUserInfoModel.phone_number;
    _phoneTextField.placeholder = @"请输入手机号码";
    _phoneTextField.leftView = leftView1;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg1 addSubview:_phoneTextField];
    
    yPos += 52;
    yPos += 12;
    
    
    UIView *viewBg2 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 52)];
    viewBg2.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg2];
    
    _contactsTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _contactsTextField.keyboardType = UIKeyboardTypeDefault;
    _contactsTextField.font = kFontSizeThree;
    _contactsTextField.clearButtonMode = UITextFieldViewModeAlways;
    _contactsTextField.text = kUserInfoModel.nick_name;
    _contactsTextField.placeholder = @"请输入联系人";
    _contactsTextField.leftView = leftView2;
    _contactsTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg2 addSubview:_contactsTextField];
    
    yPos += 52;
    yPos += 12;
    
    
    UIView *viewBg3 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 52)];
    viewBg3.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg3];
    
    _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _addressTextField.keyboardType = UIKeyboardTypeDefault;
    _addressTextField.font = kFontSizeThree;
    _addressTextField.clearButtonMode = UITextFieldViewModeAlways;
    _addressTextField.text = kUserInfoModel.address;
    _addressTextField.placeholder = @"请输入联系地址";
    _addressTextField.leftView = leftView3;
    _addressTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg3 addSubview:_addressTextField];
    
    [self setupFooterView];

}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
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
    [[BusinessManager sharedManager].parkingLockManager requestApplyLockWithAddress:_addressTextField.text phone_number:_phoneTextField.text contacts:_contactsTextField.text success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];


    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
    
}



@end
