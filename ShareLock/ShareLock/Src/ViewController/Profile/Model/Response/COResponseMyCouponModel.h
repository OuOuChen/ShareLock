//
//  COResponseMyCouponModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/21.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COResponseMyCouponModel : NSObject

/** 优惠券码 */
@property (nonatomic ,assign) int code;

/** 开始有效期 */
@property (nonatomic ,strong) NSString *validate_start;

/** 结束有效期 */
@property (nonatomic ,strong) NSString *validate_end;

/** 优惠券金额 */
@property (nonatomic ,assign) double amount;

/** 备注，例如注册送10元优惠券 */
@property (nonatomic ,strong) NSString *mark;


@end
