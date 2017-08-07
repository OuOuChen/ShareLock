//
//  COLoginViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/7.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COLoginViewController.h"


@interface COLoginViewController ()

@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UITextField *captchaTextField;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic ,assign) NSInteger timeNum;

@property (nonatomic, strong) UIButton *getCaptchatButton;

@property (nonatomic ,strong) NSString *AllNumStr;

@property (nonatomic ,strong) UIButton *nextBtn;


@end

@implementation COLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timeNum = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self backButton];
    [self allTextFields];
    
    UILabel *naviLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, kScreenWidth-160,49)];
    naviLabel.text = @"手机验证";
    naviLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:naviLabel];
}

- (void)allTextFields
{
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self addWithTextField:_phoneTextField WithFrame:CGRectMake(12,74,kScreenWidth-24, 52) WithText:@"" WithPlaceholder:@"请输入手机号" WithLeftImg:@"mymobile"];
    
    UIView *line1 = [[UIView alloc] init];
    [self addLineView:line1 WithFrame:CGRectMake(12,CGRectGetMaxY(_phoneTextField.frame),kScreenWidth-24, 1)];
    
    _captchaTextField = [[UITextField alloc] init];
    _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_captchaTextField addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:UIControlEventEditingChanged];

    [self addWithTextField:_captchaTextField WithFrame:CGRectMake(_phoneTextField.x, CGRectGetMaxY(_phoneTextField.frame), kScreenWidth-12-94,self.phoneTextField.height) WithText:@"" WithPlaceholder:@"请输入验证码" WithLeftImg:@"checkicon"];
    
    UIView *line2 = [[UIView alloc] init];
    [self addLineView:line2 WithFrame:CGRectMake(12,CGRectGetMaxY(_captchaTextField.frame),kScreenWidth-24, 1)];
    
    _getCaptchatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addWithButton:_getCaptchatButton frame:CGRectMake(kScreenWidth - 94,_captchaTextField.y, 80,_captchaTextField.height) title:@"获取验证码" titleSize:12 titleColor:[UIColor grayColor]  andAction:@selector(clickSendMVButton:)];
    _getCaptchatButton.enabled = NO;
    _getCaptchatButton.alpha = 0.6;
    
    // 根据颜色画图片
    UIImage *image = [UIImage createImageWithColor:kThemeColor];
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addWithButton:_nextBtn frame:CGRectMake(26, CGRectGetMaxY(_captchaTextField.frame)+35, kScreenWidth-52,40) title:@"开始" titleSize:16 titleColor:[UIColor whiteColor] andAction:@selector(nextBtnClicked:)];
    _nextBtn.layer.cornerRadius = 5;
    _nextBtn.enabled = NO;
    _nextBtn.alpha = 0.6;
    _nextBtn.layer.masksToBounds = YES;
    [_nextBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)backButton
{
    UIImage *img = [UIImage imageNamed:@"txlclosewhite_pr"];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12,20+(44-img.size.height)*0.5,50,img.size.height)];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(onNavigationBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)nextBtnClicked:(UIButton *)sender
{
    

    
    CORequestLoginModel *model = [[CORequestLoginModel alloc]init];
    model.phone_number = self.phoneTextField.text;
    model.auth_code = self.captchaTextField.text;
    model.app_type = @"ios";
    model.app_version = kVersion;
    [[BusinessManager sharedManager].systemAccountManager requestLoginWithModel:model success:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            [self onNavigationBackButtonClicked];
        }
    } failure:^{
        
    }];

}



/** 获取验证码 */
- (void)clickSendMVButton:(id)sender
{
    _AllNumStr = [NSString stringWithFormat:@"%@",self.phoneTextField.text];
    
    if (_AllNumStr.length == 11) {
        CORequestCodeModel *model = [[CORequestCodeModel alloc]init];
        model.phone_number = _phoneTextField.text;
        model.test_env = @"1";
        model.req_code = @"1";
        
        [[BusinessManager sharedManager].systemAccountManager requestGetAuthCodeWithModel:model success:^(NSDictionary *dict) {
            if ([dict[@"ret"] intValue] == 0) {
                self.captchaTextField.text = dict[@"auth_code"];
                self.nextBtn.enabled = YES;
                self.nextBtn.alpha = 1.0;
            }
            
        } failure:^{
            
        }];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];

        
    }else{
        
    }
}

- (void)timeFire
{
    NSString *timeStr = [NSString stringWithFormat:@"%lds重新发送",(long)_timeNum];
    [self.getCaptchatButton setTitle:timeStr forState:UIControlStateNormal];
    self.getCaptchatButton.enabled = NO;
    [self.getCaptchatButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    if (_timeNum > 0) {
        _timeNum --;
    } else if (_timeNum == 0) {
        _timeNum = 60;
        [self.getCaptchatButton setTitleColor:kThemeColor forState:UIControlStateNormal];
        [self.getCaptchatButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getCaptchatButton.enabled = YES;
        [timer invalidate];
    }
}


- (void)textFieldDidChange:(UITextField *)textField

{

    
    
    NSInteger kMaxLength = 11;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    if (textField.text.length == kMaxLength) {
        self.getCaptchatButton.enabled = YES;
        self.getCaptchatButton.alpha = 1.0;
        [self.getCaptchatButton setTitleColor:kThemeColor forState:UIControlStateNormal];

    }else{
        self.getCaptchatButton.enabled = NO;
        self.getCaptchatButton.alpha = 0.3;
        [self.getCaptchatButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }
    
    
    if (textField.text.length == kMaxLength && _captchaTextField.text.length >0) {
        self.nextBtn.enabled = YES;
        self.nextBtn.alpha = 1.0;
        
    }else{
        self.nextBtn.enabled = NO;
        self.nextBtn.alpha = 0.3;
    }

    
}

- (void)textFieldDidChange2:(UITextField *)textField{
    NSInteger kMaxLength = 11;

    if (_phoneTextField.text.length == kMaxLength && textField.text.length >0) {
        self.nextBtn.enabled = YES;
        self.nextBtn.alpha = 1.0;
        
    }else{
        self.nextBtn.enabled = NO;
        self.nextBtn.alpha = 0.3;
    }
}

- (void)onNavigationBackButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UITextField *)addWithTextField:(UITextField *)textField WithFrame:(CGRect)frame WithText:(NSString *)nsstring WithPlaceholder:(NSString *)placeString WithLeftImg:(NSString *)imgStr
{
    textField.frame = frame;
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.text = kgetUserValueKey(nsstring);
    textField.placeholder = placeString;
    UIImageView *passwordImage = [[UIImageView alloc] init];
    passwordImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgStr]];
    passwordImage.width = 30;
    passwordImage.height = 50;
    passwordImage.contentMode = UIViewContentModeCenter;
    textField.leftView = passwordImage;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:textField];
    return  textField;
}

- (UIView *)addLineView:(UIView *)line WithFrame:(CGRect)frame
{
    line.frame = frame;
    line.backgroundColor = kLineColor;
    [self.view addSubview:line];
    return line;
}

// 创建Button
- (UIButton *)addWithButton:(UIButton *)button frame:(CGRect)frame title:(NSString *)title titleSize:(CGFloat)titlesize titleColor:(UIColor *)color andAction:(SEL)action
{
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titlesize];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
