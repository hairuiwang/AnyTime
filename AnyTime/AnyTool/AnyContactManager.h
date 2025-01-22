//
//  AnyContactManager.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^ContactSelectionCallback)(NSString *name, NSString *phoneNumber);

@interface AnyContactManager : NSObject


// 获取权限状态
+ (void)requestContactAccessWithCompletion:(void(^)(BOOL granted))completion;

// 选择联系人
- (void)selectContactFromViewController:(UIViewController *)viewController callback:(ContactSelectionCallback)callback;

// 获取所有联系人
- (void)getAllContactsWithCompletion:(void(^)(NSArray<NSDictionary *> *contacts))completion;

@end

NS_ASSUME_NONNULL_END
