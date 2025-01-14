//
//  AnyNavigationBarUtil.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyNavigationBarUtil : NSObject
/// 设置导航栏透明度
/// @param viewController 目标 ViewController
/// @param transparent 是否透明（YES = 全透明，NO = 半透明）
+ (void)setNavigationBarTransparent:(UIViewController *)viewController transparent:(BOOL)transparent;

/// 设置导航栏标题字体和颜色
/// @param viewController 目标 ViewController
/// @param font 标题字体
/// @param color 标题颜色
+ (void)setNavigationBarTitleFont:(UIViewController *)viewController font:(UIFont *)font color:(UIColor *)color;

/// 自定义返回按钮
/// @param viewController 目标 ViewController
/// @param image 返回按钮图片（nil 则使用默认返回箭头）
/// @param action 返回按钮点击事件（nil 则默认 pop）
+ (void)setCustomBackButton:(UIViewController *)viewController image:(UIImage * _Nullable)image action:(void(^ _Nullable)(void))action;

@end

NS_ASSUME_NONNULL_END
