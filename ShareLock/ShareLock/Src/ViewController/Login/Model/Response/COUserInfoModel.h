//
//  COUserInfo.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/9.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COUserInfoModel : NSObject

/** 是否缴纳押金， 1.已经交纳， 0：未缴纳 */
@property (nonatomic ,assign) int deposited;

/** 账户余额 */
@property (nonatomic ,assign)float balance;

/** 优惠券数量 */
@property (nonatomic ,assign) int coupon;

/** 积分 */
@property (nonatomic ,assign) int point;

/** 是否通过实名认证 */
@property (nonatomic ,assign) int authentication;

/** 昵称 */
@property (nonatomic ,strong) NSString *nick_name;

/** 邮箱地址 */
@property (nonatomic ,strong) NSString *email;

/** 联系地址 */
@property (nonatomic ,strong) NSString *address;

/** 注册时手机号 */
@property (nonatomic ,strong) NSString *phone_number;

/** 邮箱地址 */
@property (nonatomic ,strong) NSString *img_url;

/** 银行名 */
@property (nonatomic ,strong) NSString *bank_name;

/** 卡号 */
@property (nonatomic ,strong) NSString *bank_card;


@end
