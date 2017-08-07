//
//  CORequestMyCouponModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/21.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseRequestModel.h"

@interface CORequestMyCouponModel : COBaseRequestModel

/** 当前页面, 每页10条 */
@property (nonatomic ,assign) int page;

/** 优惠券状态 1：可使用，2：已使用 */
@property (nonatomic ,assign) int status;

@end
