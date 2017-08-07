//
//  COBaseModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/9.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COBaseRequestModel : NSObject

/** 用户id */
@property (nonatomic ,strong) NSString *usr_id;

/** 访问令牌d */
@property (nonatomic ,strong) NSString *token;

@end
