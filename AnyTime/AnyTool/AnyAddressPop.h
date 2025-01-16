//
//  AnyAddressPop.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyAddressSelect)(NSString *address);

@interface AnyAddressPop : UIViewController
@property (nonatomic, copy) MyAddressSelect addressHandler;
@end

NS_ASSUME_NONNULL_END
