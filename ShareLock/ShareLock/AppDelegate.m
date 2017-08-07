//
//  AppDelegate.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/5.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "AppDelegate.h"
#import "CONavigationController.h"
#import "IQKeyboardManager.h"

#import "ZXNPublicBicycleController.h"

@interface AppDelegate ()


@property (strong, nonatomic) CONavigationController *navCtr;



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self setupPlug];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor =[UIColor whiteColor];
    
    [self showMainView];
    
    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self.window makeKeyAndVisible];
//    
//    ZXNPublicBicycleController *main = [[ZXNPublicBicycleController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:main];
//    [self.window setRootViewController:navi];
//    
//    [[ZXNLocationGaoDeManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
//        
//    }];
//    
//    [AMapServices sharedServices].apiKey = @"c344cb6ba3d3d2ece147eb016704d034";
//    [[AMapServices sharedServices] setEnableHTTPS:YES];

    
    return YES;
}

#pragma mark-not
- (void)showMainView
{
    ZXNPublicBicycleController *rootCtr = [[ZXNPublicBicycleController alloc] init];
    if (!_navCtr) {
      _navCtr =   [[CONavigationController alloc] initWithRootViewController:rootCtr];
    }
    // 设置窗口的根控制器
    self.window.rootViewController = _navCtr;
    [self.window makeKeyAndVisible];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainView) name:NOTICE_LOGIN_OUT object:nil];

}

#pragma mark - Methods Private

//设置插件
-(void)setupPlug{
    
    //设置日志工具
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; //24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 30;
    [DDLog addLogger:fileLogger];
    
    //设置当键盘弹起时，点击背景收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    [[ZXNLocationGaoDeManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
        
    }];
    
    [AMapServices sharedServices].apiKey = @"c344cb6ba3d3d2ece147eb016704d034";
    [[AMapServices sharedServices] setEnableHTTPS:YES];


}




@end
