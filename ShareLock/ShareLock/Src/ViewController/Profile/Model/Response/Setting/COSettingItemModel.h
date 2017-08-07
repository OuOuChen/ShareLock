//
//  COSettingItemModel.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XBSettingAccessoryType) {
    XBSettingAccessoryTypeNone,                   // don't show any accessory view
    XBSettingAccessoryTypeDisclosureIndicator,    // the same with system DisclosureIndicator
    XBSettingAccessoryTypeSwitch,                 //  swithch
};

@interface COSettingItemModel : NSObject


@property (nonatomic,copy) NSString  *funcName;     /**<      功能名称*/
@property (nonatomic,strong) UIImage *img;          /**< 功能图片  */
@property (nonatomic,copy) NSString *detailText;    /**< 更多信息-提示文字  */
@property (nonatomic,strong) UIImage *detailImage;  /**< 更多信息-提示图片  */


@property (nonatomic,assign) XBSettingAccessoryType  accessoryType;    /**< accessory */
@property (nonatomic,copy) void (^executeCode)(); /**<      点击item要执行的代码*/
@property (nonatomic,copy) void (^switchValueChanged)(BOOL isOn); /**<  XBSettingAccessoryTypeSwitch下开关变化 */

@end
