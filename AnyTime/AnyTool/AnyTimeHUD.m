//
//  AnyTimeHUD.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/16.
//

#import "AnyTimeHUD.h"
#import "MBProgressHUD.h"

@interface AnyTimeHUD()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation AnyTimeHUD

+ (instancetype)sharedManager {
    static AnyTimeHUD *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AnyTimeHUD alloc] init];
    });
    return manager;
}

- (void)showTextWithText:(nullable NSString *)text inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.offset = CGPointMake(0.f, 0.f);
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void)showLoadingHUDWithText:(nullable NSString *)text InView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];

}

- (void)showLoadingHUDInView:(UIView *)view
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];

}

- (void)hideHUDInView:(UIView *)view 
{
    if (self.hud) {
        [self.hud hideAnimated:YES];
        self.hud = nil;
    }
}


@end
