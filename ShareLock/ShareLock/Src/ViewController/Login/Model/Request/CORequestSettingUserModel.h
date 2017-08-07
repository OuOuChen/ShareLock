//
//  CORequestSettingUserModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/14.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CORequestSettingUserModel : NSObject

/** 昵称 */
@property (nonatomic ,strong) NSString *nick_name;

/** 联系邮箱*/
@property (nonatomic ,strong) NSString *email;

/** 联系地址 */
@property (nonatomic ,strong) NSString *address;

/** 银行名称 */
@property (nonatomic ,strong) NSString *bank_name;

/** 银行卡号*/
@property (nonatomic ,strong) NSString *bank_card;

/** 真实姓名 */
@property (nonatomic ,strong) NSString *real_name;

/** 身份证号 */
@property (nonatomic ,strong) NSString *identity_card_code;



@end
