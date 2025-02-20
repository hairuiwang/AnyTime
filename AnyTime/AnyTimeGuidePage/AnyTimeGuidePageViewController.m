//
//  AnyTimeGuidePageViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeGuidePageViewController.h"
#import "AnyTimeLoginViewController.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "AnyTimeRootBarViewController.h"
@interface AnyTimeGuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *btnTitlesArray;

@property (nonatomic, strong) NSArray *descriptionsArray;

@end

@implementation AnyTimeGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesArray = @[@"anytime_guidepage1", @"anytime_guidepage2", @"anytime_guidepage3"];
    
    self.titlesArray = @[@"Easy to operate", @"Fast Approval", @"Smart Management"];
    
    self.btnTitlesArray = @[@"Next",@"Next",@"Enter"];
    
    self.descriptionsArray = @[@"Complete your loan application in just a few steps", @"No need to wait, instant loan", @"Smart financial management tools to help you easily manage your loans"];
    
    [self setupScrollView];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self requestIDFAPermissionWithCompletion:^(NSString *idfa) {
            
        }];
    });

}

- (void)setupScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < self.imagesArray.count; i++)
    {
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pageView.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image = [UIImage imageNamed:self.imagesArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [pageView addSubview:imageView];
        
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"anytime_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:backButton];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pageView.mas_top).offset(44);
            make.left.mas_equalTo(pageView.mas_left);
            make.width.height.mas_equalTo(44);
        }];
        
        
        UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setTitle:self.btnTitlesArray[i] forState:UIControlStateNormal];
        [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextButton.backgroundColor = [UIColor blackColor];
        nextButton.layer.cornerRadius = 22;
        [nextButton addTarget:self action:@selector(nextButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:nextButton];
        
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(pageView.mas_bottom).offset(-162);
            make.left.mas_equalTo(pageView.mas_left).offset(47);
            make.right.mas_equalTo(pageView.mas_right).offset(-47);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.text = self.descriptionsArray[i];
        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        descriptionLabel.font = [UIFont systemFontOfSize:16];
        descriptionLabel.textColor = [UIColor blackColor];
        descriptionLabel.numberOfLines = 2;
        [pageView addSubview:descriptionLabel];
        
        [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(nextButton.mas_top).offset(-62);
            make.left.mas_equalTo(pageView.mas_left).offset(47);
            make.right.mas_equalTo(pageView.mas_right).offset(-47);
            make.height.mas_equalTo(44);
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.titlesArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:24];
        titleLabel.textColor = [UIColor blackColor];
        [pageView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(descriptionLabel.mas_top).offset(-10);
            make.left.mas_equalTo(pageView.mas_left).offset(47);
            make.right.mas_equalTo(pageView.mas_right).offset(-47);
            make.height.mas_equalTo(44);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewTapped:)];
        [pageView addGestureRecognizer:tapGesture];
        
        [self.scrollView addSubview:pageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.imagesArray.count * SCREEN_WIDTH, SCREEN_HEIGHT);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    // 判断滑动到第一页
    if (currentPage == 0 && currentPage != self.lastPage) {
        NSLog(@"滑动到第一页");
        self.lastPage = currentPage;
    }
    
    // 判断滑动到最后一页
    if (currentPage == self.imagesArray.count - 1 && currentPage != self.lastPage) {
        NSLog(@"滑动到最后一页");
        self.lastPage = currentPage;
    }
    
}

- (void)pageViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    
    NSInteger currentPage = self.scrollView.contentOffset.x / SCREEN_WIDTH;
    
    NSInteger nextPage = currentPage + 1;
    
    if (nextPage < self.imagesArray.count) {
        
        [self.scrollView setContentOffset:CGPointMake(nextPage * SCREEN_WIDTH, 0) animated:YES];
    }
    else
    {
        [self transitionToLoginPage];
    }
}


- (void)nextButtonTapped {
    
    NSInteger currentPage = self.scrollView.contentOffset.x / SCREEN_WIDTH;
    
    
    NSInteger nextPage = currentPage + 1;
    
    
    if (nextPage < self.imagesArray.count) {
        
        [self.scrollView setContentOffset:CGPointMake(nextPage * SCREEN_WIDTH, 0) animated:YES];
    } else {
        
        [self transitionToLoginPage];
    }
}

- (void)backButtonTapped
{
    NSInteger currentPage = self.scrollView.contentOffset.x / SCREEN_WIDTH;
    
    if (currentPage == 0) {
        NSLog(@"第一页");
        return;
    }
    NSInteger prevPage = currentPage - 1;
    
    if (prevPage >= 0)
    {
        [self.scrollView setContentOffset:CGPointMake(prevPage * SCREEN_WIDTH, 0) animated:YES];
    }
}

- (void)transitionToLoginPage
{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isFirstLaunch"];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//    AnyTimeLoginViewController * loginVC = [[AnyTimeLoginViewController alloc] init];
//    window.rootViewController = loginVC;
    AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
    window.rootViewController = rootVC;
}
/// 请求 IDFA 权限
- (void)requestIDFAPermissionWithCompletion:(void (^)(NSString *idfa))completion {
    if (@available(iOS 14, *)) {
        // 检查当前的权限状态
        ATTrackingManagerAuthorizationStatus status = [ATTrackingManager trackingAuthorizationStatus];
        
        if (status == ATTrackingManagerAuthorizationStatusNotDetermined) {
            // 未申请过，发起权限申请
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus newStatus) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (newStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
                        // 授权成功，获取 IDFA
                        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                        if (completion) {
                            completion(idfa);
                        }
                    } else {
                        // 用户拒绝或限制，返回空字符串
                        if (completion) {
                            completion(@"");
                        }
                    }
                });
            }];
        } else if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
            // 已经授权，直接获取 IDFA
            NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (completion) {
                completion(idfa);
            }
        } else {
            // 用户拒绝或限制，返回空字符串
            if (completion) {
                completion(@"");
            }
        }
    } else {
        // iOS 14 以下版本，直接获取 IDFA
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (completion) {
            completion(idfa);
        }
    }
}
@end
