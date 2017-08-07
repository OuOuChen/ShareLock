//
//  CORentCarportHistoryViewController.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/25.
//  Copyright © 2017年 陈区. All rights reserved.
//  锁运营记录
//

#import "COBaseViewController.h"

@interface CORentCarportHistoryViewController : COBaseViewController

/** 锁ID */
@property (nonatomic ,strong) NSString *lock_id;

@property (nonatomic ,strong) COEarningsModel *model;


@end
