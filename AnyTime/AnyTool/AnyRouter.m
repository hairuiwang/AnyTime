//
//  AnyRouter.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyRouter.h"

@interface AnyRouter ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, void (^)(NSDictionary * _Nullable, UIViewController * _Nullable, RouterCallback _Nullable)> *routeHandlers;
@end


@implementation AnyRouter


/// **单例**
+ (instancetype)sharedInstance {
    static AnyRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// **初始化**
- (instancetype)init {
    if (self = [super init]) {
        _routeHandlers = [NSMutableDictionary dictionary];
    }
    return self;
}

/// **注册路由**
- (void)registerRoute:(NSString *)route handler:(void (^)(NSDictionary * _Nullable, UIViewController * _Nullable, RouterCallback _Nullable))handler {
    if (route && handler) {
        self.routeHandlers[route] = handler;
    }
}

/// **解析 URL 获取参数**
- (NSDictionary *)parseURLParams:(NSString *)urlString {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *item in urlComponents.queryItems) {
        if (item.value) {
            params[item.name] = item.value;
        }
    }
    return params;
}

/// **跳转路由**
- (void)openURL:(NSString *)url
     parameters:(NSDictionary * _Nullable)parameters
           from:(UIViewController * _Nullable)sourceVC
       callback:(RouterCallback _Nullable)callback {
    // 如果 `from` 为空，自动获取当前 VC
    if (!sourceVC) {
        sourceVC = [self getCurrentViewController];
    }
    
    NSURL *parsedURL = [NSURL URLWithString:url];
    NSString *path = parsedURL.path;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self parseURLParams:url]];
    if (parameters) {
        [params setObject:parameters forKey:@"parameters"];
    }
   
    void (^handler)(NSDictionary * _Nullable, UIViewController * _Nullable, RouterCallback _Nullable) = self.routeHandlers[path];
    
    if (handler) {
        // 在handler中直接传入 `from` 参数
        handler(params, sourceVC, callback);
    } else {
        if ([url hasPrefix:@"http"]) {
            // WebView 跳转处理
            AnyBeCommonWebViewController *webVC = [[AnyBeCommonWebViewController alloc]init];
            webVC.urlString = url;
            [sourceVC.navigationController pushViewController:webVC animated:YES];
            // 执行回调并传递 `from`
            if (callback) {
                callback(@{@"status": @"success", @"from": sourceVC});
            }
        } else {
            // 原生页面跳转
            Class vcClass = NSClassFromString(path);
            if (vcClass && [vcClass isSubclassOfClass:[UIViewController class]]) {
                UIViewController *vc = [[vcClass alloc] init];

                // KVC 传递参数
                for (NSString *key in params.allKeys) {
                    @try {
                        [vc setValue:params[key] forKey:key];
                    } @catch (NSException *exception) {
                        NSLog(@"参数设置失败: %@", exception);
                    }
                }

                // 使用 `from` 进行 push 或 present
                if (sourceVC.navigationController) {
                    [sourceVC.navigationController pushViewController:vc animated:YES];
                } else {
                    [sourceVC presentViewController:vc animated:YES completion:nil];
                }

                // 执行回调并传递 `from`
                if (callback) {
                    callback(@{@"status": @"success", @"from": sourceVC});
                }
            } else {
                NSLog(@"未找到页面: %@", path);
            }
        }
    }
}

/// **获取当前 ViewController（适用于 `from` 为空时）**
- (UIViewController *)getCurrentViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findTopViewController:rootVC];
}

/// **递归查找当前显示的 ViewController**
- (UIViewController *)findTopViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self findTopViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self findTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self findTopViewController:[(UITabBarController *)vc selectedViewController]];
    }
    return vc;
}

@end
