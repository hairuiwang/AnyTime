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
+ (void)setCustomBackButton:(UIViewController *)viewController image:(UIImage * _Nullable)image action:(void(^ _Nullable)(void))action {
    UIImage *backImage = image ?: [UIImage imageNamed:@"nav_back"]; // 默认返回箭头
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:viewController
                                                                  action:@selector(customBackAction)];
    viewController.navigationItem.leftBarButtonItem = backButton;
    
    // 绑定 block 方式的回调
    if (action) {
        objc_setAssociatedObject(viewController, @selector(customBackAction), action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - 自定义返回按钮的点击事件
+ (void)customBackAction {
    UIViewController *vc = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    void (^action)(void) = objc_getAssociatedObject(vc, @selector(customBackAction));
    if (action) {
        action();
    } else {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}
@end
