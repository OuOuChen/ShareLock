//
//  COResponseLocksModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/11.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COResponseLocksModel : NSObject



/** 锁ID */
@property (nonatomic ,assign) int lock_id;
/** 经度 */
@property (nonatomic ,assign) double lng;
/** 维度 */
@property (nonatomic ,assign) double lat;
/** 每分钟租金 */
@property (nonatomic ,assign) float rent;
/** 距离，单位米 */
@property (nonatomic ,assign) int distance;
/** 剩余时间，单位秒, 当status为2时，该字段才有意义 */
@property (nonatomic ,assign) int remains;
/** 锁具体位置 */
@property (nonatomic ,strong) NSString *address;
/** 订单号，当status 为1 时才有意义 */
@property (nonatomic ,strong) NSString *order_no;
/** 开始时间， 当status 为1是，是开始租用时间，为2时是预订时间 */
@property (nonatomic ,assign) double start_tm;
/** 车位锁保留时间，单位：分钟，只有当status 为2 时才有意义 */
@property (nonatomic ,assign) float keep_time;
/** 预估费用，以分为单位, 当status 为1时，该字段才有意义
 */
@property (nonatomic ,assign) int estimate_fee;

@end
