//
//  SystemConfigManager.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "SystemConfigManager.h"

@implementation SystemConfigManager

- (id)init
{
    if(self = [super init])
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SystemConfig" ofType:@"plist"];
        self.systemConfigModel = [COSystemconfigModel mj_objectWithFile:plistPath];

        
    }
    return self;
}

@end
