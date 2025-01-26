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
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            if (completion) {
                completion(NO);
            }
            return;
        }
        if (@available(iOS 18, *)) {
            CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
            if (status == CNAuthorizationStatusLimited) {
                if (completion) {
                    completion(NO);
                }
                return;
            }
        }
        if (completion) {
            completion(YES);
        }
    }];
}
// 选择联系人
- (void)selectContactFromViewController:(UIViewController *)viewController callback:(ContactSelectionCallback)callback {
    dispatch_async(dispatch_get_main_queue(), ^{
        CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
        
        // 设置代理为当前对象
        picker.delegate = self;
        
        // 保存回调
        self.selectionCallback = callback;
        
        [viewController presentViewController:picker animated:YES completion:nil];
    });
}

// 获取所有联系人
- (void)getAllContactsWithCompletion:(void(^)(NSArray<NSDictionary *> *contacts))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CNContactStore *store = [[CNContactStore alloc] init];
        
        NSError *error = nil;
        NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
        NSArray *contacts = [store unifiedContactsMatchingPredicate:nil keysToFetch:keysToFetch error:&error];
        
        if (error) {
            NSLog(@"获取联系人失败: %@", error.localizedDescription);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(@[]); // 如果发生错误，返回空数组
                });
            }
            return;
        }
        
        NSMutableArray *result = [NSMutableArray array];
        for (CNContact *contact in contacts) {
            NSString *name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
            NSString *phoneNumber = @"";
            NSMutableArray<NSString *> *phones = [NSMutableArray array];
            for (CNLabeledValue<CNPhoneNumber *> *phone in contact.phoneNumbers) {
                CNPhoneNumber *phoneValue = phone.value;
                [phones addObject:phoneValue.stringValue];
            }
            phoneNumber = [phones componentsJoinedByString:@","];
            [result addObject:@{@"name": name, @"phoneNumbers": phoneNumber}];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(result);
            }
        });
    });
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
