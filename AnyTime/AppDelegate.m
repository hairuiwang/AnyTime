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
 
    return YES;
}

- (void)checkNetworkStatus {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    
    if (status == NotReachable) {
        // 网络不可用，弹出警告框
        NSLog(@"Network is noreachable");
        AnyTimeNoNetWorkViewController * nonetVC = [[AnyTimeNoNetWorkViewController alloc] init];
        self.window.rootViewController = nonetVC;
    } 
    else
    {
        // 网络连接正常，继续执行
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
            BOOL isLogin = [AnyDevHelper loadBoolFromUserDefaults:LOGIN_STATUS];
            if (isLogin)
            {
                AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
                self.window.rootViewController = rootVC;
            }
            else
            {
                AnyTimeLoginViewController * rootVC = [[AnyTimeLoginViewController alloc] init];
                self.window.rootViewController = rootVC;
            }
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
