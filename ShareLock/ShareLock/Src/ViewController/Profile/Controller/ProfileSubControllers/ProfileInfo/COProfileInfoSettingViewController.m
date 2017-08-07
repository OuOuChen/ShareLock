//
//  COProfileInfoSettingViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/13.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COProfileInfoSettingViewController.h"

@interface COProfileInfoSettingViewController ()

/** 输入框 */
@property (nonatomic, strong) UITextField *inputTextField;


@end

@implementation COProfileInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCustomNavigationRightButtonWithTitle:@"保存" image:nil hightlightImage:nil];
    self.view.backgroundColor = kBlcokColor;
    [self setupView];
}

-(void)setupView{
    
    UIView *inputBg = [[UIView alloc]initWithFrame:CGRectMake(0, 15+kNaigationBarHeight, kScreenWidth, 44)];
    inputBg.backgroundColor = [UIColor whiteColor];
    inputBg.layer.borderWidth = 1.0f;
    inputBg.layer.borderColor = [kBlcokColor CGColor];
    [self.view addSubview:inputBg];
    
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-2*kLeftSpace, 44)];
    _inputTextField.font = [UIFont systemFontOfSize:14];
    _inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    _inputTextField.text = self.inputText;
    _inputTextField.placeholder = [NSString stringWithFormat:@"请输入%@",self.title];
    [inputBg addSubview:_inputTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮事件


//保存
- (void)onNavigationRightFirstButtonClicked:(UIButton *)sender {
    if ([_inputTextField.text isEqualToString:_inputText]) {
        [ProgressHUD showHudTipStr:@"信息没有变动"];
        return;
    }
    [ProgressHUD shwoProgress:self.view];
    CORequestSettingUserModel *model = [[CORequestSettingUserModel alloc]init];
    switch (_inputType) {
        case InputType_NickName://昵称
        {
            model.nick_name = _inputTextField.text;
        }
            break;
        case InputType_Email://邮箱
        {
            model.email = _inputTextField.text;
        }
            break;
        case InputType_Address://昵称
        {
            model.address = _inputTextField.text;
        }
            break;
            
        default:
            break;
    }
    
    [[BusinessManager sharedManager].systemAccountManager requestSetUserInfoWithModel:model fileData:nil success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [ProgressHUD showHudTipStr:dict[@"msg"]];

    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
}


@end
