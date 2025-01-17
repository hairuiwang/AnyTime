//
//  AnyTimeLargeCardSlotSecondCell.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LargeCardSlotBannerSelect)(NSString *disgusting);

@interface AnyTimeLargeCardSlotSecondCell : UICollectionViewCell

@property (nonatomic,strong) NSArray * bannerArray;

@property (nonatomic, copy) LargeCardSlotBannerSelect largeCardSlotBannerSelect;

@end

NS_ASSUME_NONNULL_END
