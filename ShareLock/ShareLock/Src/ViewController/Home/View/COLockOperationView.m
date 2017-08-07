//
//  COLockOperationView.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COLockOperationView.h"

@interface COLockOperationView ()

@property(nonatomic, assign) CGRect normalFrame;


@property(nonatomic, strong) UILabel *lockIdName;//锁ID
@property(nonatomic, strong) UILabel *subtitle;//预估价格


@end

@implementation COLockOperationView

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
    
    UIView *locationBg = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, kScreenWidth, 44)];
    locationBg.backgroundColor = kThemeColor;
    [self addSubview:locationBg];
    
    /** 锁ID */
    _lockIdName = [[UILabel alloc] initWithFrame:CGRectMake(kLeftSpace, 0, 150, 44)];
    _lockIdName.textColor = [UIColor whiteColor];
    _lockIdName.font = kFontSizeThree;
    _lockIdName.textAlignment = NSTextAlignmentLeft;
    [locationBg addSubview:_lockIdName];
    
    
    /** 地址 */
    _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-kLeftSpace-150, 0, 150, 44)];
    _subtitle.textColor = [UIColor whiteColor];
    _subtitle.font = kFontSizeThree;
    _subtitle.textAlignment = NSTextAlignmentRight;
    [locationBg addSubview:_subtitle];
    
    
    yPos += 44;
    
    
    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = .5;
    bottomLineLayer.borderColor = [UIColor grayColor].CGColor;
    bottomLineLayer.frame = CGRectMake(0, yPos, kScreenWidth, .5);
    [self.layer addSublayer:bottomLineLayer];
    
    yPos += 0.5;
    
    
}

- (void)show:(COResponseLocksModel *)locksModel{
    _mode = locksModel;
    self.hidden = NO;
    _lockIdName.text = [NSString stringWithFormat:@"正在用锁  %d",_mode.lock_id];
    _subtitle.text = [NSString stringWithFormat:@"预计费用:%d元",_mode.estimate_fee/100];
    
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
