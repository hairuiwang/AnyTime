//
//  AnySelectCell.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>
#import "AnySelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnySelectCell : UITableViewCell
@property (nonatomic, assign) BOOL isImage;
@property (nonatomic, assign) BOOL isChose;
@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
