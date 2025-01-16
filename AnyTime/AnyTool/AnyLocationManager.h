//
//  AnyLocationManager.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LocationAuthCallback)(BOOL granted);
typedef void(^LocationResultCallback)(NSString *latitude, NSString *longitude);
typedef void(^GeocodeCallback)(NSDictionary * _Nullable addressInfo);


@interface AnyLocationManager : NSObject

/// **单例**
+ (instancetype)sharedInstance;

/// **获取定位授权状态**
- (void)requestAuthorization:(LocationAuthCallback)callback;

/// **获取经纬度（带超时逻辑）**
- (void)getCurrentLocationWithCallback:(LocationResultCallback)callback;

/// **逆地理编码**
- (void)reverseGeocodeCurrentLocationWithCallback:(GeocodeCallback)callback;
@end

NS_ASSUME_NONNULL_END
