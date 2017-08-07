//
//  CORoutePlanView.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/14.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CORoutePlanView.h"
#import "DPPopUpMenu.h"

@interface CORoutePlanView ()<DPPopUpMenuDelegate>
//@property(nonatomic, strong) NSArray *normalIcons;//默认图片数组
//@property(nonatomic, strong) NSArray *selectedIcons;//图片数组
@property(nonatomic, strong) UITextField *oneTF;//第一个输入框
@property(nonatomic, strong) UITextField *twoTF;//第二个输入框
@property(nonatomic, assign) CGRect normalFrame;
//@property(nonatomic, assign) NSInteger itemSeleted;

@property(nonatomic, strong) UILabel *subtitle;//地址
@property(nonatomic, strong) UILabel *price;//价格
@property(nonatomic, strong) UILabel *time;//时间
@property(nonatomic, strong) UILabel *priceLable;
@property(nonatomic, strong) UILabel *distanceLable;
@property(nonatomic, strong) UILabel *timeLable;


@property(nonatomic, strong) UILabel *rentTime;
@property(nonatomic, strong) UILabel *rentTimeLable;



@end

@implementation CORoutePlanView
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
    CGFloat width = kScreenWidth/4;

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
    

    
    /** 距离 */
    _distance = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, width, 44)];
    _distance.textColor = kThemeColor;
    _distance.font = kFontSizeOne;
    _distance.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_distance];
    
    /** 价格 */
    _price = [[UILabel alloc] initWithFrame:CGRectMake(width, yPos, width, 44)];
    _price.textColor = kThemeColor;
    _price.font = kFontSizeOne;
    _price.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_price];
    
    /** 时间 */
    _rentTime = [[UILabel alloc] initWithFrame:CGRectMake(2*width, yPos, width, 44)];
    _rentTime.textColor = kThemeColor;
    _rentTime.font = kFontSizeOne;
    _rentTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_rentTime];
    
    /** 费用 */
    _time = [[UILabel alloc] initWithFrame:CGRectMake(3*width, yPos, width, 44)];
    _time.textColor = kThemeColor;
    _time.font = kFontSizeOne;
    _time.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_time];
    
    
    
    
    yPos += 44;
    
    /** 距离 */
    _distanceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, width, 30)];
    _distanceLable.textColor = kGrayColor;
    _distanceLable.text = @"距离起始位置";
    _distanceLable.font = kFontSizeFour;
    _distanceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_distanceLable];

    /** 价格 */
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(width, yPos, width, 30)];
    _priceLable.textColor = kGrayColor;
    _priceLable.font = kFontSizeFour;
    _priceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLable];
    
    /** 时间 */
    _rentTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(2*width, yPos, width, 30)];
    _rentTimeLable.textColor = kGrayColor;
    _rentTimeLable.font = kFontSizeFour;
    _rentTimeLable.text = @"租车时间";
    _rentTimeLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_rentTimeLable];
    
    /** 费用 */
    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(3*width, yPos, width, 30)];
    _timeLable.textColor = kGrayColor;
    _timeLable.text = @"费用";
    _timeLable.font = kFontSizeFour;
    _timeLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLable];
    

    

    
    yPos += 30;
    yPos += 20;

    
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(20, yPos, kScreenWidth-40, 40);
    [searchButton setBackgroundColor:kThemeColor];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"预约车位" forState:UIControlStateNormal];
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
    
    
    // 添加手势
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHourClick)];
    [self addGestureRecognizer:tapGestureRec];


    
}

#pragma mark -- 时间选择

-(void)selectHourClick{
    
    NSMutableArray *totalHours  = [NSMutableArray arrayWithCapacity:24];
    for (int i= 1 ; i <= 24; i++) {
        [totalHours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"预租时间";
    men.delegate=self;
    men.dataArray = totalHours;
    [men show];
}

#pragma mark -- DPPopUpMenuDelegate

- (void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withStr:(NSString *)str{
    DDLogVerbose(@"%@",str);
    _rentHour  = str;
    _rentTime.text = [NSString stringWithFormat:@"%@小时",_rentHour];
    _time.text = [NSString stringWithFormat:@"%0.2f",_mode.rent/100*[_rentHour intValue]];


}

#pragma mark -- 搜索路线图
- (void)searchRoute:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchRoute:)]) {
        [self.delegate searchRoute:self.mode];
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
    
    _rentHour = @"2";
    _mode = locksModel;
    self.hidden = NO;
    
    _subtitle.text = locksModel.address;
    _price.text = [NSString stringWithFormat:@"%0.2f",locksModel.rent/100];
    _priceLable.text = @"每1小时";
    _distance.text = [NSString stringWithFormat:@"%d米",locksModel.distance];
    _time.text = [NSString stringWithFormat:@"%0.2f",locksModel.rent/100*[_rentHour intValue]];
    _rentTime.text = [NSString stringWithFormat:@"%@小时",_rentHour];

    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.frame = self.normalFrame;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)dismiss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, -self.normalFrame.size.height, self.normalFrame.size.width, self.normalFrame.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}


@end
