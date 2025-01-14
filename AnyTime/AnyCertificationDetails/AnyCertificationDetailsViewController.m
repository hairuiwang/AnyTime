//
//  AnyCertificationDetailsViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyCertificationDetailsViewController.h"

@interface AnyCertificationDetailsViewController ()

@end

@implementation AnyCertificationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    self.navigationItem.title = @"Product Detail";
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:true];
}
@end
