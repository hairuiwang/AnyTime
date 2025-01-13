//
//  AnyRouter.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RouterCallback)(NSDictionary * _Nullable result);


@interface AnyRouter : NSObject


/// **单例**
+ (instancetype)sharedInstance;

/// **注册路由**
- (void)registerRoute:(NSString *)route handler:(void (^)(NSDictionary * _Nullable, UIViewController * _Nullable, RouterCallback _Nullable))handler;

/// **跳转路由**
- (void)openURL:(NSString *)url from:(UIViewController * _Nullable)sourceVC callback:(RouterCallback _Nullable)callback;


@end

NS_ASSUME_NONNULL_END
