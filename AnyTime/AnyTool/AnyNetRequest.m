//
//  AnyNetRequest.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyNetRequest.h"

@interface AnyNetRequest ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation AnyNetRequest
/// **单例**
+ (instancetype)sharedManager {
    static AnyNetRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// **初始化**
- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    }
    return self;
}

/// **动态获取公共参数**
- (NSDictionary *)fetchGlobalParameters {
    NSString *sessionId = [AnyDevHelper loadFromUserDefaults:SESSIONID] ?: @"";
    return @{
        @"gaze":@"ios",
        @"innocent":  [AnyDevHelper IDFV],
        @"avoided": [AnyDevHelper appVersion],
        @"last": [AnyDevHelper deviceModel],
        @"meeting": [AnyDevHelper IDFV],
        @"fated": [AnyDevHelper iOSVersion],
        @"their": @"apples",
        @"sure": sessionId,
        @"boyfine":@"xxxxsssxxws123"
    };
}

/// **拼接公共参数**
- (NSString *)appendParamsToURL:(NSString *)url parameters:(NSDictionary *)parameters {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[self fetchGlobalParameters]];
    if (parameters) {
        [allParams addEntriesFromDictionary:parameters];
    }

    NSMutableArray *queryArray = [NSMutableArray array];
    [allParams enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *query = [NSString stringWithFormat:@"%@=%@", key, [self urlEncode:value]];
        [queryArray addObject:query];
    }];

    NSString *queryString = [queryArray componentsJoinedByString:@"&"];
    return [url containsString:@"?"] ? [NSString stringWithFormat:@"%@&%@", url, queryString] : [NSString stringWithFormat:@"%@?%@", url, queryString];
}

/// **URL 编码**
- (NSString *)urlEncode:(NSString *)string {
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
/// **统一处理网络返回结果**
- (void)handleResponse:(id)responseObject
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSError *error = [NSError errorWithDomain:@"NetworkError"
                                             code:-1
                                         userInfo:@{NSLocalizedDescriptionKey: @"Invalid response format"}];
        if (failure) failure(error);
        return;
    }
    
    NSInteger statusCode = [responseObject[CODE] integerValue];
    if (statusCode == 0) {
        NSDictionary *data = responseObject[DATA];
        if ([data isKindOfClass:[NSDictionary class]]) {
            if (success) success(data);
        }
    } else if (statusCode == -2) {
        
        [[AnyRouter sharedInstance] openURL:@"/login" parameters:nil  from:nil callback:^(NSDictionary * _Nullable result) {
        }];
    } else {
        NSString *errorMessage = responseObject[MSG] ?: @"Unknown error";
        NSError *error = [NSError
                          errorWithDomain:@"NetworkError"
                          code:statusCode
                          userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
        if (failure) failure(error);
    }
}

#pragma mark - **GET 请求**
- (void)GET:(NSString *)url
 parameters:(nullable NSDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
    NSString *baseAddurl = [NSString stringWithFormat:@"%@%@",BASE_URL, url];
    NSString *fullURL = [self appendParamsToURL:baseAddurl parameters:nil];

    NSLog(@"url === %@",fullURL);
    
    [_sessionManager GET:fullURL parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - **POST 请求**
- (void)POST:(NSString *)url
  parameters:(nullable NSDictionary *)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
    NSString *baseAddurl = [NSString stringWithFormat:@"%@%@",BASE_URL, url];
    NSString *fullURL = [self appendParamsToURL:baseAddurl parameters:nil];
    
    NSLog(@"url === %@",fullURL);
    
    [_sessionManager POST:fullURL parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // ✅ 遍历参数，添加到 multipart/form-data
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                [formData appendPartWithFormData:[obj dataUsingEncoding:NSUTF8StringEncoding] name:key];
            } else if ([obj isKindOfClass:[NSData class]]) {
                // ⚠️ 适用于文件上传
                [formData appendPartWithFileData:obj name:key fileName:@"file.jpg" mimeType:@"image/jpeg"];
            }
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - **图片上传**
- (void)uploadImages:(NSString *)url
          parameters:(nullable NSDictionary *)parameters
              images:(NSArray<UIImage *> *)images
                name:(NSString *)name
           fileName:(NSString *)fileName
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
    
    NSString *baseAddurl = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NSString *fullURL = [self appendParamsToURL:baseAddurl parameters:nil]; // 拼接公共参数
    NSDictionary *finalParams = [self fetchGlobalParameters]; // 确保参数最新
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray<NSData *> *compressedImages = [NSMutableArray array];
        for (UIImage *image in images) {
            NSData *compressedData = [self compressImage:image toMaxSize:300 * 1024];
            if (compressedData) {
                [compressedImages addObject:compressedData];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_sessionManager POST:fullURL
                             parameters:parameters
                                headers:nil
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [compressedImages enumerateObjectsUsingBlock:^(NSData * _Nonnull imageData, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *imageFileName = [NSString stringWithFormat:@"%@_%lu.jpg", fileName, (unsigned long)idx];
                    
                    [formData appendPartWithFileData:imageData
                                                name:name
                                            fileName:imageFileName
                                            mimeType:@"image/jpeg"];
                }];
                
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponse:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) failure(error);
            }];
        });
    });
}

/// **压缩图片到指定大小**
- (NSData *)compressImage:(UIImage *)image toMaxSize:(NSUInteger)maxSize {
    CGFloat compression = 0.5;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > maxSize && compression > 0.1) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}
@end
