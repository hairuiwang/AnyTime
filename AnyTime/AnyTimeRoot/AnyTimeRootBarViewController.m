//
//  AnyTimeRootBarViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeRootBarViewController.h"
#import "AnyTimeHomeViewController.h"
#import "AnyTimeOrderViewController.h"
#import "AnyTimeMeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AnyTimeCustomPopupView.h"
@interface AnyTimeRootBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UINavigationController *nav_homeVC;
@property (nonatomic, strong) UINavigationController *nav_orderVC;
@property (nonatomic, strong) UINavigationController *nav_meVC;
@end

@implementation AnyTimeRootBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.delegate = self;
    AnyTimeHomeViewController * homeVC = [[AnyTimeHomeViewController alloc] init];
    UINavigationController *nav_homeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    nav_homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_home_uns"] selectedImage:[UIImage imageNamed:@"anytime_home_s"]];
    nav_homeVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_home_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.nav_homeVC = nav_homeVC;
    
    AnyTimeOrderViewController * orderVC = [[AnyTimeOrderViewController alloc] init];
    UINavigationController *nav_orderVC = [[UINavigationController alloc] initWithRootViewController:orderVC];
    nav_orderVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_order_uns"] selectedImage:[UIImage imageNamed:@"anytime_order_s"]];
    nav_orderVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_order_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_orderVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_order_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.nav_orderVC = nav_orderVC;
    
    AnyTimeMeViewController * meVC = [[AnyTimeMeViewController alloc] init];
    UINavigationController *nav_meVC = [[UINavigationController alloc] initWithRootViewController:meVC];
    nav_meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_me_uns"] selectedImage:[UIImage imageNamed:@"anytime_me_s"]];
    nav_meVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_me_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_meVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_me_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.nav_meVC = nav_meVC;

    self.viewControllers = @[nav_homeVC,nav_orderVC,nav_meVC];
}
/// TabBar 切换的代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    // 判断是否切换到订单页或个人中心
    if (viewController == self.nav_orderVC || viewController == self.nav_meVC) {
        // 判断用户是否已登录
        if (![self isUserLoggedIn]) {
            // 未登录，跳转到登录页面
            [self showLoginViewController];
            return NO; // 禁止切换到目标页面
        }
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
            return YES;
        } else {
            if ([AnyRouterTool sharedInstance].chin == 1) { //
                AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:[[AnyRouter sharedInstance] getCurrentViewController].view.bounds];
                popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
                popupView.titleText = @"Location of position";
                popupView.descriptionText = @"Need location permission";
                popupView.firstButtonTitle = @"Confirm";
                popupView.secondButtonTitle = @"Cancel";
                
                popupView.firstButtonAction = ^{
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                        [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
                    }
                };
                popupView.secondButtonAction = ^{
                    NSLog(@"Second button tapped");
                };
                popupView.closeAction = ^{
                    NSLog(@"Close button tapped");
                };
                UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
                [popupView showInView:window];
                return NO;
            }
            return YES;
        }
    }
    return YES; // 允许切换
}

#pragma mark - 登录状态判断
/// 判断用户是否已登录
- (BOOL)isUserLoggedIn {
    return  [AnyDevHelper loadBoolFromUserDefaults:LOGIN_STATUS];
}

/// 显示登录页面
- (void)showLoginViewController {
    [[AnyRouter sharedInstance] openURL:@"/login" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
}
@end
