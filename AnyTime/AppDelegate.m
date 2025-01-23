//
//  AppDelegate.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/10.
//

#import "AppDelegate.h"
#import "AnyTimeRootBarViewController.h"
#import "AnyTimeGuidePageViewController.h"
#import "AnyTimeLoginViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "Reachability.h"
#import "AnyTimeNoNetWorkViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) dispatch_source_t gcdTimer; // GCD 定时器

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 初始化 Reachability 实例
      self.reachability = [Reachability reachabilityForInternetConnection];
      
      // 开始监控网络状态
      [self.reachability startNotifier];
      
      // 检查网络状态
      [self checkNetworkStatus];
 
    // 创建定时器队列
        dispatch_queue_t queue = dispatch_get_main_queue(); // 或自定义队列
        self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

        // 设置定时器的时间间隔
        dispatch_source_set_timer(self.gcdTimer,
                                  dispatch_time(DISPATCH_TIME_NOW, 0), // 开始时间
                                  1.0 * NSEC_PER_SEC,            // 重复间隔
                                  0);                                 // 容错时间

        // 设置任务回调
        dispatch_source_set_event_handler(self.gcdTimer, ^{
            [self checkNetworkStatus];
        });

        // 启动定时器
        dispatch_resume(self.gcdTimer);
    
    return YES;
}

- (void)checkNetworkStatus {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    
    if (status == NotReachable) {
        // 网络不可用，弹出警告框
        NSLog(@"Network is noreachable");
        if (![self.window.rootViewController isKindOfClass:[AnyTimeNoNetWorkViewController class]]) {
            AnyTimeNoNetWorkViewController * nonetVC = [[AnyTimeNoNetWorkViewController alloc] init];
            self.window.rootViewController = nonetVC;
            [self.window makeKeyWindow];
        }
    } 
    else
    {
        // 网络连接正常，继续执行
        if (self.gcdTimer) {
            dispatch_source_cancel(self.gcdTimer);
            self.gcdTimer = nil;
        }
        
        NSLog(@"Network is reachable");
        [AnyRouterTool registered];
        BOOL isFirstLaunch = ![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
        
        if (isFirstLaunch)
        {
            AnyTimeGuidePageViewController *onboardingVC = [[AnyTimeGuidePageViewController alloc] init];
            self.window.rootViewController = onboardingVC;
        }
        else
        {
            AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
            self.window.rootViewController = rootVC;
            
//            BOOL isLogin = [AnyDevHelper loadBoolFromUserDefaults:LOGIN_STATUS];
//            if (isLogin)
//            {
//
//            }
//            else
//            {
//                AnyTimeLoginViewController * rootVC = [[AnyTimeLoginViewController alloc] init];
//                self.window.rootViewController = rootVC;
//            }
        }
       
        [self.window makeKeyAndVisible];
        
        [IQKeyboardManager sharedManager].enable = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
