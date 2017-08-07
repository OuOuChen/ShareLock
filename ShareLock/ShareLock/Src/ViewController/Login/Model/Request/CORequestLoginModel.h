//
//  CORequestLoginModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/9.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseRequestModel.h"

@interface CORequestLoginModel : COBaseRequestModel

/** 手机号 */
@property (nonatomic ,strong) NSString *phone_number;

/** 申请的验证码 */
@property (nonatomic ,strong) NSString *auth_code;

/** app 终端类型, android or ios */
@property (nonatomic ,strong) NSString *app_type;

/** app版本 */
@property (nonatomic ,strong) NSString *app_version;


@end
