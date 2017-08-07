//
//  SystemTypeDefine.h
//  WITC.SKX
//
//  Created by 陈区 on 17/3/21.
//  Copyright © 2017年 com.HS. All rights reserved.
//

#ifndef SystemTypeDefine_h
#define SystemTypeDefine_h

// 商品类目 
typedef enum {
    LOCK_STATUS_NORMAL,//未租用
    LOCK_STATUS_OPERATION,//正在租用
    LOCK_STATUS_BOOK,//已经预订车位锁
    LOCK_STATUS_WATITING, /* 等待锁上传开锁结果 */
}LockStatus;


// 支付类型
typedef enum {
    PAY_TYPE_WECHAT = 1,//微信
    PAY_TYPE_ALIPAY//支付宝
}PayType;
#endif /* SystemTypeDefine_h */
