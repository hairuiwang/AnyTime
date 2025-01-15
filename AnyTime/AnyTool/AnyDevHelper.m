//
//  AnyDevHelper.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyDevHelper.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <Security/Security.h>

@implementation AnyDevHelper
/// 获取设备型号
+ (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *modelCode = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSDictionary *modelMap = @{
        @"iPhone13,4": @"iPhone 12 Pro Max",
        @"iPhone14,2": @"iPhone 13 Pro",
        @"iPhone14,5": @"iPhone 13",
        @"iPhone15,3": @"iPhone 14 Pro Max",
        @"iPhone16,1": @"iPhone 15 Pro",
    };
    
    return modelMap[modelCode] ?: modelCode;
}

/// 获取 iOS 版本号
+ (NSString *)iOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *) IDFV {
    NSString *IDFV = [self loadFromKeychain:@"Any-idfv"] ?: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self saveToKeychain:IDFV value:@"Any-idfv"];
    return IDFV;
}

/// 判断是否是模拟器
+ (BOOL)isSimulator {
    return TARGET_OS_SIMULATOR;
}

/// 判断是否越狱
+ (BOOL)isJailbroken {
    NSArray *jailbreakPaths = @[
        @"/Applications/Cydia.app",
        @"/private/var/lib/apt/",
        @"/private/var/lib/cydia/"
    ];
    
    for (NSString *path in jailbreakPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 🌐 网络信息

/// 获取当前网络类型
+ (NSString *)networkType {
    // 这里需要导入 `Reachability` 或 `Network` 框架
    return @"WiFi"; // 示例
}

/// 获取运营商名称
+ (NSString *)carrierName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    return carrier.carrierName ?: @"未知";
}

#pragma mark - 🔤 字符串 & JSON

/// 字典转 JSON 字符串
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    return jsonData ? [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] : nil;
}

/// JSON 字符串转字典
+ (NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

/// Base64 加密
+ (NSString *)base64Encode:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/// Base64 解密
+ (NSString *)base64Decode:(NSString *)base64String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 🕒 日期时间

/// 获取当前时间戳（秒）
+ (NSString *)currentTimestamp {
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}

/// 获取当前时间戳（毫秒）
+ (NSString *)currentTimestampMillis {
    return [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000)];
}

#pragma mark - 🛠️ 存储工具

/// 读取 UserDefaults
+ (id)loadFromUserDefaults:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/// 保存到 UserDefaults
+ (void)saveToUserDefaults:(NSString *)key value:(id)value {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/// 读取 Keychain
+ (NSString *)loadFromKeychain:(NSString *)key {
    return @"示例 Keychain 读取";
}

/// 保存到 Keychain
+ (void)saveToKeychain:(NSString *)key value:(NSString *)value {
    NSLog(@"示例 Keychain 存储");
}

#pragma mark - 📱 应用相关

/// 获取 App 版本号
+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

/// 获取 App Bundle ID
+ (NSString *)bundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

/// 打开 App Store 评分页
+ (void)openAppStoreReview:(NSString *)appId {
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
}

/// 拨打电话
+ (void)callPhoneNumber:(NSString *)phoneNumber {
    NSString *phoneURL = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL] options:@{} completionHandler:nil];
}

@end
