//
//  COEarningsModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/29.
//  Copyright © 2017年 陈区. All rights reserved.
//  查看收益模型
//

#import <Foundation/Foundation.h>

@interface COEarningsModel : NSObject

/** 收益Id */
@property (nonatomic ,assign) int profit_id;

/** 收益年 */
@property (nonatomic ,assign) int year;

/** 收益月 */
@property (nonatomic ,assign) int month;

/** 收益 */
@property (nonatomic ,assign) double income;

/** 状态 1：可提现，2：申请提现中 3：提现已完成 */
@property (nonatomic ,assign) int status;

@end
