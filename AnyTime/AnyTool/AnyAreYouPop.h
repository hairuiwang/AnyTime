//
//  AnyAreYouPop.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GiveUpBlock)(void);
typedef void(^ConfirmBlock)(void);
@interface AnyAreYouPop : UIViewController
@property (nonatomic, copy) GiveUpBlock giveUpBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end

NS_ASSUME_NONNULL_END
