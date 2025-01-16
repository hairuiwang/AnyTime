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

+ (void)showTextWithText:(nullable NSString *)text;

+ (void)showLoadingHUDWithText:(nullable NSString *)text;

+(void)showLoadingHUD;
+(void)hideHUD;
@end

NS_ASSUME_NONNULL_END
