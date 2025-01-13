//
//  AnyRouterTool.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyRouterTool.h"

@implementation AnyRouterTool

+ (void) registered {
    [self certificationDetails];
}
+ (void)certificationDetails {
    [[AnyRouter sharedInstance] registerRoute:@"" handler:^(NSDictionary * _Nullable, UIViewController * _Nullable, RouterCallback _Nullable) {
        
    }];
}
@end
