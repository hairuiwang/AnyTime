//
//  AnyNavigationBarUtil.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyNavigationBarUtil.h"
#import <objc/runtime.h> 

@implementation AnyNavigationBarUtil

#pragma mark - 设置导航栏透明
+ (void)setNavigationBarTransparent:(UIViewController *)viewController transparent:(BOOL)transparent {
    if (transparent) {
        // 全透明
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
    } else {
        // 半透明
        viewController.navigationController.navigationBar.translucent = YES;
        [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [viewController.navigationController.navigationBar setShadowImage:nil];
    }
}

#pragma mark - 设置导航栏标题字体和颜色
+ (void)setNavigationBarTitleFont:(UIViewController *)viewController font:(UIFont *)font color:(UIColor *)color {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (font) {
        attributes[NSFontAttributeName] = font;
    }
    if (color) {
        attributes[NSForegroundColorAttributeName] = color;
    }
    viewController.navigationController.navigationBar.titleTextAttributes = attributes;
}

#pragma mark - 自定义返回按钮
+ (void)setCustomBackButton:(UIViewController *)viewController image:(UIImage * _Nullable)image action:(SEL)action {
    UIImage *backImage = image ?: [UIImage imageNamed:@"nav_back"]; // 默认返回箭头
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 设置图片
    [backButton setImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    // 设置按钮大小（根据实际需求调整）
    backButton.frame = CGRectMake(0, 0, 44, 44); // 适当的尺寸

    // 添加点击事件
    [backButton addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];

    // 使用 customView 创建 UIBarButtonItem
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    // 设置导航栏左侧按钮
    viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
    
}
@end
