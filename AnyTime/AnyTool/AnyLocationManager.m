//
//  AnyLocationManager.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyLocationManager.h"

@interface AnyLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) LocationAuthCallback authCallback;
@property (nonatomic, copy) LocationResultCallback locationCallback;
@property (nonatomic, strong) NSTimer *timeoutTimer;
@property (nonatomic, strong) CLLocation *lastLocation;

@end

@implementation AnyLocationManager

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static AnyLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

#pragma mark - 获取定位授权状态
- (void)requestAuthorization:(LocationAuthCallback)callback {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (callback) callback(YES);
    } else if (status == kCLAuthorizationStatusDenied) {
        if (callback) callback(NO);
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        self.authCallback = callback;
        [_locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - 获取经纬度（支持超时）
- (void)getCurrentLocationWithCallback:(LocationResultCallback)callback {
    self.locationCallback = callback;
    
    // **开始定位**
    [_locationManager startUpdatingLocation];
    
    // **7 秒超时处理**
    self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(handleLocationTimeout) userInfo:nil repeats:NO];
}

#pragma mark - 超时处理
- (void)handleLocationTimeout {
    [_locationManager stopUpdatingLocation];
    
    // **读取本地缓存的经纬度**
    NSString *cachedLatitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastLatitude"] ?: @"";
    NSString *cachedLongitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastLongitude"] ?: @"";

    if (self.locationCallback) {
        self.locationCallback(cachedLatitude, cachedLongitude);
        self.locationCallback = nil;
    }
}

#pragma mark - CLLocationManager 代理方法（成功获取定位）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];
    [self.timeoutTimer invalidate];

    CLLocation *location = locations.lastObject;
    NSString *latitude = [NSString stringWithFormat:@"%.6f", location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.6f", location.coordinate.longitude];

    // **缓存经纬度**
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"LastLatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"LastLongitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // **回调**
    if (self.locationCallback) {
        self.locationCallback(latitude, longitude);
        self.locationCallback = nil;
    }
}

#pragma mark - CLLocationManager 代理方法（失败）
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [_locationManager stopUpdatingLocation];
    [self.timeoutTimer invalidate];

    if (self.locationCallback) {
        self.locationCallback(@"", @"");
        self.locationCallback = nil;
    }
}

#pragma mark - 监听授权状态变化
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.authCallback && status != kCLAuthorizationStatusNotDetermined) {
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
            self.authCallback(YES);
        } else {
            self.authCallback(NO);
        }
        self.authCallback = nil; // **授权回调完成后不再监听**
    }
}

#pragma mark - 逆地理编码（实时获取当前位置）
- (void)reverseGeocodeCurrentLocationWithCallback:(GeocodeCallback)callback {
    // **先获取当前位置**
    [self getCurrentLocationWithCallback:^(NSString *latitude, NSString *longitude) {
        if (latitude.length == 0 || longitude.length == 0) {
            if (callback) callback(nil);
            return;
        }
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];

        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error || placemarks.count == 0) {
                if (callback) callback(nil);
                return;
            }

            CLPlacemark *placemark = placemarks.firstObject;
            NSDictionary *addressInfo = @{
                @"province": placemark.administrativeArea ?: @"",
                @"city": placemark.locality ?: @"",
                @"countryCode": placemark.ISOcountryCode ?: @"",
                @"country": placemark.country ?: @"",
                @"street": placemark.thoroughfare ?: @"",
                @"latitude": latitude,
                @"longitude": longitude
            };

            if (callback) callback(addressInfo);
        }];
    }];
}

@end
