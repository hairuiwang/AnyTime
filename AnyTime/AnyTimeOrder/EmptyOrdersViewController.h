//
//  EmptyOrdersViewController.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyOrdersViewController : UIViewController

@property (nonatomic, copy) void (^applyButtonAction)(void);
@property (nonatomic, copy) void (^tryAgainButtonAction)(void);

@property(nonatomic,assign) BOOL isNoData;

@end

NS_ASSUME_NONNULL_END
