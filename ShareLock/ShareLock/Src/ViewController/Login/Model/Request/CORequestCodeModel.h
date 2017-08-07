//
//  CORequestCodeModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/9.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseRequestModel.h"

@interface CORequestCodeModel : COBaseRequestModel

/** 手机号 */
@property (nonatomic ,strong) NSString *phone_number;

/** 是否是测试条件下使用，如果是测试条件，返回时的json包里会包含有auth_code字段 ，否则不会有, 非0表明是测试条件 */
@property (nonatomic ,strong) NSString *test_env;

/** 获取验证码的场景 1: 登录时获取验证码 */
@property (nonatomic ,strong) NSString *req_code;


@end
