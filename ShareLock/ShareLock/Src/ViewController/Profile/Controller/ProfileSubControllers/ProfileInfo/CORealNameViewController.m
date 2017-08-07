//
//  CORealNameViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/30.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORealNameViewController.h"
#import "WRNavigationBar.h"
#import "ZXNPublicBicycleController.h"
#import "COMyWalletViewController.h"

@interface CORealNameViewController ()



@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *contactsTextField;


@end

@implementation CORealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showCustomNavigationBackWrite];

    self.title = @"实名认证";

    [self showCustomNavigationBack];

    [self reloadPayBtn];
    
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    // 设置导航栏标题颜色
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:1];
}



-(void)setupView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 170)];
    headerView.backgroundColor = kThemeColor;
//    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
//    //导航条背景
//    UIView *navbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
////    navbgView.userInteractionEnabled = YES;
//    navbgView.backgroundColor = [UIColor clearColor];
//    [headerView addSubview:navbgView];
//    
//    //返回按钮
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 80, 44);
////    backBtn.backgroundColor = [UIColor redColor];
//    [backBtn setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
//    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
//    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [navbgView addSubview:backBtn];
//    
//    
//    //标题
//    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backBtn.frame), 0, kScreenWidth-2*CGRectGetMaxX(backBtn.frame), 44)];
//    titleLable.font = kFontSizeTwo;
//    titleLable.textColor = [UIColor whiteColor];
//    titleLable.textAlignment = NSTextAlignmentCenter;
//    titleLable.text = @"实名认证";
//    [navbgView addSubview:titleLable];
    
    //流程背景视图
    UIView *flowBg = [[UIView alloc]initWithFrame:CGRectMake(20, 40, kScreenWidth-40, 60)];
    flowBg.backgroundColor = [UIColor clearColor];
    [headerView addSubview:flowBg];
    
    
    CGFloat yPos = 60;
    CGFloat width = (kScreenWidth-40)/4;
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((width-22)/2+6, yPos+11, kScreenWidth-40-(width-22)-6, 2)];
    lineView.backgroundColor = kLineColor;
    [flowBg addSubview:lineView];
    
    UIImageView *flowImage1 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2, yPos, 22, 22)];
    flowImage1.image = [UIImage imageNamed:@"user_ attestation_finish"];
    [flowBg addSubview:flowImage1];
    
    UIImageView *flowImage2 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+width, yPos, 22, 22)];
    flowImage2.image = [UIImage imageNamed:@"user_ attestation_finish"];
    [flowBg addSubview:flowImage2];
    
    
    UIImageView *flowImage3 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+2*width, yPos, 22, 22)];
    flowImage3.image = [UIImage imageNamed:@"user_ attestation_stating"];
    [flowBg addSubview:flowImage3];
    
    
    UIImageView *flowImage4 = [[UIImageView alloc]initWithFrame:CGRectMake((width-22)/2+3*width, yPos, 22, 22)];
    flowImage4.image = [UIImage imageNamed:@"user_ attestation_nostating"];
    [flowBg addSubview:flowImage4];
    
    yPos += 22;
    yPos += 15;
    
    
    //手机验证
    UILabel *flowLable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, width, 14)];
    flowLable1.font = kFontSizeFour;
    flowLable1.textColor = [UIColor whiteColor];
    flowLable1.textAlignment = NSTextAlignmentCenter;
    flowLable1.text = @"手机验证";
    [flowBg addSubview:flowLable1];
    
    //押金充值
    UILabel *flowLable2 = [[UILabel alloc]initWithFrame:CGRectMake(width, yPos, width, 14)];
    flowLable2.font = kFontSizeFour;
    flowLable2.textColor = [UIColor whiteColor];
    flowLable2.textAlignment = NSTextAlignmentCenter;
    flowLable2.text = @"押金充值";
    [flowBg addSubview:flowLable2];
    
    //实名认证
    UILabel *flowLable3 = [[UILabel alloc]initWithFrame:CGRectMake(2*width, yPos, width, 14)];
    flowLable3.font = kFontSizeFour;
    flowLable3.textColor = [UIColor whiteColor];
    flowLable3.textAlignment = NSTextAlignmentCenter;
    flowLable3.text = @"实名认证";
    [flowBg addSubview:flowLable3];
    
    
    //注册完成
    UILabel *flowLable4 = [[UILabel alloc]initWithFrame:CGRectMake(3*width, yPos, width, 14)];
    flowLable4.font = kFontSizeFour;
    flowLable4.textColor = [UIColor whiteColor];
    flowLable4.textAlignment = NSTextAlignmentCenter;
    flowLable4.text = @"注册完成";
    [flowBg addSubview:flowLable4];
    
    
    
    
    CGFloat yPosBody = CGRectGetMaxY(headerView.frame);
    yPosBody += 20;
    
    UIImage *image = [UIImage imageNamed:@"user_Info_icon"];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-image.size.width)/2, yPosBody, image.size.width, image.size.height)];
    iconImageView.image = image;
    [self.view addSubview:iconImageView];
    
    yPosBody += image.size.height;
    yPosBody += 20;
    
    
    UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, yPosBody, kScreenWidth - 2 * kLeftSpace, 40)];
    tipsLable.textColor = kGrayColor;
    tipsLable.textAlignment = NSTextAlignmentCenter;
    tipsLable.numberOfLines = 2;
    tipsLable.text = @"请提交本人真实的身份信息，否则将无法获得平台提供的安全保障";
    tipsLable.font = kFontSizeFour;
    [self.view addSubview:tipsLable];
    
    yPosBody += 40;
    yPosBody += 10;

    
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 52)];
    leftView1.text = @"真实姓名：";
    leftView1.font = kFontSizeThree;
    leftView1.textColor = kMainFontColor;
    leftView1.textAlignment = NSTextAlignmentRight;
    
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 52)];
    leftView2.text = @"身份证号：";
    leftView2.font = kFontSizeThree;
    leftView2.textColor = kMainFontColor;
    leftView2.textAlignment = NSTextAlignmentRight;
    
    
    
    UIView *viewBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, yPosBody, kScreenWidth, 52)];
    viewBg1.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg1];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _phoneTextField.keyboardType = UIKeyboardTypeDefault;
    _phoneTextField.font = kFontSizeThree;
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.placeholder = @"请输入您的姓名";
    _phoneTextField.leftView = leftView1;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg1 addSubview:_phoneTextField];
    
    yPosBody += 52;
    yPosBody += 12;
    
    
    UIView *viewBg2 = [[UIView alloc]initWithFrame:CGRectMake(0, yPosBody, kScreenWidth, 52)];
    viewBg2.backgroundColor = kBlcokColor;
    [self.view addSubview:viewBg2];
    
    _contactsTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 52)];
    _contactsTextField.keyboardType = UIKeyboardTypeDefault;
    _contactsTextField.font = kFontSizeThree;
    _contactsTextField.clearButtonMode = UITextFieldViewModeAlways;
    _contactsTextField.placeholder = @"请输入您的身份证号码";
    _contactsTextField.leftView = leftView2;
    _contactsTextField.leftViewMode = UITextFieldViewModeAlways;
    [viewBg2 addSubview:_contactsTextField];
    
    yPosBody += 52;
    yPosBody += 12;

    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, yPosBody, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    

    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-按钮事件

//改变充值状态
-(void)reloadPayBtn{
//    if (self.payType > 0 ) {
//        _settingBtn.backgroundColor = kThemeColor;
//        _settingBtn.enabled = YES;
//        
//    }else{
//        _settingBtn.backgroundColor = kBlcokColor;
//        _settingBtn.enabled = NO;
//        
//    }
}


//实名认证
-(void)payAction:(UIButton *)sender{
    [ProgressHUD shwoProgress:self.view];
    CORequestSettingUserModel *model = [[CORequestSettingUserModel alloc]init];
    model.real_name = _phoneTextField.text;
    model.identity_card_code = _contactsTextField.text;
    
    [[BusinessManager sharedManager].systemAccountManager requestSetUserInfoWithModel:model fileData:nil success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            [self onNavigationBackButtonClicked:nil];
        }
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:dict[@"msg"] afterDelay:1];
        
    } failure:^{
        [ProgressHUD showProgressHUDInView:self.navigationController.view withText:@"请求失败" afterDelay:1];
        
        [ProgressHUD hideProgress:self.view];
    }];

    
}

//返回
- (void)onNavigationBackButtonClicked:(UIButton *)sender {
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *controller in viewControllers) {
        if ([controller isKindOfClass:[COMyWalletViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }else if ([controller isKindOfClass:[ZXNPublicBicycleController class]]){
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


@end
