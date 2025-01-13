//
//  AnyTimeCustomPopupView.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyTimeCustomPopupView : UIView


@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) NSString *titleText;

@property (nonatomic, strong) NSString *descriptionText;

@property (nonatomic, strong) NSString *firstButtonTitle;

@property (nonatomic, strong) NSString *secondButtonTitle;

@property (nonatomic, copy) void (^closeAction)(void);

@property (nonatomic, copy) void (^firstButtonAction)(void);

@property (nonatomic, copy) void (^secondButtonAction)(void);

- (void)showInView:(UIView *)parentView;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
