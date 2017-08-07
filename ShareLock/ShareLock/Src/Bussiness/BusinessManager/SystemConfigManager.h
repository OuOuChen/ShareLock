//
//  SystemConfigManager.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COSystemconfigModel.h"

@interface SystemConfigManager : NSObject


/** 系统配置模型 */
@property (nonatomic ,strong) COSystemconfigModel *systemConfigModel;

@end
