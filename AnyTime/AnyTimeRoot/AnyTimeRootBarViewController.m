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

@interface AnyTimeRootBarViewController ()

@end

@implementation AnyTimeRootBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
   
    AnyTimeHomeViewController * homeVC = [[AnyTimeHomeViewController alloc] init];
    UINavigationController *nav_homeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    nav_homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_home_uns"] selectedImage:[UIImage imageNamed:@"anytime_home_s"]];
    nav_homeVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_home_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    AnyTimeOrderViewController * orderVC = [[AnyTimeOrderViewController alloc] init];
    UINavigationController *nav_orderVC = [[UINavigationController alloc] initWithRootViewController:orderVC];
    nav_orderVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_order_uns"] selectedImage:[UIImage imageNamed:@"anytime_order_s"]];
    nav_orderVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_order_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_orderVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_order_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    AnyTimeMeViewController * meVC = [[AnyTimeMeViewController alloc] init];
    UINavigationController *nav_meVC = [[UINavigationController alloc] initWithRootViewController:meVC];
    nav_meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"anytime_me_uns"] selectedImage:[UIImage imageNamed:@"anytime_me_s"]];
    nav_meVC.tabBarItem.image = [[UIImage imageNamed:@"anytime_me_uns"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav_meVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"anytime_me_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.viewControllers = @[nav_homeVC,nav_orderVC,nav_meVC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
