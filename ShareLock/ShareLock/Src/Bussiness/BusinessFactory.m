//
//  BusinessFactory.m
//  T21info
//
//  Created by 陈区 on 12-10-30.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import "BusinessFactory.h"
#import "Business.h"

@implementation BusinessFactory

- (SystemConfigManager *)createSystemConfigManager {
    return [[SystemConfigManager alloc]init];
}

- (SystemAccountManager *)createSystemAccountManager {
    return [[SystemAccountManager alloc]init];
}

- (ParkingLockManager *)createParkingLockManager {
    return [[ParkingLockManager alloc]init];
}

- (UploadFileManager *)createUploadFileManager {
    return [[UploadFileManager alloc]init];
}

@end
