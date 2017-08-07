//
//  CONavigationController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/5.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "CONavigationController.h"

@interface CONavigationController ()

@end

@implementation CONavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * 这个方法是为了，后台进入前台，导航栏的位置会改变
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
}

@end
