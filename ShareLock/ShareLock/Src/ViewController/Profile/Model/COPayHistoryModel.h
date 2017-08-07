//
//  COPayHistoryModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/31.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COPayHistoryModel : NSObject

/** 金额, 单位为（分 */
@property (nonatomic ,assign) double pay_amount;

/** 订单号 */
@property (nonatomic ,strong) NSString *order_no;

/** 下单时间 */
@property (nonatomic ,strong) NSString *create_time;

/** 支付方式 1:微信，2：支付宝 */
@property (nonatomic ,assign) int pay_way;


@end
