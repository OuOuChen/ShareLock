//
//  BusinessManager.h
//  T21info
//
//  Created by 陈区 on 12-10-30.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessFactory.h"

@class GoodsManager;

@interface BusinessManager : NSObject

@property(nonatomic,strong)SystemConfigManager *systemConfigManager;

@property(nonatomic,strong)SystemAccountManager *systemAccountManager;

@property(nonatomic,strong)ParkingLockManager *parkingLockManager;

@property(nonatomic,strong)UploadFileManager *uploadFileManager;



+ (BusinessManager *)sharedManager;

@end
