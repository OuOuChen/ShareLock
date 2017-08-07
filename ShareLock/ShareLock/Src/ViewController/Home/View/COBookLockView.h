//
//  COBookLockView.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/17.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COBookLockViewDelegate <NSObject>

- (void)cancleBook:(COResponseLocksModel *)mode;


@end

@interface COBookLockView : UIView
{
    NSInteger secondsCountDown;//倒计时总时长
    NSTimer *countDownTimer;
}

- (instancetype)initWithFrame:(CGRect)frame;
- (void)show:(COResponseLocksModel *)locksModel;
- (void)dismiss;
@property(nonatomic, weak) id<COBookLockViewDelegate> delegate;
@property (nonatomic, strong) COResponseLocksModel *mode;

@end
