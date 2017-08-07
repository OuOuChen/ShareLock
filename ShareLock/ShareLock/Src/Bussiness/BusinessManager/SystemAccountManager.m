//
//  SystemAccountManager.m
//  Merchant
//
//  Created by 陈区 on 16/9/29.
//  Copyright © 2016年 陈区. All rights reserved.
//

#import "SystemAccountManager.h"
#import "RequestManager.h"

@implementation SystemAccountManager

- (id)init
{
    if(self = [super init])
    {
        NSDictionary *tokenDic = kgetUserValueKey(KEY_TOKEN_USERID);
        NSDictionary *userInfoDic = kgetUserValueKey(KEY_USER_INFO);

        if (tokenDic) {
            self.baseRequestModel = [COBaseRequestModel mj_objectWithKeyValues:tokenDic];
        }
        if (userInfoDic) {
            self.userInfo = [COUserInfoModel mj_objectWithKeyValues:userInfoDic];
        }
        
        
    }
    return self;
}



/**
 请求验证码
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestGetAuthCodeWithModel:(CORequestCodeModel *)model
                           success:(void(^)(NSDictionary *dict))success
                           failure:(void(^)())failure{
    
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);

    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.getAuthCodeUrl params:model.mj_keyValues success:^(id responseObject) {

        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
    
}

/**
 请求登录
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestLoginWithModel:(CORequestLoginModel *)model
                      success:(void(^)(NSDictionary *dict))success
                      failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.loginUrl params:model.mj_keyValues success:^(id responseObject) {
        
        if ([responseObject[@"ret"] intValue] == 0) {
            KsetUserValueKey(responseObject, KEY_TOKEN_USERID);

            self.baseRequestModel = [COBaseRequestModel mj_objectWithKeyValues:responseObject];
        }
        //请求用户信息
        [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
            
        } failure:^{
            
        }];
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 获取基础信息
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestUserInfo:(void(^)(NSDictionary *dict))success
                failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
    
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.getBasicInfoUrl params:nil success:^(id responseObject) {
        if ([responseObject[@"ret"] intValue] == 0) {
            COUserInfoModel *model = [COUserInfoModel mj_objectWithKeyValues:responseObject[@"details"]];
            NSDictionary *dic = [model mj_JSONObject];
            KsetUserValueKey(dic, KEY_USER_INFO);
            self.userInfo = model;
            self.userInfo.balance = self.userInfo.balance/100;
        }
        success(responseObject);
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 设置个人信息
 
 @param model 请求模型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestSetUserInfoWithModel:(CORequestSettingUserModel *)model
                           fileData:(NSData *)fileData
                            success:(void(^)(NSDictionary *dict))success
                            failure:(void(^)())failure{
    DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);

    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",kSystemConfigModel.networkConfig.baseURL,kSystemConfigModel.networkConfig.path.setUserInfoUrl] ;
    
    [RequestManager postMultipartWithUrl:urlStr params:model.mj_keyValues fileData:fileData success:^(id responseObject) {
        if ([responseObject[@"ret"] intValue] == 0) {
            //请求用户信息
            [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
                if ([dict[@"ret"] intValue] == 0) {
                    success(responseObject);
                }else{
                    success(dict);
                }
                
            } failure:^{
                failure();
            }];
        }else{
            success(responseObject);
        }
    } fail:^{
        failure();
    }];


}


/**
 退出登录
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requesLogOut:(void(^)(NSDictionary *dict))success
             failure:(void(^)())failure{
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_LOGIN_OUT object:nil];

    
    [kRequestManager postRequestWithUrl:kSystemConfigModel.networkConfig.path.loginOutUrl params:nil success:^(id responseObject) {
        DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
        kremoveObjectForKey(KEY_USER_INFO);
        kremoveObjectForKey(KEY_TOKEN_USERID);
        self.baseRequestModel = nil;
        self.userInfo = nil;
        success(responseObject);
    } failure:^(NSError *error) {
        DDLogVerbose(@"%@ %@",THIS_FILE,THIS_METHOD);
        kremoveObjectForKey(KEY_USER_INFO);
        kremoveObjectForKey(KEY_TOKEN_USERID);
        self.baseRequestModel = nil;
        self.userInfo = nil;
        failure();
    }];
    
}
@end
