//
//  COLockOperationView.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COLockOperationView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)show:(COResponseLocksModel *)locksModel;
- (void)dismiss;
@property (nonatomic, strong) COResponseLocksModel *mode;

@end
