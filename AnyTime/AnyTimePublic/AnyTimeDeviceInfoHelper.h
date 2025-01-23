//
//  AnyTimeDeviceInfoHelper.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <mach/mach.h>
#import <AdSupport/AdSupport.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyTimeDeviceInfoHelper : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)getDeviceInfoJson;

@end

NS_ASSUME_NONNULL_END
