//
//  AnyTimeNoNetWorkViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/21.
//

#import "AnyTimeNoNetWorkViewController.h"
#import "AnyTimeCustomPopupView.h"

@interface AnyTimeNoNetWorkViewController ()

@end

@implementation AnyTimeNoNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initNoNetWorkWithFrame:self.view.bounds];
    popupView.backgroundImage = [UIImage imageNamed:@"anytime_nonetwork"];
    popupView.descriptionText = @"To use Mabilis Lucre, you mustenable network permissions to usethe App functions normally.";
    popupView.firstButtonTitle = @"Turning on";
    popupView.secondButtonTitle = @"Stop";
    popupView.firstButtonAction = ^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
           [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    };
    popupView.secondButtonAction = ^{
        exit(0);
    };
    [popupView showInView:self.view];
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
