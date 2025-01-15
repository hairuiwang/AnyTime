//
//  AnyCertificationInfoCell.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyTextChangeBlock)(NSString *result);

@interface AnyCertificationInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy) MyTextChangeBlock textChangeHandler;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, assign) BOOL isClick;

@property (nonatomic, assign) BOOL isLeftImageView;
@end

NS_ASSUME_NONNULL_END
