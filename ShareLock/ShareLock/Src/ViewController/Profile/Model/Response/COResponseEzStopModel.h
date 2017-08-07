//
//  COResponseEzStopModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COResponseEzStopModel : NSObject

/** 订单ID */
@property (nonatomic ,strong) NSString *order_id;

/** 实付金额 */
@property (nonatomic ,assign) double real_amount;

/** 锁id */
@property (nonatomic ,strong) NSString *lock_id;

/** 租用时间 */
@property (nonatomic ,strong) NSString *rent_time;


@end
