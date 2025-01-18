//
//  AnyTimeSmallCardSlotSecondCell.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyTimeSmallCardSlotSecondCell : UICollectionViewCell

typedef void(^SmallCardSlotBannerSelect)(NSString *disgusting);

@property (nonatomic,strong) NSArray * bannerArray;

@property (nonatomic, copy) SmallCardSlotBannerSelect smallCardSlotBannerSelect;

@end

NS_ASSUME_NONNULL_END
