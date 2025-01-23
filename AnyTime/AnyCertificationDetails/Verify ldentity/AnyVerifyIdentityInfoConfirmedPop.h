//
//  AnyVerifyIdentityInfoConfirmedPop.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AuthenticationComplete)(void);

@interface AnyVerifyIdentityInfoConfirmedPop : UIViewController
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSDictionary *detailParameters;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, copy) AuthenticationComplete complete;
@end

NS_ASSUME_NONNULL_END
