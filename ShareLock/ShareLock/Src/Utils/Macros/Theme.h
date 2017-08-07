//
//  Theme.h
//  BasicFramework
//
//  Created by 陈区 on 16/8/18.
//  Copyright © 2016年 陈区. All rights reserved.
//

#ifndef Theme_h
#define Theme_h

#pragma mark -  * * * * * * * * * * * * * * set color * * * * * * * * * * * * * *



/**
 *  主题颜色
 */
#define kThemeColor UIColorFromRGBValue(0XFFCC00)

/**
 *  分割线颜色
 */
#define kLineColor UIColorFromRGBValue(0XF5F5F5)

/**
 *  红色字体
 */
#define kRedColor kRGB(255, 60, 0)



/**
 *  灰色字体
 */
#define kGrayColor UIColorFromRGBValue(0X999999)

/**
 *  主要字体颜色
 */
#define kMainFontColor UIColorFromRGBValue(0X333333)
/**
 *  次要字体颜色
 */
#define kMinorFontColor UIColorFromRGBValue(0X999999)


/**
 *  默认字体颜色(非点击状态)
 */
#define kNormalFontColor kRGB(51, 51, 51)


/**
 *  导航条背景颜色
 */
#define kNavBgColor [UIColor whiteColor]




#pragma mark -  * * * * * * * * * * * * * * set  Font * * * * * * * * * * * * * *


/**
 *  字体1
 */
#define kFontSizeOne [UIFont systemFontOfSize:18]
/**
 *  字体2
 */
#define kFontSizeTwo [UIFont systemFontOfSize:16]
/**
 *  字体3
 */
#define kFontSizeThree [UIFont systemFontOfSize:14]
/**
 *  字体4
 */
#define kFontSizeFour [UIFont systemFontOfSize:12]
/**
 *  字体5
 */
#define kFontSizeFive [UIFont systemFontOfSize:10]





#pragma mark -  * * * * * * * * * * * * * * set Button * * * * * * * * * * * * * *
/**
 *  按钮的背景默认颜色
 */
#define kButtonBackColorForNormal UIColorFromRGBValue(0X0097f4)
/**
 *  按钮的背景点击颜色
 */
#define kButtonBackColorForSelect UIColorFromRGBValue(0X008ce3)
/**
 *  按钮的背景不可点击颜色
 */
#define kButtonBackColorForDisabled UIColorFromRGBValue(0X7fcaf9)

/**
 *  区块背景颜色
 */
#define kBlcokColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]



#pragma mark -  * * * * * * * * * * * * * * others * * * * * * * * * * * * * *



//十六进制颜色
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define kRGB_alpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define KsetUserValueKey(Object,Key) \
[[NSUserDefaults standardUserDefaults] setObject:Object forKey:Key];\
[[NSUserDefaults standardUserDefaults] synchronize];\




#pragma mark-oldCode

#define kBTImgColor [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:0.9];

/**R G B 颜色*/
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/**RGB颜色*/
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机色 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define UIColorFromHEX(hexValue, alphaValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(hexValue & 0x0000FF))/255.0 \
alpha:alphaValue]


#endif /* Theme_h */
