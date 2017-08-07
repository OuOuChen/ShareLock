//
//  BusinessFactory.h
//  T21info
//
//  Created by 陈区 on 12-10-30.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsManager, UploadManager;

@interface BusinessFactory : NSObject

/** 创建系统配置管理类 */
- (SystemConfigManager *)createSystemConfigManager;

/** 创建系统账号管理类 */
- (SystemAccountManager *)createSystemAccountManager;

/** 创建车位锁管理类 */
- (ParkingLockManager *)createParkingLockManager;

/** 创建图片上传管理类 */
- (ParkingLockManager *)createUploadFileManager;

@end
