//
//  AnyInfoConfirmedView.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^DateClickBlock)(void);

@interface AnyInfoConfirmedView : UIView
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) DateClickBlock dateHandler;

@end

NS_ASSUME_NONNULL_END
