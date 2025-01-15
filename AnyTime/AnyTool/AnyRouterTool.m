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
#import "AnyVerifyldentityIDTypeViewController.h"
#import "AnyVerifyldentity02ViewController.h"

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
+ (void)anyVerifyldentityIDTypeViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentityIDTypeViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        AnyVerifyldentityIDTypeViewController *toVC = [[AnyVerifyldentityIDTypeViewController alloc]init];
        toVC.parameters = parameters;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void)anyVerifyldentity02ViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentity02ViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSString *type = parameters[@"type"];
//        NSDictionary
        AnyVerifyldentity02ViewController *toVC = [[AnyVerifyldentity02ViewController alloc]init];
//        toVC.type =
        toVC.parameters = parameters;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
@end
