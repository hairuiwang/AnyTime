//
//  AnyCameraUtil.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyCameraUtil.h"

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface AnyCameraUtil () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) CameraImageBlock imageCompletion;

@end

@implementation AnyCameraUtil
#pragma mark - 相机权限
+ (void)requestCameraPermission:(CameraPermissionBlock)completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusAuthorized) {
        completion(YES);
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        completion(NO);
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(granted);
            });
        }];
    }
}

#pragma mark - 拍照
+ (void)takePhotoFromViewController:(UIViewController *)viewController
                   useFrontCamera:(BOOL)useFrontCamera
                       completion:(CameraImageBlock)completion {
    [self requestCameraPermission:^(BOOL granted) {
        if (!granted) {
            completion(nil);
            return;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = useFrontCamera ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
        picker.allowsEditing = NO;
        
        [[self sharedInstance] setImageCompletion:completion];
        
        [viewController presentViewController:picker animated:YES completion:^{
            if (useFrontCamera) {
                NSArray *views = [[AnyRouter sharedInstance] getCurrentViewController].view.subviews;
                [self logAllSubviewsInCurrentView: [[AnyRouter sharedInstance] getCurrentViewController].view];
                for (UIView *view in views) {
                    NSString *className = NSStringFromClass([view class]);
                    if ([className isEqualToString:@"CAMFlipButton"]) {
                        view.hidden = YES;
                    }
                }
            }
        }];
    }];
}
+ (void)logAllSubviewsForView:(UIView *)view {
    // 遍历当前视图的所有子视图
    for (UIView *subview in view.subviews) {
        NSString *className = NSStringFromClass([view class]);
        if ([className isEqualToString:@"CAMFlipButton"]) {
            view.hidden = YES;
            return;
        }
        // 递归遍历子视图
        [self logAllSubviewsForView:subview];
    }
}

+ (void)logAllSubviewsInCurrentView:(UIView *)rootView {
    [self logAllSubviewsForView:rootView];
}
#pragma mark - 选择照片
+ (void)selectPhotoFromViewController:(UIViewController *)viewController completion:(CameraImageBlock)completion {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = [AnyCameraUtil sharedInstance];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    
    [[self sharedInstance] setImageCompletion:completion];
    
    [viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 处理图片选择和拍照结果
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    
    if (originalImage) {
        if (self.imageCompletion) {
            self.imageCompletion(originalImage);
        }
        self.imageCompletion = nil;
//        [AnyTimeHUD showLoadingHUD];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSData *compressedData = [self compressImage:originalImage toMaxSize:500 * 1024]; // 500KB
//            UIImage *compressedImage = [UIImage imageWithData:compressedData];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [AnyTimeHUD hideHUD];
//                if (self.imageCompletion) {
//                    self.imageCompletion(compressedImage);
//                }
//                self.imageCompletion = nil;
//            });
//        });
    } else {
        if (self.imageCompletion) {
            self.imageCompletion(nil);
        }
        self.imageCompletion = nil;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (self.imageCompletion) {
        self.imageCompletion(nil);
    }
    self.imageCompletion = nil;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 压缩图片
- (NSData *)compressImage:(UIImage *)image toMaxSize:(NSUInteger)maxSize {
    CGFloat compression = 0.9;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    while (imageData.length > maxSize && compression > 0.1) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static AnyCameraUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AnyCameraUtil alloc] init];
    });
    return instance;
}
@end
