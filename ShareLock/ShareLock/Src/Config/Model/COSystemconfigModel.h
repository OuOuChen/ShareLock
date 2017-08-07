//
//  COSystemconfigModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CONetworkModel.h"


@interface COSystemconfigModel : NSObject

/** 网络配置 */
@property (nonatomic ,strong) CONetworkModel *networkConfig;

/** 网络请求最大运行线程个数 */
@property (nonatomic ,assign) NSInteger maxOperationCount;

/** 网络请求超时时间 */
@property (nonatomic ,assign) NSInteger timeoutInterval;



@end
