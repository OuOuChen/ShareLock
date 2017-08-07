//
//  SystemAccountManager.h
//  Merchant
//
//  Created by 陈区 on 16/9/29.
//  Copyright © 2016年 陈区. All rights reserved.
//  系统账号管理类
//

#import <Foundation/Foundation.h>
#import "CORequestCodeModel.h"
#import "CORequestLoginModel.h"
#import "COUserInfoModel.h"
#import "CORequestSettingUserModel.h"


@interface SystemAccountManager : NSObject

/**token、usr_id  */
@property (nonatomic ,strong) COBaseRequestModel *baseRequestModel;

/** 用户基本信息  */
@property (nonatomic ,strong) COUserInfoModel *userInfo;



/**
 请求验证码
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestGetAuthCodeWithModel:(CORequestCodeModel *)model
                           success:(void(^)(NSDictionary *dict))success
                           failure:(void(^)())failure;

/**
 请求登录
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestLoginWithModel:(CORequestLoginModel *)model
                            success:(void(^)(NSDictionary *dict))success
                            failure:(void(^)())failure;

/**
 获取基础信息
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestUserInfo:(void(^)(NSDictionary *dict))success
                      failure:(void(^)())failure;

/**
 设置个人信息
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestSetUserInfoWithModel:(CORequestSettingUserModel *)model
                           fileData:(NSData *)fileData
                            success:(void(^)(NSDictionary *dict))success
                            failure:(void(^)())failure;

/**
 退出登录
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requesLogOut:(void(^)(NSDictionary *dict))success
                failure:(void(^)())failure;






@end
