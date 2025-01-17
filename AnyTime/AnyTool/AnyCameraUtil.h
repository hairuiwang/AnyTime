//
//  AnyCameraUtil.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CameraPermissionBlock)(BOOL granted);
typedef void(^CameraImageBlock)(UIImage * _Nullable image);

@interface AnyCameraUtil : NSObject
/// 获取相机权限
+ (void)requestCameraPermission:(CameraPermissionBlock)completion;

/// 拍照
+ (void)takePhotoFromViewController:(UIViewController *)viewController
                           useFrontCamera:(BOOL)useFrontCamera
                           completion:(CameraImageBlock)completion;

/// 选择相册照片
+ (void)selectPhotoFromViewController:(UIViewController *)viewController
                           completion:(CameraImageBlock)completion;

@end

NS_ASSUME_NONNULL_END
