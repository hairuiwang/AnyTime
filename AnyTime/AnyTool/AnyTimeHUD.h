//
//  AnyTimeHUD.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyTimeHUD : NSObject

+ (instancetype)sharedManager;

- (void)showTextWithText:(nullable NSString *)text inView:(UIView *)view;

- (void)showLoadingHUDWithText:(nullable NSString *)text InView:(UIView *)view;

- (void)showLoadingHUDInView:(UIView *)view;

- (void)hideHUDInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
