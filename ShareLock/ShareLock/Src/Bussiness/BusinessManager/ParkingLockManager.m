//
//  ParkingLockManager.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/12.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "ParkingLockManager.h"
#import "RequestManager.h"


@implementation ParkingLockManager

/**
 获取车位锁
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestLocksWithModel:(CORequestLocksModel *)model
                      success:(void(^)(NSDictionary *dict))success
                      failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.getLocksUrl params:model.mj_keyValues success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}


/**
 预订车位锁
 
 @param lock_id 锁id
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestBookLockWithLockId:(NSString *)lock_id
                         success:(void(^)(NSDictionary *dict))success
                         failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.bookLockUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 取消预订
 
 @param lock_id 锁id
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestCancelBookWithLockId:(NSString *)lock_id
                            success:(void(^)(NSDictionary *dict))success
                            failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.cancelBookUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}


/**
 获取优惠券记录
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestMyCouponListWithModel:(CORequestMyCouponModel *)model
                             success:(void(^)(NSDictionary *dict))success
                             failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.getCouponUrl params:model.mj_keyValues success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];

}

/**
 查询租用或预订或等待上传信息的锁
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestQueryRenting:(void(^)(NSDictionary *dict))success
                    failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.queryRentingUrl params:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];

}

/**
 租车位下单
 
 @param lock_id 锁id
 @param estimate_time 预计租车时长，按小时算，比如传1，意味租一个小时
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestUnifiedOrderWithLockId:(int)lock_id
                        estimate_time:(NSString *)estimate_time
                              success:(void(^)(NSDictionary *dict))success
                              failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = [NSNumber numberWithInt:lock_id];
    params[@"estimate_time"] = estimate_time;
[kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.unifiedOrderUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}


/**
 上传租车位开锁信息
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestMyCouponListWithModel:(CORequestLocksResultModel *)model
                            cnn_succ:(int )cnn_succ
                            order_no:(NSString *)order_no
                             success:(void(^)(NSDictionary *dict))success
                             failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cnn_succ"] = [NSNumber numberWithInt:cnn_succ];
    params[@"order_no"] = [NSString stringWithFormat:@"%@",order_no];
    params[@"lock_info"] = model.mj_keyValues;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",kSystemConfigModel.networkConfig.baseURL,kSystemConfigModel.networkConfig.path.reportOpenRetUrl ];
    
    [kRequestManager postRequestWithFullUrl:urlStr params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
    
    
}

/**
 停止租车位
 
 @param lock_id 锁id
 @param order_no 订单号
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestStopRentWithLockId:(NSString *)lock_id
                        order_no:(NSString *)order_no
                              success:(void(^)(NSDictionary *dict))success
                              failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    params[@"order_no"] = order_no;

    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.stopRentUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 租用车位订单记录
 
 @param page 页面
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestRentHistoryListWithModel:(int )page
                                success:(void(^)(NSDictionary *dict))success
                                failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = [NSNumber numberWithInt:page];
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.rentHistoryUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

#pragma mark-共享车位锁



/**
 查看共享
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestViewShare:(void(^)(NSDictionary *dict))success
                 failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.viewShareUrl params:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 申请共享锁
 
 @param address 地址
 @param phone_number 手机号码
 @param contacts 联系人
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestApplyLockWithAddress:(NSString *)address
                       phone_number:(NSString *)phone_number
                           contacts:(NSString *)contacts
                            success:(void(^)(NSDictionary *dict))success
                            failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"address"] = address;
    params[@"phone_number"] = phone_number;
    params[@"contacts"] = contacts;

    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.applyLockUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 查看锁运营记录
 
 @param lock_id 锁id
 @param page 页面
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestLockBusinessWithLockId:(NSString *)lock_id
                                 year:(int)year
                                month:(int)month
                                 page:(int)page
                              success:(void(^)(NSDictionary *dict))success
                              failure:(void(^)(NSError *error))failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    params[@"year"] = [NSNumber numberWithInt:year];
    params[@"month"] = [NSNumber numberWithInt:month];
    params[@"page"] = [NSNumber numberWithInt:page];
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.lockBusinessUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 设置共享车位锁运营信息
 
 @param lock_id 锁Id
 @param rent 每小时租金，例如10元
 @param hot_time_rate 高峰期价格比例，例如1.5, 则价格是1.5*10 = 15元
 @param cold_time_rate 低峰期价格比例，例如0.8, 则价格是0.8*10 = 8元
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestSetLockWithLockId:(NSString *)lock_id
                            rent:(NSString *)rent
                          enable:(int )enable
                   hot_time_rate:(NSString *)hot_time_rate
                  cold_time_rate:(NSString *)cold_time_rate
                         success:(void(^)(NSDictionary *dict))success
                         failure:(void(^)(NSError *error))failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    params[@"rent"] = rent;
    params[@"enable"] = [NSNumber numberWithInt:enable];
    params[@"hot_time_rate"] = hot_time_rate;
    params[@"cold_time_rate"] = cold_time_rate;

    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.setLockUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


/**
 查看收益
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestProfitWithLockId:(NSString *)lock_id
                        success:(void(^)(NSDictionary *dict))success
                        failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.profitUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 申请提现
 
 @param profit_id 锁id
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requesWithdrawWithProfitId:(int )profit_id
                           success:(void(^)(NSDictionary *dict))success
                           failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"profit_id"] = [NSNumber numberWithInt:profit_id];
    
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.withdrawUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 查看当前月份收益
 
 @param lock_id 锁id
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requesCurProfitWithLockId:(NSString *)lock_id
                          success:(void(^)(NSDictionary *dict))success
                          failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"lock_id"] = lock_id;
    
    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.curprofitUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

#pragma mark-钱包

/**
 申请退款（押金）
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestApplyDrawback:(void(^)(NSDictionary *dict))success
                     failure:(void(^)())failure{
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.applyDrawbackUrl params:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 创建押金订单
 
 @param type 押金类型 1:支付宝，2：微信
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestCreateDepositOrderWithType:(PayType )type
                                  success:(void(^)(NSDictionary *dict))success
                                  failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = [NSNumber numberWithInt:type];
    
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.createDepositOrderUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 创建充值订单
 
 @param type 押金类型 1:支付宝，2：微信
 @param amount 充值金额,分，例如充值5元，那么传500
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestCreateRechargeorderWithType:(PayType )type
                                   amount:(int )amount
                                  success:(void(^)(NSDictionary *dict))success
                                  failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = [NSNumber numberWithInt:type];
    params[@"amount"] = [NSNumber numberWithInt:amount];
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.createRechargeOrderUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 获取充值历史记录
 
 @param page 页面
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestGetRechargeOrderListWithModel:(int )page
                                     success:(void(^)(NSDictionary *dict))success
                                     failure:(void(^)(NSError *error))failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = [NSNumber numberWithInt:page];
    params[@"page_size"] = [NSNumber numberWithInt:10];

    [kRequestManager getRequestWithUrl:kSystemConfigModel.networkConfig.path.getRechargeOrderListUrl params:params success:^(id responseObject) {
        
        success(responseObject);
    }  failure:^(NSError *error) {
        failure(error);
    }];
}


@end
