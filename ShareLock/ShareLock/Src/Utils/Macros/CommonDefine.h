


#pragma mark -  * * * * * * * * * * * * * * 提示时间 * * * * * * * * * * * * * *

/**  提醒消失时间  */
#define kHUD_DismisTime 1.0

/**  菊花消失时间  */
#define kActivity_DismisTime 0.1


#pragma mark -  * * * * * * * * * * * * * * 请求提示文字 * * * * * * * * * * * * * *

#define kLoading @"请稍后..."
#define kUploading @"正在提交..."
#define kRequest_Failure @"失败"
#define kRequest_Success @"成功"
#define kRequest_NOMore @"已加载全部"
#define kRequest_NoNetwork @"请检查网络链接"



#pragma mark -  * * * * * * * * * * * * * * 常量 * * * * * * * * * * * * * *


/**  线条高度  */
#define kLineHeight 1

/**  左边距  */
#define kLeftSpace 10

/**  分页拉取条数  */
#define kPageSize 15

/**  上拉触发最少条数 */
#define kTotalSize 5



#pragma mark -  * * * * * * * * * * * * * * 工具 * * * * * * * * * * * * * *

/**  版本号 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]

/**  当前网络状态 */
#define kNetworkType [SystemUtils getNetworkType]

/**  用户惟一标示 */
#define USER_ID [FileCacheManager getValueInMyLocalStoreForKey:KEY_USER_ID]

/**  网络状态 */
#define kNoNetwork @"no network"


/**  通知 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kRequestManager [RequestManager sharedInstance]
#define kSystemConfigModel [BusinessManager sharedManager].systemConfigManager.systemConfigModel
#define kBaseRequestModel [BusinessManager sharedManager].systemAccountManager.baseRequestModel
#define kUserInfoModel [BusinessManager sharedManager].systemAccountManager.userInfo



/**  提示弹窗的初始化 */
#define alertUnContent(content) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" \
message:content \
delegate:nil   \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil];  \
[alert show];

/**  判断是否是空字符串 */
#define  IsEmptyStr(string) string == nil || string == NULL || [string isEqualToString:@""] ||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO

/**  判断是否是iPhone */
#define kIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/**  判断是否是iPhone */
#define kIS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark -  * * * * * * * * * * * * * * 时间格式 * * * * * * * * * * * * * *

#define kTimeFormatStringSecond                    @"yyyy-MM-dd HH:mm:ss"
#define kTimeFormatStringMinute                    @"yyyy-MM-dd HH:mm"
#define kTimeFormatStringDay                       @"yyyy-MM-dd"



#pragma mark -  * * * * * * * * * * * * * * 本地偏好设置 * * * * * * * * * * * * * *

#define KsetUserValueKey(Object,Key) \
[[NSUserDefaults standardUserDefaults] setObject:Object forKey:Key];\
[[NSUserDefaults standardUserDefaults] synchronize];\

#define kremoveObjectForKey(key) \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\

#define kgetUserValueKey(key) \
[[NSUserDefaults standardUserDefaults] objectForKey:key]; \


#pragma mark -  * * * * * * * * * * * * * * 屏幕 * * * * * * * * * * * * * *

/**  获取Window  */
#define kKeyWindow [UIApplication sharedApplication].keyWindow

/**  获取mainScreen的bounds  */
#define kScreenBounds [[UIScreen mainScreen] bounds]

/**  获取屏幕宽度  */
#define kScreenWidth kScreenBounds.size.width

/**  获取屏幕宽度  */
#define kScreenHeight kScreenBounds.size.height

/**  导航条高度  */
#define kNaigationBarHeight 64



static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)

