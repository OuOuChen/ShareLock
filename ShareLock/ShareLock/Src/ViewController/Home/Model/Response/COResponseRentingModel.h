//
//  COResponseRentingModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COResponseRentingModel : NSObject

/** 状态：0，未租用， 1：正在租用，2：已经预订车位锁 3：等待锁上传开锁结果 */
//@property (nonatomic ,assign) int status;


/** 订单号，当status 为1 时才有意义 */
@property (nonatomic ,strong) NSString  *order_no;
/** 开始时间， 当status 为1是，是开始租用时间，为2时是预订时间 */
@property (nonatomic ,assign) double start_tm;
/** 车位锁保留时间，单位：分钟，只有当status 为2 时才有意义 */
@property (nonatomic ,assign) float keep_time;
/** 锁单位时间的租金，暂定为每分钟 */
@property (nonatomic ,assign) int rent;
/** 锁Id */
@property (nonatomic ,strong) NSString *lock_id;
/** 经度 */
@property (nonatomic ,assign) float lng;
/** 维度 */
@property (nonatomic ,assign) int lat;
/** 车位锁地址 */
@property (nonatomic ,strong) NSString *address;
/** 预估费用，以分为单位, 当status 为1时，该字段才有意义
 */
@property (nonatomic ,assign) int estimate_fee;




@end
