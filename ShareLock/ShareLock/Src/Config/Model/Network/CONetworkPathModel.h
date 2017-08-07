//
//  CONetworkPathModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CONetworkPathModel : NSObject

/** 获取验证码 */
@property (nonatomic ,strong) NSString *getAuthCodeUrl;

/** 登录地址 */
@property (nonatomic ,strong) NSString *loginUrl;

/** 获取基础信息 */
@property (nonatomic ,strong) NSString *getBasicInfoUrl;

/** 设置个人信息 */
@property (nonatomic ,strong) NSString *setUserInfoUrl;

/** 退出登录 */
@property (nonatomic ,strong) NSString *loginOutUrl;

/** 获取车位锁 */
@property (nonatomic ,strong) NSString *getLocksUrl;

/** 上传图片 */
@property (nonatomic ,strong) NSString *uploadUrl;

/** 预订车位锁 */
@property (nonatomic ,strong) NSString *bookLockUrl;

/** 取消预订 */
@property (nonatomic ,strong) NSString *cancelBookUrl;

/** 获取优惠卷 */
@property (nonatomic ,strong) NSString *getCouponUrl;

/** 获取优惠卷 */
@property (nonatomic ,strong) NSString *queryRentingUrl;

/** 租车位下单 */
@property (nonatomic ,strong) NSString *unifiedOrderUrl;

/** 上传开锁信息 */
@property (nonatomic ,strong) NSString *reportOpenRetUrl;

/** 停止租车 */
@property (nonatomic ,strong) NSString *stopRentUrl;

/** 租用车位订单记录 */
@property (nonatomic ,strong) NSString *rentHistoryUrl;


/** 查看我的共享 */
@property (nonatomic ,strong) NSString *viewShareUrl;

/** 申请共享锁 */
@property (nonatomic ,strong) NSString *applyLockUrl;

/** 查看锁运营记录 */
@property (nonatomic ,strong) NSString *lockBusinessUrl;

/** 设置共享车位锁 */
@property (nonatomic ,strong) NSString *setLockUrl;

/** 查看收益 */
@property (nonatomic ,strong) NSString *profitUrl;

/** 申请提现 */
@property (nonatomic ,strong) NSString *withdrawUrl;

/** 申请退款（押金） */
@property (nonatomic ,strong) NSString *applyDrawbackUrl;

/** 创建押金订单 */
@property (nonatomic ,strong) NSString *createDepositOrderUrl;

/** 创建充值订单 */
@property (nonatomic ,strong) NSString *createRechargeOrderUrl;

/** 获取充值历史记录 */
@property (nonatomic ,strong) NSString *getRechargeOrderListUrl;

/** 查看当前月份收益 */
@property (nonatomic ,strong) NSString *curprofitUrl;




@end
