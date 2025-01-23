//
//  LocationDictionaryHelper.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "LocationDictionaryHelper.h"

@implementation LocationDictionaryHelper
+ (instancetype)sharedInstance {
    static LocationDictionaryHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype) init {
    self = [super init];
    if (self) {
        self.locationManagers = [NSMutableDictionary dictionary];
    }
    return self;
}
@end
