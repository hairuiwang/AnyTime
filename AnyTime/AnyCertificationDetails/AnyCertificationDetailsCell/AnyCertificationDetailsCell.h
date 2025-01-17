//
//  AnyCertificationDetailsCell.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyCertificationDetailsCell : UITableViewCell
@property (nonatomic, assign) BOOL isBy;
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subLabel;
@end

NS_ASSUME_NONNULL_END
