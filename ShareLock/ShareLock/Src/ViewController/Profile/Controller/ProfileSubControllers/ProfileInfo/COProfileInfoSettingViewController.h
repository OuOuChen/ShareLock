//
//  COProfileInfoSettingViewController.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/13.
//  Copyright © 2017年 陈区. All rights reserved.
//  设置个人信息视图控制器
//

#import "COBaseViewController.h"

typedef NS_ENUM(NSInteger, InputType)
{
    InputType_NickName,//昵称
    InputType_Email,//邮箱
    InputType_Address//联系地址

};


@interface COProfileInfoSettingViewController : COBaseViewController

/** 输入类型 */
@property (nonatomic,assign) InputType  inputType;

/** 输入类型 */
@property (nonatomic,strong) NSString  *inputText;

@end
