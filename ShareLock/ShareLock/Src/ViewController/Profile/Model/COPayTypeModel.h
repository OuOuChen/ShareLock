//
//  COPayTypeModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/26.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COPayTypeModel : NSObject

/** 名称 */
@property (nonatomic ,strong) NSString *title;

/** 图标 */
@property (nonatomic ,strong) NSString *icon;

/** 支付类型 */
@property (nonatomic ,assign) PayType payType;


@end
