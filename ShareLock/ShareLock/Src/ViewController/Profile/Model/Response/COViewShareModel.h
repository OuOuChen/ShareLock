//
//  COViewShareModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COViewShareModel : NSObject

/** 锁ID */
@property (nonatomic ,strong) NSString *lock_id;

/** 状态，1：已经提交给平台，2：共享中，3：暂停共享 */
@property (nonatomic ,assign) int status;

/** 锁位置 */
@property (nonatomic ,strong) NSString *address;

/** 每小时租金 */
@property (nonatomic ,assign) double rent;

/** 高峰时段折扣，例如1.5倍 */
@property (nonatomic ,assign) double hot_time_rate;

/** 低峰时段折扣，例如1.5倍 */
@property (nonatomic ,assign) double cold_time_rate;

/** 申请时间 */
@property (nonatomic ,strong) NSString *apply_time;

/** 最新设置时间 */
@property (nonatomic ,strong) NSString *update_time;


@end
