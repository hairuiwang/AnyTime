//
//  AnyNetRequest.h
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface AnyNetRequest : NSObject
+ (instancetype)sharedManager;

- (void)GET:(NSString *)url
 parameters:(nullable NSDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)url
  parameters:(nullable NSDictionary *)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

- (void)uploadImages:(NSString *)url
          parameters:(nullable NSDictionary *)parameters
              images:(NSArray<UIImage *> *)images
                name:(NSString *)name
           fileName:(NSString *)fileName
            success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
