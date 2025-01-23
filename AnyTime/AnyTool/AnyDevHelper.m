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
    
    return [self deviceNameForModelCode:modelCode];
}

/// 根据型号代码返回设备名称
+ (NSString *)deviceNameForModelCode:(NSString *)modelCode {
    NSDictionary *modelMap = @{
        // iPhone 6 及以后
        @"iPhone7,2": @"iPhone 6",
        @"iPhone8,1": @"iPhone 6s",
        @"iPhone8,2": @"iPhone 6s Plus",
        @"iPhone9,1": @"iPhone 7",
        @"iPhone9,2": @"iPhone 7 Plus",
        @"iPhone10,1": @"iPhone 8",
        @"iPhone10,2": @"iPhone 8 Plus",
        @"iPhone10,3": @"iPhone X",
        @"iPhone11,2": @"iPhone XS",
        @"iPhone11,4": @"iPhone XS Max",
        @"iPhone11,8": @"iPhone XR",
        @"iPhone12,1": @"iPhone 11",
        @"iPhone12,3": @"iPhone 11 Pro",
        @"iPhone12,5": @"iPhone 11 Pro Max",
        @"iPhone13,1": @"iPhone 12 Mini",
        @"iPhone13,2": @"iPhone 12",
        @"iPhone13,3": @"iPhone 12 Pro",
        @"iPhone13,4": @"iPhone 12 Pro Max",
        @"iPhone14,2": @"iPhone 13 Pro",
        @"iPhone14,3": @"iPhone 13 Pro Max",
        @"iPhone14,4": @"iPhone 13 Mini",
        @"iPhone14,5": @"iPhone 13",
        @"iPhone15,2": @"iPhone 14 Pro",
        @"iPhone15,3": @"iPhone 14 Pro Max",
        @"iPhone15,4": @"iPhone 14 Plus",
        @"iPhone15,5": @"iPhone 14",
        @"iPhone16,1": @"iPhone 15 Pro",
        @"iPhone16,2": @"iPhone 15 Pro Max",
        @"iPhone16,3": @"iPhone 15",
        @"iPhone16,4": @"iPhone 15 Plus",
    };
    
    // iPhone 6 之前的型号处理逻辑
    NSArray *unsupportedModels = @[
        @"iPhone1,", @"iPhone2,", @"iPhone3,", @"iPhone4,", @"iPhone5,", @"iPhone6,"
    ];
    
    for (NSString *prefix in unsupportedModels) {
        if ([modelCode hasPrefix:prefix]) {
            return @"iPhone (unsupported model)";
        }
    }
    
    return modelMap[modelCode] ?: modelCode;
}

/// 获取 iOS 版本号
+ (NSString *)iOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *) IDFV {
    NSString *IDFV = [self loadFromKeychain:@"Any-idfv-app"] ?: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self saveToKeychain:IDFV value:@"Any-idfv-app"];
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

+ (NSString *)jsonStringFromArray:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]] || array.count == 0) {
        return @""; // 空数组或者非数组类型，返回 JSON 格式的空数组字符串
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    
    if (error) {
        return @"";
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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

/// 读取BOOL UserDefaults
+ (BOOL)loadBoolFromUserDefaults:(NSString *)key 
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

/// 保存BOOL到 UserDefaults
+ (void)saveBoolToUserDefaults:(NSString *)key value:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/// 读取 Keychain
+ (NSString *)loadFromKeychain:(NSString *)key {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    // 配置查询条件
    query[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    query[(__bridge id)kSecAttrAccount] = key;
    query[(__bridge id)kSecReturnData] = @YES; // 返回数据
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne; // 限制为只匹配一个
    
    CFTypeRef result = NULL;
    
    // 执行查询
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    if (status == errSecSuccess) {
        NSData *data = (__bridge NSData *)(result);
        NSString *password = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return password;
    } else {
        NSLog(@"读取失败，错误代码: %d", (int)status);
        return nil;
    }
}

/// 保存到 Keychain
+ (void)saveToKeychain:(NSString *)key value:(NSString *)value {
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *query = @{(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount: key};
    SecItemDelete((__bridge CFDictionaryRef)query);
    
    NSDictionary *attributes = @{(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrAccount: key,
                                 (__bridge id)kSecValueData: valueData};
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
    
    if (status == errSecSuccess) {
        NSLog(@"✅ Keychain 存储成功: %@", key);
    } else {
        NSLog(@"❌ Keychain 存储失败: %d", (int)status);
    }
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
