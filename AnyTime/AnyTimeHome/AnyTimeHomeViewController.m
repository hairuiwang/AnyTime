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

@interface AnyTimeHomeViewController ()

@end

@implementation AnyTimeHomeViewController

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
    
    AnyTimeLargeCardSlotView *customView = [[AnyTimeLargeCardSlotView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:customView];
//    AnyTimeSmallCardSlotView *customView = [[AnyTimeSmallCardSlotView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:customView];
    
    
    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initPhotoGraphWithFrame:self.view.bounds];
    popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbigbg"];
    popupView.titleText = @"Date Selection";
    popupView.firstButtonTitle = @"Confirm";
//    popupView.secondButtonTitle = @"Stop";
    
    popupView.firstButtonAction = ^{
        NSLog(@"First button tapped");
    };

    popupView.secondButtonAction = ^{
        NSLog(@"Second button tapped");
    };

    popupView.closeAction = ^{
        NSLog(@"Close button tapped");
    };

//    [popupView showInView:self.view];
    
//    [[AnyNetRequest sharedManager] POST:GetCode parameters:@{@"turning":@"9012345678", @"direction":@"fasfdsaf"} success:^(id  _Nonnull responseObject) {
//        NSLog("responseObject = %@", responseObject);
//    } failure:^(NSError * _Nonnull error) {
//        NSLog("error = %@", error);
//    }];
    
//    {
//    "momentarily": 0,
//    "few": "success",
//    "gone": {
//      // 可以判断下列Key是否存在，来判断是否显示， 其他方式实现亦可
//      "instantly": { // 联系我们模块 - 根据UI来 有则显示，没有不显示    这个模块基本上不用，看需求吧
//        "beacrox": "https://pera-agad-files-prod.oss-ap-southeast-6.aliyuncs.com/banner/indexphoneicon.jpg", //- 显示的图片的 url
//        "darkness": "https://isw.peraag.com/#/proportions"  //   - 跳转的 url
//      },
//      "forest": {    //banner，取下发的，不要写死，没有banner则不用管
//        "aura": "BANNER",
//        "murderous": [
//          {
//            "disgusting": "",  //   - 跳转的 url
//            "violent": "https://pera-agad-files-prod.oss-ap-southeast-6.aliyuncs.com/banner/indexbanner.jpg", //- 显示的图片的 url
//          }
//        ]
//      },
//      "acting": {//大卡位 或 小卡位   必有，重点
//        "aura": "LARGE_CARD",   //可根据此字段判断是大卡位（首页1）还是小卡位（首页2），参照8.值映射，返回的是一个混淆后的数据
//        "murderous":[
//          {
//              "funny": 1,  // 产品ID
//              "pretending": "Pera Agad(AA)", // 产品名称
//              "blood": "https://pera-agad-files-prod.oss-ap-southeast-6.aliyuncs.com/banner/pera_agad_logo.jpg", // 产品Logo
//              "scent": "APPLY",     //   - 大卡位按钮的文案
//              "similar": "₱50,000",  //   - 贷款金额
//              "spar": "Maximum Loan Amount Upto", //   - 贷款金额的描述文案
//              "killed": "180 days",     //   - 贷款期限
//              "figured": "day",
//              "punk": "Loan Term", //   - 贷款期限的描述文案
//              "disgust": "0.05% day",    //    - 贷款利率
//              "source": "Interest Rate", //  - 贷款利率的描述文案
//            }
//        ]
//      },
//      "hmm": { // 逾期提醒模块 (首页2才展示,可能有多条，做成轮播样式，首页1不展示，但是测试时候首页1也会返回数据)
//        "aura": "REPAY",
//        "murderous": [
//          {
//            "few": "You have a loan of ₱ 2000 ", // 显示消息
//            "disgusting":"",    // 跳转地址
//          },
//          {
//            "few": "You have a loan of ₱ 5000 ", // 显示消息
//            "disgusting":"",    // 跳转地址
//          }
//        ]
//      },
//      "keep": {  //产品列表模块,可能有多条，首页2才有（测试时候首页1也会有）需要用白名单走完申贷流程
//        "aura": "PRODUCT_LIST",
//        "murderous": [
//          {
//            "funny": 1, // 产品ID
//            "pretending": "PeosXXX", // 产品名称
//            "blood": "", //   - 产品Logo
//            "scent":"Apply",  // - 按钮文案
//            "these": "",                                    // 贷款金额
//            "spar": "Maximum Loan Amount Upto",       // 贷款金额的描述文案
//            "talking": "≥ 0.05%",                             // 贷款利率
//            "source": "Interest Rate",                     // 贷款利率的描述文案
//            "enjoy": "91~365days",                               // 贷款期限
//            "seem": "Loan terms",                       // 贷款期限的描述文案
//            // 下面的字段基本用不到 -- 看需求
//            "similar": "2000～30000",                       // 贷款额度范围
//            "studied": "", //   - 产品标签
//            "hearing": "", //   - 产品描述
//            "falling": "",   // - 产品编码
//            "past": "#FEFEFE",      // -
//            "god": "Apply",   // - 按钮状态
//            "disgusting": "",                 // - 产品地址
//            "killed": "",
//            "grace": 0,
//            "fell": "",            // 描述文案
//            "supposedly": "",
//            "disgust": "",
//            "ahem": "",
//            "hurry": "No Borrowing",
//            "telling": "",
//          }...
//        ]
//      },
//      "chin":1, //强制定位字段：1强制，0不强制， 当等于1时候，点击申请需要判断是否有定位权限，没有的话不允许点击，提示去系统里设置
//      "motioned":1, //首页差异化模块显示状态，1表示显示，0表示不显示
//      "crossed":'文案1', //选用  文案1  有需求才用
//      "legs":'文案2', //选用  文案1  有需求才用
//      "couch":'文案3', //选用  文案1  有需求才用
//    }
//    }
    
    [AnyHttpTool fetchHomePageWithAuras:@"saadaffffgf" apart:@"sdadadsad" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject == %@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        
    }];

    
    [AnyHttpTool initializeAddressInfoWithSuccess:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [AnyRouter sharedInstance].cityData = responseObject;
//            [AnyDevHelper saveToUserDefaults:@"cityData" value:responseObject];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
//    anyVerifyIdentityInfoConfirmedPop
//    [[AnyRouter sharedInstance] openURL:@"/anyVerifyIdentityInfoConfirmedPop" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
//            
//    }];
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
