//
//  AnyVerifyldentityBaseViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentityBaseViewController.h"
#import "AnyAreYouPop.h"
#import "AnyCertificationDetailsViewController.h"
@interface AnyVerifyldentityBaseViewController ()

@end

@implementation AnyVerifyldentityBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    self.view.backgroundColor = HEXCOLOR(0xFFECD7);
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    
    
    self.topImageView = [UIImageView new];
    self.topImageView.image = [UIImage imageNamed:@"VerifyldentityTopImageView"];
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
        make.height.mas_equalTo(126);
    }];
    
    
    UIButton *sureButton = [AnyUIFactory buttonWithTitle:@"Sure" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(sureButtonClick)];
    [self.view addSubview:sureButton];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(273);
    }];
    self.sureButton = sureButton;
}
- (void)backClick {
    AnyAreYouPop *popVC = [[AnyAreYouPop alloc] init];
    popVC.giveUpBlock = ^{
        UIViewController *viewControllers = self.navigationController.viewControllers;
        for (UIViewController *toVC in viewControllers) {
            if ([toVC isKindOfClass:[AnyCertificationDetailsViewController class]]) {
                [self.navigationController popToViewController:toVC animated:YES];
                return;
            }
        }
    };
    popVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentModalViewController:popVC animated:YES];
//    [self.navigationController popViewControllerAnimated:true];
}
- (void) sureButtonClick {
    
}
@end
