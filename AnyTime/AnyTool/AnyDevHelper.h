//
//  AnyDevHelper.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>
#import <UIKit/UIKey.h>
NS_ASSUME_NONNULL_BEGIN

@interface AnyDevHelper : NSObject
#pragma mark - 📱 设备信息
/// 获取设备型号（如 "iPhone 13 Pro"）
+ (NSString *)deviceModel;

/// 获取 iOS 版本号（如 "17.2"）
+ (NSString *)iOSVersion;

+ (NSString *) IDFV;
/// 判断是否是模拟器
+ (BOOL)isSimulator;

/// 判断是否越狱
+ (BOOL)isJailbroken;

#pragma mark - 🌐 网络信息
/// 获取当前网络类型（WiFi/蜂窝数据/无网络）
+ (NSString *)networkType;

/// 获取运营商名称（如 "China Mobile"）
+ (NSString *)carrierName;

#pragma mark - 🔤 字符串 & JSON
/// 字典转 JSON 字符串
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dict;
+ (NSString *)jsonStringFromArray:(NSArray *)array;
/// JSON 字符串转字典
+ (NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString;

/// Base64 加密字符串
+ (NSString *)base64Encode:(NSString *)string;

/// Base64 解密字符串
+ (NSString *)base64Decode:(NSString *)base64String;

#pragma mark - 🕒 日期时间
/// 获取当前时间戳（秒）
+ (NSString *)currentTimestamp;

/// 获取当前时间戳（毫秒）
+ (NSString *)currentTimestampMillis;

#pragma mark - 🛠️ 存储工具
/// 读取 UserDefaults
+ (nullable id)loadFromUserDefaults:(NSString *)key;

/// 保存到 UserDefaults
+ (void)saveToUserDefaults:(NSString *)key value:(id)value;

/// 读取 BOOL UserDefaults
+ (BOOL)loadBoolFromUserDefaults:(NSString *)key;
/// 保存BOOL 到 UserDefaults
+ (void)saveBoolToUserDefaults:(NSString *)key value:(BOOL)value;

/// 读取 Keychain
+ (nullable NSString *)loadFromKeychain:(NSString *)key;

/// 保存到 Keychain
+ (void)saveToKeychain:(NSString *)key value:(NSString *)value;

#pragma mark - 📱 应用相关
/// 获取 App 版本号
+ (NSString *)appVersion;

/// 获取 App Bundle ID
+ (NSString *)bundleID;

/// 打开 App Store 评分页
+ (void)openAppStoreReview:(NSString *)appId;

/// 拨打电话
+ (void)callPhoneNumber:(NSString *)phoneNumber;
@end

NS_ASSUME_NONNULL_END
