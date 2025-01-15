//
//  UIButton+AnyEdge.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ButtonEdgeStyle) {
    ButtonEdgeStyleImageTop,    // 图片在上，标题在下
    ButtonEdgeStyleImageLeft,   // 图片在左，标题在右
    ButtonEdgeStyleImageBottom, // 图片在下，标题在上
    ButtonEdgeStyleImageRight   // 图片在右，标题在左
};

@interface UIButton (AnyEdge)

/**
 配置 UIButton 的图片和标题布局

 @param edgeStyle 图片和标题的相对位置
 @param spacing 图片和标题之间的间距
 */
- (void)layoutButtonWithEdgeStyle:(ButtonEdgeStyle)edgeStyle
                          spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
