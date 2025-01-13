//
//  OutlineLabel.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "OutlineLabel.h"

@implementation OutlineLabel

- (void)drawTextInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = [UIColor whiteColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];
}

@end
