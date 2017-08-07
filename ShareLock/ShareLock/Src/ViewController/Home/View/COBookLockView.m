//
//  COBookLockView.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/17.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBookLockView.h"

@interface COBookLockView ()
//@property(nonatomic, strong) NSArray *normalIcons;//默认图片数组
//@property(nonatomic, strong) NSArray *selectedIcons;//图片数组
@property(nonatomic, strong) UITextField *oneTF;//第一个输入框
@property(nonatomic, strong) UITextField *twoTF;//第二个输入框
@property(nonatomic, assign) CGRect normalFrame;
//@property(nonatomic, assign) NSInteger itemSeleted;

@property(nonatomic, strong) UILabel *subtitle;//地址
@property(nonatomic, strong) UILabel *price;//价格
@property(nonatomic, strong) UILabel *priceLable;


@end


@implementation COBookLockView

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.normalFrame = frame;
        [self setupUI];
    }
    return self;
}
#pragma mark -- 设置UI
- (void)setupUI {
    
    
    CGFloat yPos = 0;
    CGFloat width = kScreenWidth;
    
    UIView *locationBg = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 44)];
    locationBg.backgroundColor = kBlcokColor;
    [self addSubview:locationBg];
    
    UIImage *icon = [UIImage imageNamed:@"gysddguide"];
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, (44-icon.size.height)/2, icon.size.width, icon.size.height)];
    iconView.image = icon;
    [locationBg addSubview:iconView];
    
    
    /** 地址 */
    _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+15, 0, kScreenWidth-kLeftSpace-CGRectGetMaxX(iconView.frame)-15, 44)];
    _subtitle.textColor = kMainFontColor;
    _subtitle.font = kFontSizeThree;
    _subtitle.textAlignment = NSTextAlignmentLeft;
    [locationBg addSubview:_subtitle];
    
    
    yPos += 44;
    
    /** 价格 */
    _price = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, width, 44)];
    _price.textColor = kThemeColor;
    _price.font = kFontSizeOne;
    _price.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_price];

//    
//    /** 驾驶时间 */
//    _time = [[UILabel alloc] initWithFrame:CGRectMake(2*width, yPos, width, 44)];
//    _time.textColor = kThemeColor;
//    _time.font = kFontSizeOne;
//    _time.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_time];
    
    yPos += 44;
    
    /** 价格 */
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, width, 30)];
    _priceLable.textColor = kGrayColor;
    _priceLable.font = kFontSizeFour;
    _priceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLable];
    
//    /** 距离 */
//    _distanceLable = [[UILabel alloc] initWithFrame:CGRectMake(width, yPos, width, 30)];
//    _distanceLable.textColor = kGrayColor;
//    _distanceLable.text = @"距离起始位置";
//    _distanceLable.font = kFontSizeFour;
//    _distanceLable.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_distanceLable];
//    
//    /** 驾驶时间 */
//    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(2*width, yPos, width, 30)];
//    _timeLable.textColor = kGrayColor;
//    _timeLable.text = @"驾车可到达";
//    _timeLable.font = kFontSizeFour;
//    _timeLable.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_timeLable];
    
    yPos += 30;
    yPos += 20;
    
    
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(20, yPos, kScreenWidth-40, 40);
    [searchButton setBackgroundColor:kThemeColor];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"取消预约" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchRoute:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = 2.;
    searchButton.layer.masksToBounds = YES;
    [self addSubview:searchButton];
    
    yPos += 40;
    yPos += 14.5;
    
    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = .5;
    bottomLineLayer.borderColor = [UIColor grayColor].CGColor;
    bottomLineLayer.frame = CGRectMake(0, yPos, kScreenWidth, .5);
    [self.layer addSublayer:bottomLineLayer];
    
    yPos += 0.5;
    
    
}
#pragma mark -- 搜索路线图
- (void)searchRoute:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleBook:)]) {
        [self.delegate cancleBook:self.mode];
    }
//    [self dismiss];
    
}
#pragma mark -- 交换两个地点
- (void)exChange:(UIButton *)sender {
    
    NSString *str = self.oneTF.text.length > 0 ? self.oneTF.text : self.oneTF.placeholder;
    self.oneTF.text = self.twoTF.text.length > 0 ? self.twoTF.text : self.twoTF.placeholder;
    self.twoTF.text = str;
    
}

- (void)show:(COResponseLocksModel *)locksModel{
    _mode = locksModel;
    self.hidden = NO;
    
    _subtitle.text = locksModel.address;
    _priceLable.text = @"保留时间";
    
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.frame = self.normalFrame;
    } completion:^(BOOL finished) {
    }];
    
    secondsCountDown = _mode.remains;//倒计时秒数(48小时换算成的秒数,项目中需要从服务器获取)
    if (countDownTimer) {
        [countDownTimer invalidate];
        countDownTimer = nil;
    }

    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    NSString *str_minute = [NSString stringWithFormat:@"%d",(secondsCountDown%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%d",secondsCountDown%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    _price.text = [NSString stringWithFormat:@"%@",format_time];

}

-(void) countDownAction{
    
    DDLogVerbose(@"%@",THIS_METHOD);
    //倒计时-1
    secondsCountDown--;
    //    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%d",(secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%d",secondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    //修改倒计时标签现实内容
    _price.text = [NSString stringWithFormat:@"%@",format_time];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
    }
}

- (void)dismiss {
    DDLogVerbose(@"%@",THIS_METHOD);

    [countDownTimer invalidate];
    countDownTimer = nil;


    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, -self.normalFrame.size.height, self.normalFrame.size.width, self.normalFrame.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}


@end
