//
//  CORechargeInfoModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/31.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CORechargeInfoModel : NSObject

/** 租车锁的时长，单位分钟，APP需要将分钟转化为 xx小时xx分钟显示在界面上 */
@property (nonatomic ,assign) int rent_time;
/** 租车费用，单位分，比如1000， 代表10元 */
@property (nonatomic ,assign) double recharge;

@end
