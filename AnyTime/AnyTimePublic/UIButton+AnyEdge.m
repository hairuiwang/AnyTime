//
//  UIButton+AnyEdge.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/15.
//

#import "UIButton+AnyEdge.h"

@implementation UIButton (AnyEdge)

- (void)layoutButtonWithEdgeStyle:(ButtonEdgeStyle)edgeStyle spacing:(CGFloat)spacing {
    // 获取图片和标题的宽高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat titleWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat titleHeight = self.titleLabel.intrinsicContentSize.height;

    // 初始化 EdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;

    switch (edgeStyle) {
        case ButtonEdgeStyleImageTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-titleHeight - spacing / 2.0, 0, 0, -titleWidth);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight - spacing / 2.0, 0);
            break;
        }
        case ButtonEdgeStyleImageLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2.0, 0, spacing / 2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.0, 0, -spacing / 2.0);
            break;
        }
        case ButtonEdgeStyleImageBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleHeight - spacing / 2.0, -titleWidth);
            titleEdgeInsets = UIEdgeInsetsMake(-imageHeight - spacing / 2.0, -imageWidth, 0, 0);
            break;
        }
        case ButtonEdgeStyleImageRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + spacing / 2.0, 0, -titleWidth - spacing / 2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - spacing / 2.0, 0, imageWidth + spacing / 2.0);
            break;
        }
    }

    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
}


@end
