//
//  AnyUIFactory.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyUIFactory : NSObject
/// 创建 UIButton（普通按钮）
+ (UIButton *)buttonWithTitle:(NSString *)title
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
               backgroundColor:(UIColor *)bgColor
                   cornerRadius:(CGFloat)cornerRadius
                       target:(id)target
                       action:(SEL)action;

/// 创建 UIButton（带图片）
+ (UIButton *)buttonWithTitle:(NSString *)title
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
               backgroundColor:(UIColor *)bgColor
                   cornerRadius:(CGFloat)cornerRadius
                         image:(UIImage *)image
                         target:(id)target
                         action:(SEL)action;

#pragma mark - 创建 UILabel
/// 创建 UILabel
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             textAlignment:(NSTextAlignment)alignment;
@end

NS_ASSUME_NONNULL_END
