//
//  COFeedbackViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COFeedbackViewController.h"

#define kFeedbackTips @"请输入您的意见，我们将不断优化用户体验，谢谢!"


@interface COFeedbackViewController ()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView *message;

@property (nonatomic ,strong) UIButton *replyButton;

@property (nonatomic ,strong) UILabel *numLabel;

@end

@implementation COFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 消息留言View
    _message = [[UITextView alloc] initWithFrame:CGRectMake(kLeftSpace, kLeftSpace+kNaigationBarHeight, kScreenWidth-2*kLeftSpace, 200)];
    _message.delegate = self;
    _message.text = kFeedbackTips;
    _message.backgroundColor = kLineColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;    //行间距
    paragraphStyle.maximumLineHeight = 20;   /**最大行高*/
//    paragraphStyle.firstLineHeadIndent = 8; /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:kGrayColor
                                 };
    _message.attributedText = [[NSAttributedString alloc] initWithString:_message.text attributes:attributes];
    [self.view addSubview:_message];
    
    
    
    _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addWithButton:_replyButton frame:CGRectMake(CGRectGetMaxX(_message.frame)-62,CGRectGetMaxY(_message.frame)-37, 50,25) title:@"发表" titleSize:[UIFont systemFontOfSize:14] titleColor:kThemeColor andAction:@selector(replyButtonClicked)];
    _replyButton.layer.borderWidth = 1.0;
    _replyButton.layer.borderColor = kThemeColor.CGColor;
    [self.view addSubview:_replyButton];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(_replyButton.x-67, _replyButton.y, 55, _replyButton.height)];
    _numLabel.text = @"0/100";
    _numLabel.font = [UIFont systemFontOfSize:14];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.textColor = kThemeColor;
    [self.view addSubview:_numLabel];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _message.text = @"";
    _message.textColor = [UIColor blackColor];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 100) {
        textView.text = [textView.text substringToIndex:100];
    } else if (textView.text.length < 1) {
        _message.text = kFeedbackTips;
        _message.textColor = kGrayColor;
        _numLabel.text = @"0/100";
        [self.view endEditing:YES];
    } else {
        _numLabel.text = [NSString stringWithFormat:@"%ld/100",(unsigned long)textView.text.length];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        _message.text = kFeedbackTips;
        _message.textColor = kGrayColor;
        _numLabel.text = @"0/100";
        [self.view endEditing:YES];
    }
}

- (void)replyButtonClicked
{
    if (_message.text.length <1 || [_message.text isEqualToString:kFeedbackTips]) {
        [ProgressHUD showHudTipStr:@"说点什么吧~"];
    } else {
        [self.view endEditing:YES];
        [ProgressHUD showHudTipStr:@"提交成功~"];
    }
}


- (void)addWithButton:(UIButton *)button frame:(CGRect)frame title:(NSString *)title titleSize:(UIFont *)titlesize titleColor:(UIColor *)color andAction:(SEL)action
{
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = titlesize;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.0;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
