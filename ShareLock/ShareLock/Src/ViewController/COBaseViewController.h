//
//  COBaseViewController.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/5.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COBaseViewController : UIViewController


-(void)showCustomNavigationBack;

-(void)showCustomNavigationBackWrite;

/**
 自定义导航条右边按钮
 */
- (void)showCustomNavigationRightFirstBtnImg:(NSString *)FirstImg SecondBtnImg:(NSString *)SecondImg;

/**
 *  显示导航栏右边的按钮
 *  @param aTitle 标题
 *  @param aImage 选中图片
 *  @param hImage 高亮图片
 *
 */
- (void)showCustomNavigationRightButtonWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage;

//显示导航栏右边的按钮
- (void)showCustomNavigationRightButtonWithTitleColor:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage withColor:(UIColor *)color;

//导航栏中间可点击按钮
- (void)showCustomNavigationMiddeTitleButton:(NSString *) title;




@end
