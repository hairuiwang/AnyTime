//
//  LocationDictionaryHelper.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>
#import "AnyLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationDictionaryHelper : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) NSMutableDictionary<NSString *, AnyLocationManager *> *locationManagers;
@end

NS_ASSUME_NONNULL_END
