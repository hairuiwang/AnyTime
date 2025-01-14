//
//  AnyTimeMeSettingTableViewCell.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyTimeMeSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *arrowImageView;

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
