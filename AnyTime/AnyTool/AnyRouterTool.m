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
#import "AnyVerifyldentity03ViewController.h"
#import "AnyVerifyldentitySuccessfulViewController.h"
#import "AnyPersonalInforViewController.h"
#import "AnyContactInforViewController.h"
@implementation AnyRouterTool

+ (void) registered {
    [self certificationDetails];
    [self login];
    [self anyVerifyldentityIDTypeViewController];
    [self anyVerifyldentity02ViewController];
    [self anyVerifyldentity03ViewController];
    [self anyVerifyldentitySuccessfulViewController];
    [self anyPersonalInforViewController];
    [self anyContactInforViewController];
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
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentity02ViewController *toVC = [[AnyVerifyldentity02ViewController alloc]init];
        toVC.type = type;
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void)anyVerifyldentity03ViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentity03ViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentity03ViewController *toVC = [[AnyVerifyldentity03ViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void) anyVerifyldentitySuccessfulViewController {
    
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentitySuccessfulViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentitySuccessfulViewController *toVC = [[AnyVerifyldentitySuccessfulViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void) anyPersonalInforViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyPersonalInforViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyPersonalInforViewController *toVC = [[AnyPersonalInforViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void) anyContactInforViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyContactInforViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyContactInforViewController *toVC = [[AnyContactInforViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}

@end
