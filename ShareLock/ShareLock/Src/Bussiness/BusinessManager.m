//
//  BusinessManager.m
//  T21info
//
//  Created by 陈区 on 12-10-30.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import "BusinessManager.h"

@implementation BusinessManager

static BusinessManager *sharedManager = nil;
+ (BusinessManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BusinessManager alloc] init];
    });
    return sharedManager;
}

- (void)initBusiness {
    BusinessFactory * busFactory = [[BusinessFactory alloc] init];
    
    self.systemConfigManager = [busFactory createSystemConfigManager];
    self.systemAccountManager = [busFactory createSystemAccountManager];
    self.parkingLockManager = [busFactory createParkingLockManager];
    self.uploadFileManager = [busFactory createUploadFileManager];


}

- (void)destroyBusiness {
    self.systemAccountManager = nil;

}

- (id)init {
    if (self = [super init]) {
        [self initBusiness];
    }
    return self;
}

- (void)dealloc {
    [self destroyBusiness];
}

@end
