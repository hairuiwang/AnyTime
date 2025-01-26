//
//  AnyTimeHomeViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeHomeViewController.h"
#import "AnyTimeLargeCardSlotView.h"
#import "AnyTimeSmallCardSlotView.h"
#import "AnyTimeCustomPopupView.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "FBSDKCoreKit/FBSDKCoreKit.h"
@interface AnyTimeHomeViewController ()
@property(nonatomic,strong) AnyTimeLargeCardSlotView * largeCardSlotView;
@property(nonatomic,strong) AnyTimeSmallCardSlotView * smallCardSlotView;
@end

@implementation AnyTimeHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    
    UIImageView * homeBgView = [[UIImageView alloc] init];
//    homeBgView.image = [UIImage imageNamed:@"anytime_home_bg"];
    homeBgView.image = [UIImage imageNamed:@"anytime_home_smallcard_bg"];
    [self.view addSubview:homeBgView];
    
    [homeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
   
    [AnyHttpTool initializeAddressInfoWithSuccess:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [AnyRouter sharedInstance].cityData = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self googleMarket];
}

- (void)getData
{
    [AnyHttpTool fetchHomePageWithAuras:@"saadaffffgf" apart:@"sdadadsad" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        
        NSDictionary * dic = RDic(responseObject);
        AnyTimeHomeModel * homeModel = [AnyTimeHomeModel mj_objectWithKeyValues:dic];
        AnyTimeActingModel * actModel = homeModel.acting;
        NSLog(@"homeModel ==%@",actModel.aura);
        
        [AnyRouterTool sharedInstance].chin = homeModel.chin;
        
        if ([actModel.aura isEqualToString:@"anytimeb"])
        {
            //大卡位
            if (self.largeCardSlotView) {
                [self.largeCardSlotView removeFromSuperview];
            }
            if (self.smallCardSlotView) {
                [self.smallCardSlotView removeFromSuperview];
            }
            self.largeCardSlotView = [[AnyTimeLargeCardSlotView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.largeCardSlotView ];
        }
        else
        {
            //小卡位
            if (self.largeCardSlotView) {
                [self.largeCardSlotView removeFromSuperview];
            }
            if (self.smallCardSlotView) {
                [self.smallCardSlotView removeFromSuperview];
            }
            self.smallCardSlotView = [[AnyTimeSmallCardSlotView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.smallCardSlotView];
        }
    } failure:^(NSError * _Nonnull error) {
    
    }];

}

- (void)googleMarket {
    BOOL isHomeGoogleMarket = ![[NSUserDefaults standardUserDefaults] boolForKey:@"isHomeGoogleMarket"];
    if (!isHomeGoogleMarket) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [AnyHttpTool reportGoogleMarketWithMet:@"saslkfasldfhas" each:[AnyDevHelper IDFV] closer:idfa success:^(id  _Nonnull responseObject) {
            NSDictionary *characters = responseObject[@"characters"];
            NSString *cFBundleURLScheme = [NSString stringWithFormat:@"%@", characters[@"main"]];
            NSString *facebookAppID = [NSString stringWithFormat:@"%@", characters[@"stirring"]];
            NSString *facebookDisplayName = [NSString stringWithFormat:@"%@", characters[@"frying"]];
            NSString *facebookClientToke = [NSString stringWithFormat:@"%@", characters[@"whether"]];
            FBSDKSettings.sharedSettings.appID = facebookAppID;
            FBSDKSettings.sharedSettings.clientToken = facebookClientToke;
            FBSDKSettings.sharedSettings.displayName = facebookDisplayName;
            FBSDKSettings.sharedSettings.appURLSchemeSuffix = cFBundleURLScheme;
            [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isHomeGoogleMarket"];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
