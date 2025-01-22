//
//  AnySelectPop.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>
#import "AnySelectCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^MyAnySelectValue)(NSString *address, NSInteger index);

@interface AnySelectPop : UIViewController
@property (nonatomic, copy) MyAnySelectValue selectHandler;
@property (nonatomic, assign) BOOL isImage;
@property (nonatomic, strong) NSArray<AnySelectModel *> *dataSourceArray;
@property (nonatomic, strong)UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
