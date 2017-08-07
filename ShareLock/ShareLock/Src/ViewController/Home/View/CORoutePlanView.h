//
//  CORoutePlanView.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/14.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CORoutePlanViewDelegate <NSObject>

- (void)searchRoute:(COResponseLocksModel *)mode;


@end

@interface CORoutePlanView : UIView



- (instancetype)initWithFrame:(CGRect)frame;
- (void)show:(COResponseLocksModel *)locksModel;
- (void)dismiss;
@property(nonatomic, weak) id<CORoutePlanViewDelegate> delegate;
@property (nonatomic, strong) COResponseLocksModel *mode;
@property(nonatomic, strong) UILabel *distance;//距离

@property(nonatomic, strong) NSString *rentHour;//租用时间

@end
