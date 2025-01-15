//
//  AnyPersonalInforBaseViewController.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyPersonalInforBaseViewController : UIViewController
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIButton *sureButton;
- (void)setupUI;
- (void)sureButtonClick;
@end

NS_ASSUME_NONNULL_END
