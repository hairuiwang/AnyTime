//
//  AnyContactManager.m
//  AnyTime
//
//  Created by wealon on 2025.
//  AnyTime.
//


#import "AnyContactManager.h"

@interface AnyContactManager () <CNContactPickerDelegate>
@property (nonatomic, copy) ContactSelectionCallback selectionCallback;  // 保存回调
@end

@implementation AnyContactManager

+ (void)requestContactAccessWithCompletion:(void(^)(BOOL granted))completion {
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL accessGranted, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (accessGranted) {
                if (@available(iOS 18, *)) {
                    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                    if (authStatus == CNAuthorizationStatusDenied) {
                        if (completion) {
                            completion(NO);
                        }
                        return;
                    }
                }
                if (completion) {
                    completion(YES);
                }
            } else {
                if (completion) {
                    completion(NO);
                }
            }
        });
    }];
}
// 选择联系人
- (void)selectContactFromViewController:(UIViewController *)viewController callback:(ContactSelectionCallback)callback {
    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    
    // 设置代理为当前对象
    picker.delegate = self;
    
    // 保存回调
    self.selectionCallback = callback;
    
    [viewController presentViewController:picker animated:YES completion:nil];
}

// 获取所有联系人
- (void)getAllContactsWithCompletion:(void(^)(NSArray<NSDictionary *> *contacts))completion {
    CNContactStore *store = [[CNContactStore alloc] init];
    
    NSError *error;
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    NSArray *contacts = [store unifiedContactsMatchingPredicate:nil keysToFetch:keysToFetch error:&error];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (CNContact *contact in contacts) {
        NSString *name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
        NSString *phoneNumber = @"";
        NSMutableArray<NSString *> *phones = [NSMutableArray array];
        for (CNPhoneNumber *phone in contact.phoneNumbers) {
            [phones addObject:phone.stringValue];
        }
        phoneNumber = [phones componentsJoinedByString:@","];
        [result addObject:@{@"groove": name, @"turning": phoneNumber}];
    }
    
    if (completion) {
        completion(result);
    }
}

// CNContactPickerDelegate 方法：选择联系人后调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
    NSString *phoneNumber = @"";
    if (contact.phoneNumbers.count > 0) {
        phoneNumber = ((CNPhoneNumber *)contact.phoneNumbers.firstObject.value).stringValue;
    }
    
    if (self.selectionCallback) {
        self.selectionCallback(name, phoneNumber);
    }
}

@end
