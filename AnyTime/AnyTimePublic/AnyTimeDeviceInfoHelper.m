//
//  AnyTimeDeviceInfoHelper.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/23.
//

#import "AnyTimeDeviceInfoHelper.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <mach/mach_time.h>
#include <sys/sysctl.h>
#import <CoreTelephony/CTCarrier.h>

#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation AnyTimeDeviceInfoHelper

+ (instancetype)sharedInstance {
    static AnyTimeDeviceInfoHelper *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[self alloc] init];
    });
    return device;
}

+ (NSString *)getDeviceInfoJson
{
    return [[self sharedInstance] generateDeviceInfoJson];
}

- (NSString *)generateDeviceInfoJson
{
    UIDevice *device = [UIDevice currentDevice];
    [device setBatteryMonitoringEnabled:YES];
    
    NSDictionary *wifiInfo = [self getCurrentWiFiInfo];
    if (wifiInfo) {
        NSArray * wifiArray = @[@{@"groove": wifiInfo[@"SSID"],
                                 @"same": wifiInfo[@"BSSID"],
                                 @"based": wifiInfo[@"BSSID"],
                                 @"sight": wifiInfo[@"SSID"]}];
    }
    
    NSDictionary *storageInfo = [self getDeviceStorageInfo];
    NSDictionary *memoryInfo = [self getMemoryInfo];

    NSDictionary * infoDic = @{
        @"goodbye":[[UIDevice currentDevice] systemName]?:@"",
        @"two":[[UIDevice currentDevice] systemVersion]?:@"",
        @"pushed":[AnyDevHelper loadFromUserDefaults:@"loginEndTime"] ?: @"",
        @"line":[[NSBundle mainBundle] bundleIdentifier]?:@"",
        @"draw":@{
                @"where":@(device.batteryLevel * 100)?:0,
                @"doubt":@(device.batteryState == UIDeviceBatteryStateCharging ? 1 : 0)
        },
        @"situation":@{
                @"each":[[UIDevice currentDevice] identifierForVendor].UUIDString?:@"",
                @"closer":[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString?:@"",
                @"based":[self getMacAddress]?:@"",
                @"annoyed":@(NSDate.date.timeIntervalSince1970 * 1000),
                @"saw":@([self isUsingProxy]?:0),
                @"faint":[NSNumber numberWithBool:[self isVPNConnected]],
                @"very":[NSNumber numberWithBool:[self isJailbroken]],
                @"reason":[NSNumber numberWithBool:[self isSimulator]],
                @"purity":[[NSLocale preferredLanguages] firstObject]?:@"",
                @"unexplainable":[self getCarrierName]?:@"",
                @"disappeared":[self getCurrentNetworkType]?:@"",
                @"emitting":[self getTimezoneID]?:@"",
                @"scary":@([self getDeviceUptime])?:@""
        },
        @"am":@{
                @"don": @"",
                @"heard": @"Apple",
                @"off": @"",
                @"moving": @(SCREEN_HEIGHT),
                @"order": @(SCREEN_WIDTH),
                @"gave": [self getDeviceName]?:@"",
                @"needs": [self getDeviceModel]?:@"",
                @"whatever": [self getDevicePhysicalSize]?:@"",
                @"proper": [[UIDevice currentDevice] systemVersion]?:@"",
        },
        @"useful":@{
            @"pretty":[self getIPAddress]?:@"",
            @"here":@[
                @{
                    @"groove": wifiInfo[@"SSID"]?:@"",
                    @"same": wifiInfo[@"BSSID"]?:@"",
                    @"based": wifiInfo[@"BSSID"]?:@"",
                    @"sight": wifiInfo[@"SSID"]?:@""
                },
            ],
            @"them":@{
                @"groove": wifiInfo[@"SSID"]?:@"",
                @"same": wifiInfo[@"BSSID"]?:@"",
                @"based": wifiInfo[@"BSSID"]?:@"",
                @"sight": wifiInfo[@"SSID"]?:@""
            },
            @"both":@1,
        },
        @"decided":@{
            @"flinch":storageInfo[@"freeStorage"]?:0,
            @"shoulder":storageInfo[@"totalStorage"]?:0,
            @"almost":memoryInfo[@"totalMemory"]?:0,
            @"talented":memoryInfo[@"freeMemory"]?:0
        }
    };
    
   
    // 转换为 JSON 字符串
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"Error creating JSON: %@", error);
        return nil;
    }
    
    // 将 JSON 字符串 Base64 编码
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSString *base64String = [self base64EncodeString:jsonString];
    
    // 返回包含Base64编码的 JSON 字符串
    return base64String;
}

- (NSString *)getIPAddress {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *address = @"error";
    
    // 获取所有网络接口信息
    if (getifaddrs(&interfaces) == 0) {
        temp_addr = interfaces;
        
        // 遍历每个接口
        while (temp_addr != NULL) {
            // 判断是否是 IPv4 地址
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // 只处理 en0 接口（通常是 Wi-Fi 接口）
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 获取该接口的 IP 地址并转化为字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // 释放资源
    freeifaddrs(interfaces);
    
    return address;
}


- (NSString *)getDevicePhysicalSize {
    NSString *deviceModel = [self getDeviceModel];
    
    // iPhone 16 系列
    if ([deviceModel isEqualToString:@"iPhone17,1"]) {  // iPhone 16（标准版）
        return @"147.2 x 71.7 x 7.9 mm";
    } else if ([deviceModel isEqualToString:@"iPhone17,2"]) {  // iPhone 16 Plus
        return @"161.0 x 79.5 x 7.9 mm";
    } else if ([deviceModel isEqualToString:@"iPhone17,3"]) {  // iPhone 16 Pro
        return @"147.5 x 71.7 x 8.3 mm";
    } else if ([deviceModel isEqualToString:@"iPhone17,4"]) {  // iPhone 16 Pro Max
        return @"161.5 x 78.2 x 8.3 mm";
    }
    
    // iPhone 15 系列
    else if ([deviceModel isEqualToString:@"iPhone16,1"]) {  // iPhone 15
        return @"146.6 x 70.6 x 7.8 mm";
    } else if ([deviceModel isEqualToString:@"iPhone16,2"]) {  // iPhone 15 Plus
        return @"160.8 x 78.1 x 7.8 mm";
    } else if ([deviceModel isEqualToString:@"iPhone16,3"]) {  // iPhone 15 Pro
        return @"146.6 x 70.6 x 8.25 mm";
    } else if ([deviceModel isEqualToString:@"iPhone16,4"]) {  // iPhone 15 Pro Max
        return @"160.7 x 77.6 x 8.25 mm";
    }

    // iPhone 14 系列
    else if ([deviceModel isEqualToString:@"iPhone15,2"]) {  // iPhone 14
        return @"146.7 x 71.5 x 7.8 mm";
    } else if ([deviceModel isEqualToString:@"iPhone15,3"]) {  // iPhone 14 Plus
        return @"160.8 x 78.1 x 7.8 mm";
    } else if ([deviceModel isEqualToString:@"iPhone15,4"]) {  // iPhone 14 Pro
        return @"147.5 x 71.5 x 7.85 mm";
    } else if ([deviceModel isEqualToString:@"iPhone15,5"]) {  // iPhone 14 Pro Max
        return @"160.7 x 77.6 x 7.85 mm";
    }

    // iPhone 13 系列
    else if ([deviceModel isEqualToString:@"iPhone14,2"]) {  // iPhone 13 Pro
        return @"146.7 x 71.5 x 7.65 mm";
    } else if ([deviceModel isEqualToString:@"iPhone14,5"]) {  // iPhone 13
        return @"146.7 x 71.5 x 7.65 mm";
    } else if ([deviceModel isEqualToString:@"iPhone13,2"]) {  // iPhone 12
        return @"146.7 x 71.5 x 7.4 mm";
    } else if ([deviceModel isEqualToString:@"iPhone12,1"]) {  // iPhone 11
        return @"146.7 x 71.5 x 8.3 mm";
    
    // iPhone XS, XS Max, XR
    } else if ([deviceModel isEqualToString:@"iPhone12,3"]) {  // iPhone XS
        return @"143.6 x 70.9 x 7.7 mm";
    } else if ([deviceModel isEqualToString:@"iPhone12,5"]) {  // iPhone XS Max
        return @"157.5 x 77.4 x 7.7 mm";
    } else if ([deviceModel isEqualToString:@"iPhone11,8"]) {  // iPhone XR
        return @"150.9 x 75.7 x 8.3 mm";
    }

    // 其他系列设备，继续根据硬件标识符补充
    // iPhone 8, 8 Plus, X, 7, 7 Plus, 6s 系列等
    else if ([deviceModel isEqualToString:@"iPhone10,1"]) {  // iPhone 8
        return @"138.4 x 67.3 x 7.3 mm";
    } else if ([deviceModel isEqualToString:@"iPhone10,4"]) {  // iPhone 8
        return @"138.4 x 67.3 x 7.3 mm";
    } else if ([deviceModel isEqualToString:@"iPhone9,1"]) {  // iPhone 7
        return @"138.3 x 67.1 x 7.1 mm";
    } else if ([deviceModel isEqualToString:@"iPhone9,2"]) {  // iPhone 7 Plus
        return @"158.2 x 77.9 x 7.3 mm";
    }

    // 默认未知设备
    return @"Unknown Device";  // 如果设备型号不在映射中，返回未知
}



- (NSString *)getDeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *modelString = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    
    return modelString;  // 返回硬件标识符 (例如 "iPhone12,1")
}


- (NSString *)getDeviceName {
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceName = device.name;
    return deviceName;  // 返回用户自定义的设备名称，例如 "John's iPhone"
}


- (NSInteger)getDeviceUptime {
    uint64_t uptime = mach_absolute_time();
    
    // 由于 mach_absolute_time 返回的是纳秒，所以需要转换为毫秒
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    
    uptime *= timebase.numer;
    uptime /= timebase.denom;
    
    return (NSInteger)(uptime / 1000000); // 毫秒数
}


- (NSString *)getTimezoneID {
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    return timeZone.name; // 返回 GMT+8 这种格式
}

- (NSString *)getCurrentNetworkType {
    // 先检查是否连接到 WiFi
    NSString *wifiType = [self getWifiNetworkType];
    if ([wifiType isEqualToString:@"WIFI"]) {
        return wifiType; // 如果连接到 WiFi，直接返回 WiFi 类型
    }
    
    // 如果不是 WiFi，则检查蜂窝网络类型
    return [self getCellularNetworkType];
}

// 判断是否连接到 WiFi
- (NSString *)getWifiNetworkType {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "www.google.com");
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);

    // 如果网络可达且不是蜂窝网络，则为 WiFi
    if ((flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsIsDirect)) {
        return @"WIFI";
    }
    return @"OTHER"; // 不是 WiFi 网络，返回 OTHER
}

// 获取蜂窝网络类型（2G/3G/4G/5G）
- (NSString *)getCellularNetworkType {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *networkType = networkInfo.currentRadioAccessTechnology;
    
    if ([networkType isEqualToString:CTRadioAccessTechnologyLTE]) {
        return @"4G";
    } else if ([networkType isEqualToString:CTRadioAccessTechnologyWCDMA]) {
        return @"3G";
    } else if ([networkType isEqualToString:CTRadioAccessTechnologyEdge]) {
        return @"2G";
    } else if (@available(iOS 14.1, *)) {
        if ([networkType isEqualToString:CTRadioAccessTechnologyNRNSA] ||
            [networkType isEqualToString:CTRadioAccessTechnologyNR]) {
            return @"5G";
        }
    } else {
        // Fallback on earlier versions
    }
    
    return @"OTHER"; // 默认返回 OTHER，表示未知或其他网络类型
}


- (NSString *)getCarrierName {
    // 创建 CTTelephonyNetworkInfo 实例
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    // 获取当前运营商信息
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];  // 获取单个运营商信息

    // 如果没有获取到运营商名称，返回 "Unknown"
    return carrier.carrierName ?: @"Unknown";  // 使用空值合并运算符
}



// 检查网络请求是否经过代理
- (NSInteger)isUsingProxy {
    // 获取系统代理设置
    NSDictionary *proxySettings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    
    // 获取 HTTPEnable 键对应的值，它是一个 NSNumber 类型
    NSNumber *httpEnable = proxySettings[@"HTTPEnable"];
    
    // 如果 HTTPEnable 存在且值为 1，返回 1，否则返回 0
    return httpEnable != nil && [httpEnable boolValue] ? 1 : 0;
}



- (BOOL)isVPNConnected {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "www.google.com");
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    return (flags & kSCNetworkFlagsIsDirect) == 0; // 如果是WWAN，就不是VPN
}

- (BOOL)isJailbroken {
    // 检查文件系统中的特定文件是否存在
    NSArray *jailbreakPaths = @[
        @"/Applications/Cydia.app",
        @"/bin/bash",
        @"/usr/sbin/sshd",
        @"/etc/apt"
    ];
    
    for (NSString *path in jailbreakPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isSimulator {
    #if TARGET_OS_SIMULATOR
        return YES;
    #else
        return NO;
    #endif
}


- (NSString *)getMacAddress {
    NSArray *interfaces = (__bridge_transfer id)CNCopySupportedInterfaces();
    if (interfaces.count > 0) {
        NSDictionary *wifiInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaces[0]));
        return wifiInfo[@"BSSID"];
    }
    return @"";
}

- (NSDictionary *)getCurrentWiFiInfo {
    NSArray *interfaces = (__bridge_transfer id)CNCopySupportedInterfaces();
    if (interfaces.count > 0) {
        NSDictionary *wifiInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaces[0]));
        return wifiInfo;
    }
    return nil;
}

- (NSDictionary *)getDeviceStorageInfo {
    NSError *error = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return nil;

    NSNumber *totalSpace = [fileAttributes objectForKey:NSFileSystemSize];
    NSNumber *freeSpace = [fileAttributes objectForKey:NSFileSystemFreeSize];
    return @{
        @"totalStorage" : totalSpace,
        @"freeStorage" : freeSpace
    };
}

- (NSDictionary *)getMemoryInfo {
    mach_task_basic_info_data_t info;
    mach_msg_type_number_t infoCount = MACH_TASK_BASIC_INFO_COUNT;
    if (task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &infoCount) != KERN_SUCCESS) {
        return nil;
    }
    return @{
        @"totalMemory" : @(info.resident_size),
        @"freeMemory" : @(info.virtual_size)
    };
}

- (NSString *)base64EncodeString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

@end
