//
//  AnyContactInforCell.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyClickBlock)(void);
@interface AnyContactInforCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *relationshipTextField;
@property (strong, nonatomic) IBOutlet UIButton *relationshipButton;
@property (strong, nonatomic) IBOutlet UITextField *contactTextField;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;

@property (nonatomic, copy) MyClickBlock relationHandler;
@property (nonatomic, copy) MyClickBlock contactHandler;
@end

NS_ASSUME_NONNULL_END
