//
//  COShareEarningsModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/8/4.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COShareEarningsModel : NSObject

/** 每一笔的收益，单位分 */
@property (nonatomic ,assign) double sharer_income;

/** 开始时间 */
@property (nonatomic ,strong) NSString *rent_time;


@end
