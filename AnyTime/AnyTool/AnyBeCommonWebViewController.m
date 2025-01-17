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

@interface AnyBeCommonWebViewController () <WKNavigationDelegate, WKScriptMessageHandler>

// 声明 WKWebView
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AnyBeCommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSString *subject = @"Hello";
    NSString *body = @"Please see the email content.";
    NSString *emailUrlString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", emailAddress, subject, body];
    NSURL *emailUrl = [NSURL URLWithString:emailUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:emailUrl]) {
        [[UIApplication sharedApplication] openURL:emailUrl options:@{} completionHandler:nil];
    } else {
        NSLog(@"无法发送邮件");
    }
}

@end
