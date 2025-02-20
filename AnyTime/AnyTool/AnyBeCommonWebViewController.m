//
//  AnyBeCommonWebViewController.m
//  AnyTime
//
//  Created by wealon on 2025.
//  AnyTime.
//


#import "AnyBeCommonWebViewController.h"
#import <WebKit/WebKit.h>
#import <StoreKit/StoreKit.h>
#import "AnyCertificationDetailsViewController.h"
@interface AnyBeCommonWebViewController () <WKNavigationDelegate, WKScriptMessageHandler>

// 声明 WKWebView
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AnyBeCommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xFFECD7);
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    
    // 设置 WebView
    [self setupWebView];
    
    // 加载外部配置的 URL
    if (self.urlString && self.urlString.length > 0) {
        ;
        NSURL *url = [NSURL URLWithString: [self appendParamsToURL:self.urlString parameters:@{}]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}
- (void) backClick {
    UINavigationController *navigationController = self.navigationController;
    if (navigationController) {
        // 检查导航栈中是否存在 AViewController
        BOOL isAViewControllerInStack = NO;
        for (UIViewController *viewController in navigationController.viewControllers) {
            if ([viewController isKindOfClass:[AnyCertificationDetailsViewController class]]) {
                isAViewControllerInStack = YES;
                break;
            }
        }
        
        if (isAViewControllerInStack) {
            // 如果存在 AViewController，返回到根视图控制器
            [navigationController popToRootViewControllerAnimated:YES];
        } else {
            // 否则返回上一个页面
            [navigationController popViewControllerAnimated:YES];
        }
    } else {
        // 如果没有导航控制器，直接关闭当前视图控制器
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (NSDictionary *)fetchGlobalParameters {
    NSString *sessionId = [AnyDevHelper loadFromUserDefaults:SESSIONID] ?: @"";
    return @{
        @"gaze":@"ios",
        @"sure": sessionId,
        @"avoided": [AnyDevHelper appVersion],
        @"last": [AnyDevHelper deviceModel],
        @"meeting": [AnyDevHelper IDFV],
        @"fated": [AnyDevHelper iOSVersion],
        @"their": @"apples",
        @"innocent": [AnyDevHelper IDFV],
        @"boyfine":@"xxxxsssxxws123"
    };
}
/// **拼接公共参数**
- (NSString *)appendParamsToURL:(NSString *)url parameters:(NSDictionary *)parameters {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[self fetchGlobalParameters]];
    NSString *baseURL = url;
    NSString *existingParamsString = nil;
    
    // 判断 URL 是否已经包含 '?'
    NSRange range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        baseURL = [url substringToIndex:range.location]; // 提取主 URL
        existingParamsString = [url substringFromIndex:range.location + 1]; // 获取参数部分
        
        // 解析已有参数
        NSArray *keyValuePairs = [existingParamsString componentsSeparatedByString:@"&"];
        for (NSString *pair in keyValuePairs) {
            NSArray *keyValue = [pair componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                NSString *key = keyValue[0];
                NSString *value = keyValue[1];
                allParams[key] = value;
            }
        }
    }
    
    // 合并新参数
    if (parameters) {
        [allParams addEntriesFromDictionary:parameters];
    }
    
    // 构造新的参数字符串
    NSMutableArray *queryArray = [NSMutableArray array];
    [allParams enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *query = [NSString stringWithFormat:@"%@=%@", key, [self urlEncode:value]];
        [queryArray addObject:query];
    }];
    
    NSString *queryString = [queryArray componentsJoinedByString:@"&"];
    
    // 拼接最终的 URL
    return queryString.length > 0 ? [NSString stringWithFormat:@"%@?%@", baseURL, queryString] : baseURL;
}
/// **URL 编码**
- (NSString *)urlEncode:(NSString *)string {
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
#pragma mark - Setup WebView
- (void)setupWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    // 设置与 JavaScript 交互的消息处理
    [configuration.userContentController addScriptMessageHandler:self name:@"rowanwood"];
    [configuration.userContentController addScriptMessageHandler:self name:@"turbotCar"];
    [configuration.userContentController addScriptMessageHandler:self name:@"waterZucc"];
    [configuration.userContentController addScriptMessageHandler:self name:@"papayaCak"];
    [configuration.userContentController addScriptMessageHandler:self name:@"raspberry"];
    [configuration.userContentController addScriptMessageHandler:self name:@"hibiscusW"];
    
    // 初始化 WebView
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.webView];
}

#pragma mark - WKScriptMessageHandler Methods
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    // 根据消息的 name 判断执行哪个方法
    if ([message.name isEqualToString:@"rowanwood"]) {
        [self rowanwood:message];
    } else if ([message.name isEqualToString:@"turbotCar"]) {
        [self turbotCar:message];
    } else if ([message.name isEqualToString:@"waterZucc"]) {
        [self waterZucc:message];
    } else if ([message.name isEqualToString:@"papayaCak"]) {
        [self papayaCak:message];
    } else if ([message.name isEqualToString:@"raspberry"]) {
        [self raspberry:message];
    } else if ([message.name isEqualToString:@"hibiscusW"]) {
        [self hibiscusW:message];
    }
}

// 风控埋点
- (void)rowanwood:(WKScriptMessage *)message {
    NSArray *params = message.body;
    NSString *endTime = [AnyDevHelper currentTimestamp];
    [AnyHttpTool reportRiskGate:params[0] commanded:@"10" agreed:params[1] allowance:endTime large:endTime father:@"adsdk03dwaknsc84" success:^(id  _Nonnull responseObject) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

// 跳转原生或 H5
- (void)turbotCar:(WKScriptMessage *)message {
    NSString *action = message.body;
    [[AnyRouter sharedInstance] openURL:action parameters:@{} from:self callback:^(NSDictionary * _Nullable result) {}];
}

// 关闭当前 H5
- (void)waterZucc:(WKScriptMessage *)message {
    NSLog(@"关闭当前 H5");
    [self.navigationController popViewControllerAnimated:YES];
}

// 回到 App 首页
- (void)papayaCak:(WKScriptMessage *)message {
    [[AnyRouter sharedInstance] openURL:@"any://one.ios.app/sauceAnchovy" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
}

// 发邮件
- (void)raspberry:(WKScriptMessage *)message {
    NSString *emailStr = message.body;
    if ([emailStr hasPrefix:@"email:"]) {
        NSString *emailAddress = [emailStr substringFromIndex:6];
        NSLog(@"发邮件给: %@", emailAddress);
        [self sendEmailTo:emailAddress];
    }
}

// 弹出系统评分弹窗
- (void)hibiscusW:(WKScriptMessage *)message {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    }
}

#pragma mark - Email Sending Method (示例)

- (void)sendEmailTo:(NSString *)emailAddress {
    NSString *subject = @""; // 设置有效主题
    NSString *content = [NSString stringWithFormat:@"APP Name：AnyTime Loan\nPhone：%@\nI need help： ", [AnyDevHelper loadFromUserDefaults:LOGIN_COUNT]];
    NSString *body = content;
    
    // 对 URL 中的特殊字符进行编码
    NSString *encodedSubject = [subject stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *encodedBody = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *emailUrlString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", emailAddress, encodedSubject, encodedBody];
    NSURL *emailUrl = [NSURL URLWithString:emailUrlString];
    
    // 检查能否打开 URL
    if ([[UIApplication sharedApplication] canOpenURL:emailUrl]) {
        [[UIApplication sharedApplication] openURL:emailUrl options:@{} completionHandler:nil];
    } else {
        NSLog(@"无法发送邮件");
    }
}

//- (void)sendEmailTo:(NSString *)emailAddress {
//    NSString *subject = @"";
//    NSString *content = [NSString stringWithFormat:@"APP Name：AnyTime Loan\nPhone：%@\nI need help： ", [AnyDevHelper loadFromUserDefaults:LOGIN_COUNT]];
//    NSString *body = content;
//    NSString *emailUrlString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", emailAddress, subject, body];
//    NSURL *emailUrl = [NSURL URLWithString:emailUrlString];
//
//    if ([[UIApplication sharedApplication] canOpenURL:emailUrl]) {
//        [[UIApplication sharedApplication] openURL:emailUrl options:@{} completionHandler:nil];
//    } else {
//        NSLog(@"无法发送邮件");
//    }
//}

@end
