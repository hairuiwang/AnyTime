//
//  AnyTimeHUD.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/16.
//

#import "AnyTimeHUD.h"
#import "MBProgressHUD.h"

@interface AnyTimeHUD()

@property (nonatomic, strong) MBProgressHUD * hud;

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

- (void)showTextWithText:(nullable NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[AnyRouter sharedInstance] getCurrentViewController].view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.offset = CGPointMake(0.f, 0.f);
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void)showLoadingHUDWithText:(nullable NSString *)text
{
    self.hud = [MBProgressHUD showHUDAddedTo:[[AnyRouter sharedInstance] getCurrentViewController].view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = text;
    self.hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}

- (void)showLoadingHUD
{
    self.hud = [MBProgressHUD showHUDAddedTo:[[AnyRouter sharedInstance] getCurrentViewController].view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];

}



- (void)hideHUD
{
    if (self.hud) {
        [self.hud hideAnimated:YES];
        self.hud = nil;
    }
}

+ (void)showTextWithText:(nullable NSString *)text
{
    [[self sharedManager] showTextWithText:text];
}

+ (void)showLoadingHUDWithText:(nullable NSString *)text
{
    [[self sharedManager] showLoadingHUDWithText:text];
}

+(void)showLoadingHUD
{
    [[self sharedManager] showLoadingHUD];
}

+(void)hideHUD
{
    [[self sharedManager] hideHUD];
}

@end
