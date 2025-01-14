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
    
    
//    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initCancellationAccountWithFrame:self.view.bounds];
//    popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbigbg"]; // 背景图
//    popupView.titleText = @"Recommended Products";
//    popupView.descriptionText = @"Once an account is cancelled, itcannot be restored. To ensure thesecurity of your account, pleaseconfrm that account-relatedservices have been handleproperlybefore submitting your application.";
//    popupView.firstButtonTitle = @"Apply For Products Now";
//    popupView.secondButtonTitle = @"Go Apply";
//    
//    popupView.firstButtonAction = ^{
//        NSLog(@"First button tapped");
//    };
//
//    popupView.secondButtonAction = ^{
//        NSLog(@"Second button tapped");
//    };
//
//    popupView.closeAction = ^{
//        NSLog(@"Close button tapped");
//    };
//
//    [popupView showInView:self.view];

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
