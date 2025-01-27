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

@property (nonatomic, strong) NSString *date;

@property (nonatomic, copy) void (^closeAction)(void);

@property (nonatomic, copy) void (^firstButtonAction)(void);

@property (nonatomic, copy) void (^secondButtonAction)(void);

@property (nonatomic, copy) void (^dateSelectAction)(NSString * date);

@property (nonatomic, copy) void (^camcerButtonAction)(void);

@property (nonatomic, copy) void (^photosButtonAction)(void);

- (instancetype)initGoOutAccountWithFrame:(CGRect)frame;

- (instancetype)initCancellationAccountWithFrame:(CGRect)frame;

- (instancetype)initNoNetWorkWithFrame:(CGRect)frame;

- (instancetype)initDateSelectionWithFrame:(CGRect)frame WithDateString:(NSString *)dateString;

- (instancetype)initPhotoGraphWithFrame:(CGRect)frame;

- (void)showInView:(UIView *)parentView;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
