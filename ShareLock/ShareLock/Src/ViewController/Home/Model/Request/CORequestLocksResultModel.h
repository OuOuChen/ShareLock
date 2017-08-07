//
//  CORequestLocksResultModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseRequestModel.h"

@interface CORequestLocksResultModel : COBaseRequestModel

/** 1:开锁成功，0：开锁失败 */
//@property (nonatomic ,assign) int resutl;

/** 电量，例如80，表明剩余80% */
@property (nonatomic ,assign) int battery;

/** 车位锁告警码 */
@property (nonatomic ,assign) int warning_code;

/** 随机码 */
@property (nonatomic ,strong) NSString *random;

/** 车位锁ID */
@property (nonatomic ,assign) int lock_id;

/** 对lock_info的签名 */
@property (nonatomic ,strong) NSString *sign;



@end
