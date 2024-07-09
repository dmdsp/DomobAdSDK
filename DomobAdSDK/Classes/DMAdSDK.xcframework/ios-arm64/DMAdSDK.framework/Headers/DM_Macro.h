//
//  DM_Macro.h
//  DMAd
//
//  Created by 刘士林 on 2024/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 定义一个内联函数来获取屏幕宽度适配比例
static inline CGFloat kWAdapt(void) {
    // 判断当前是否为横屏
    BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    // 如果是横屏，使用屏幕的高度进行适配；如果是竖屏，使用屏幕的宽度进行适配
    CGFloat adaptValue = isLandscape ? [[UIScreen mainScreen] bounds].size.height / 375 : [[UIScreen mainScreen] bounds].size.width / 375;
    return adaptValue;
}
//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define K_WIDTH  [UIScreen mainScreen].bounds.size.width
#define K_HEIGHT  [UIScreen mainScreen].bounds.size.height
//#define kWAdapt [[UIScreen mainScreen] bounds].size.width/375//屏幕宽度适配
#define kHAdapt [[UIScreen mainScreen] bounds].size.height/667//屏幕高度适配

// 透明色
#define kClearColor [UIColor clearColor]
// 颜色的RGB
#define KRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
// 随机色
#define KRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1.0]
// 带透明度的RGB
#define KRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define KColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  Font_text_12 [UIFont systemFontOfSize:12]
#define  Font_text_14 [UIFont systemFontOfSize:14]
#define  Font_text_16 [UIFont systemFontOfSize:16]

#ifdef DEBUG   //处于开发阶段
#define Kog(...) NSLog(__VA_ARGS__)
#else          //处于发布状态(没有输出)
#define  Kog(...)
#endif

//获得存储的对象
#define UserDefaultObject(A) [[NSUserDefaults standardUserDefaults]objectForKey:A]
//存值(可变的值不可以存)
#define UserDefaultSetValue(B,C) [[NSUserDefaults standardUserDefaults]setObject:B forKey:C]
//存BOOL值
#define UserDefaultBool(D,E)  [[NSUserDefaults standardUserDefaults]setBool:D forKey:E]
#define  Synchronize          [[NSUserDefaults standardUserDefaults]synchronize]
// 清除存储对象
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
    [[NSUserDefaults standardUserDefaults] synchronize];\
}

#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define KPLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"] //edit the plist

#define GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)

/*     用法
 TICK
 do your work here
 TOCK
 */
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

/* 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/* 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/* 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//degree角度
// radian  弧度
// 角度转弧度
#define LRDegreesToRadian(angle)  (M_PI * (angle) / 180.0)
// 弧度转角度
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//当前语言
#define CurrentLanguage ([NSLocale preferredLanguages] objectAtIndex:0])

//-------------------打印日志-------------------------
#ifdef DEBUG //开发阶段
#define DLog(format,...) printf("[%s %s] FUNCTION:%s [Line %d] %s\n", __DATE__, __TIME__, __PRETTY_FUNCTION__, __LINE__,  [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#else //发布阶段
#define DLog(...)
#endif

//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[KLanguage ToolBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define KShowAlert(message)    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"OK"];[alert show];

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#define FONT(F) [UIFont fontWithName:@"PingFang SC" size:F]

#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

#ifdef __OBJC__
//导入头文件
#endif

#define First_Launched @"firstLaunch"

//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

@interface DM_Macro : NSObject

+ (NSBundle *)currectBundle;

@end

NS_ASSUME_NONNULL_END
