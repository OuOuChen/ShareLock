//
//  CONetworkModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CONetworkPathModel.h"


@interface CONetworkModel : NSObject

/** 服务器根路径 */
@property (nonatomic ,strong) NSString *baseURL;

/** 相对路径 */
@property (nonatomic ,strong) CONetworkPathModel *path;

@end
