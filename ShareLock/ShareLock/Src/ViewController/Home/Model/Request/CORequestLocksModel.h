//
//  CORequestLocksModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/11.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseRequestModel.h"

@interface CORequestLocksModel : COBaseRequestModel

/** 经度 */
@property (nonatomic ,strong) NSString *lng;

/** 维度 */
@property (nonatomic ,strong) NSString *lat;

/** 城市名，例如：深圳市 */
@property (nonatomic ,strong) NSString *city;



@end
