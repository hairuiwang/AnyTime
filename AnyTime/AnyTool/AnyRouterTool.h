//
//  AnyRouterTool.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyRouterTool : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, assign) NSInteger chin;
+ (void)openAppSettings;
+ (void) registered;
/// 跳转详情
+ (void)jumpCertificationDetails:(NSString *)box;

/// 点击申请
/// - Parameter box: 产品ID
+ (void)applyForBox:(NSString *)box;
@end

NS_ASSUME_NONNULL_END
