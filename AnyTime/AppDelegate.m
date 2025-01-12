//
//  AppDelegate.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/10.
//

#import "AppDelegate.h"
#import "AnyTimeRootBarViewController.h"
#import "AnyTimeGuidePageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 判断是否是第一次启动
    BOOL isFirstLaunch = ![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
    
//    if (isFirstLaunch) {
        // 设置为第一次启动，之后不再显示引导页
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 显示引导页
        AnyTimeGuidePageViewController *onboardingVC = [[AnyTimeGuidePageViewController alloc] init];
        self.window.rootViewController = onboardingVC;
//    } else {
//        // 显示登录页
//        AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
//        self.window.rootViewController = rootVC;
//    }
//   
    [self.window makeKeyAndVisible];
    
    return YES;
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
