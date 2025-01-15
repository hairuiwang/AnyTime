//
//  AnyRouterTool.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyRouterTool.h"
#import "AnyCertificationDetailsViewController.h"
#import "AnyTimeLoginViewController.h"

@implementation AnyRouterTool

+ (void) registered {
    [self certificationDetails];
}
+ (void)certificationDetails {
    [[AnyRouter sharedInstance] registerRoute:@"/certificationDetails" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        AnyCertificationDetailsViewController *toVC = [[AnyCertificationDetailsViewController alloc]init];
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void)login {
    [[AnyRouter sharedInstance] registerRoute:@"/login" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        AnyTimeLoginViewController *toVC = [[AnyTimeLoginViewController alloc]init];
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
@end
