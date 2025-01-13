//
//  BorderLabel.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "BorderLabel.h"

@implementation BorderLabel

- (void)drawTextInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 6); // 边框宽度
    CGContextSetLineJoin(context, kCGLineJoinRound); // 边框拐角圆润

    // 设置描边颜色（黄色）
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = [UIColor yellowColor]; // 边框颜色
    [super drawTextInRect:rect];

    // 设置填充颜色（黑色）
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor blackColor]; // 填充颜色
    [super drawTextInRect:rect];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
