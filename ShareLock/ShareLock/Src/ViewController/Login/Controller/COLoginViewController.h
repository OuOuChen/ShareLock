//
//  COLoginViewController.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/7.
//  Copyright © 2017年 陈区. All rights reserved.
//  登录视图控制器
//

#import "COBaseViewController.h"

typedef NS_ENUM(NSInteger, FromViewController) {
    FromLoginViewController,
    FromUpdateViewController
};

@interface COLoginViewController : COBaseViewController
{
    NSTimer                            *timer;  //定时器

}

@property (nonatomic) FromViewController fromView;


@property (nonatomic, copy)  void (^DidClickHomeButton)();


@end
