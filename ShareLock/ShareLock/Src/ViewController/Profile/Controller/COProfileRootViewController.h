//
//  COProfileRootViewController.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//  左侧根视图控制器
//

#import "COBaseViewController.h"

@interface COProfileRootViewController : COBaseViewController


/**
 * 根据底部控制器展示
 */
+ (void)showWithRootViewController:(UIViewController *)rootViewController;

/**
 * 隐藏
 */
+ (void)hide;



/** rootVc */
@property (nonatomic, strong) UIViewController *rootViewController;

/** hideStatusBar */
@property (nonatomic, assign) BOOL hideStatusBar;

@end
