//
//  GradientBorderLabel.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "GradientBorderLabel.h"

@implementation GradientBorderLabel


- (void)drawTextInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor whiteColor];
    [super drawTextInRect:rect];
}


@end
