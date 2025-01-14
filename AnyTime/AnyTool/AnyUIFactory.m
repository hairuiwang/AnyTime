//
//  AnyUIFactory.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyUIFactory.h"

@implementation AnyUIFactory
+ (UIButton *)buttonWithTitle:(NSString *)title
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
               backgroundColor:(UIColor *)bgColor
                 cornerRadius:(CGFloat)cornerRadius
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
               backgroundColor:(UIColor *)bgColor
                 cornerRadius:(CGFloat)cornerRadius
                        image:(UIImage *)image
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [self buttonWithTitle:title textColor:textColor font:font backgroundColor:bgColor cornerRadius:cornerRadius target:target action:action];
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

#pragma mark - UILabel 创建
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    
    return label;
}

@end
