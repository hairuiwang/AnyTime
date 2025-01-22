//
//  AnyRouterTool.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyRouterTool.h"
#import "AnyTimeCustomPopupView.h"
#import "AnyCertificationDetailsViewController.h"
#import "AnyTimeLoginViewController.h"
#import "AnyVerifyldentityIDTypeViewController.h"
#import "AnyVerifyldentity02ViewController.h"
#import "AnyVerifyldentity03ViewController.h"
#import "AnyVerifyldentitySuccessfulViewController.h"
#import "AnyPersonalInforViewController.h"
#import "AnyContactInforViewController.h"
#import "AnyWithdrawalInfoViewController.h"
#import "AnyVerifyIdentityInfoConfirmedPop.h"
#import "AnyCertificationDetailsViewController.h"
#import "AnyLocationManager.h"
#import "AnyTimeRootBarViewController.h"
#import "AnyTimeMeSettingViewController.h"

@implementation AnyRouterTool
+ (instancetype)sharedInstance {
    static AnyRouterTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void) registered {
    [self certificationDetails];
    [self login];
    [self next];
    [self anyVerifyldentityIDTypeViewController];
    [self anyVerifyldentity02ViewController];
    [self anyVerifyldentity03ViewController];
    [self anyVerifyldentitySuccessfulViewController];
    [self anyPersonalInforViewController];
    [self anyContactInforViewController];
    [self anyWithdrawalInfoViewController];
    [self anyVerifyIdentityInfoConfirmedPop];
    [self anyoneAnytimef];
    [self halibutQuinc];
    [self sauceAnchovy];
    [self kiwiVanillaY];
    [self tilapiaNutme];
}

+ (void)applyForBox:(NSString *)box {
    BOOL isLogin = [AnyDevHelper loadBoolFromUserDefaults:LOGIN_STATUS];
    if (isLogin) {
        [[AnyLocationManager sharedInstance] requestAuthorization:^(BOOL granted) {
            if (granted) {
                [AnyTimeHUD showLoadingHUD];
                [AnyHttpTool fetchProductDetailWithBox:box magic:@"adejjmu890hnggj" following:@"kj840jjsuy" success:^(id  _Nonnull responseObject) {
                    [AnyTimeHUD hideHUD];
                    NSString *disgusting = responseObject[@"disgusting"];
                    [[AnyRouter sharedInstance] openURL:disgusting parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
                    }];
                } failure:^(NSError * _Nonnull error) {
                    [AnyTimeHUD hideHUD];
                    [AnyTimeHUD showTextWithText:error.localizedDescription];
                }];
            } else {
                if ([AnyRouterTool sharedInstance].chin == 1) { //
                    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:[[AnyRouter sharedInstance] getCurrentViewController].view.bounds];
                    popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
                    popupView.titleText = @"Location of position";
                    popupView.descriptionText = @"Need location permission";
                    popupView.firstButtonTitle = @"Confirm";
                    popupView.secondButtonTitle = @"Cancel";
                    
                    popupView.firstButtonAction = ^{
                        [self openAppSettings];
                    };
                    popupView.secondButtonAction = ^{
                        NSLog(@"Second button tapped");
                    };
                    popupView.closeAction = ^{
                        NSLog(@"Close button tapped");
                    };
                    [popupView showInView:[[AnyRouter sharedInstance] getCurrentViewController].view];
                } else {
                    [AnyTimeHUD showLoadingHUD];
                    [AnyHttpTool fetchProductDetailWithBox:box magic:@"adejjmu890hnggj" following:@"kj840jjsuy" success:^(id  _Nonnull responseObject) {
                        [AnyTimeHUD hideHUD];
                        NSString *disgusting = responseObject[@"disgusting"];
                        [[AnyRouter sharedInstance] openURL:disgusting parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
                        }];
                    } failure:^(NSError * _Nonnull error) {
                        [AnyTimeHUD hideHUD];
                        [AnyTimeHUD showTextWithText:error.localizedDescription];
                    }];
                }
            }
        }];
    } else {
        [[AnyRouter sharedInstance] openURL:@"/login" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
        }];
    }
}

+ (void)jumpCertificationDetails:(NSString *)box {
    NSString *url = [NSString stringWithFormat:@"/certificationDetails?box=%@", box];
    [[AnyRouter sharedInstance] openURL:url parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
    }];
}

+ (void)certificationDetails {
    [[AnyRouter sharedInstance] registerRoute:@"/certificationDetails" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSString *box = parameters[@"box"];
        BOOL isLogin = [AnyDevHelper loadBoolFromUserDefaults:LOGIN_STATUS];
        if (isLogin) {
            [[AnyLocationManager sharedInstance] requestAuthorization:^(BOOL granted) {
                if (granted) {
                    AnyCertificationDetailsViewController *toVC = [[AnyCertificationDetailsViewController alloc]init];
                    toVC.box = box;
                    [vc.navigationController pushViewController:toVC animated:true];
                } else {
                    if ([AnyRouterTool sharedInstance].chin == 1) { //
                        AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:vc.view.bounds];
                        popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
                        popupView.titleText = @"Location of position";
                        popupView.descriptionText = @"Need location permission";
                        popupView.firstButtonTitle = @"Confirm";
                        popupView.secondButtonTitle = @"Cancel";
                        
                        popupView.firstButtonAction = ^{
                            [self openAppSettings];
                        };
                        popupView.secondButtonAction = ^{
                            NSLog(@"Second button tapped");
                        };
                        popupView.closeAction = ^{
                            NSLog(@"Close button tapped");
                        };
                        [popupView showInView:vc.view];
                    } else {
                        AnyCertificationDetailsViewController *toVC = [[AnyCertificationDetailsViewController alloc]init];
                        toVC.box = box;
                        [vc.navigationController pushViewController:toVC animated:true];
                    }
                }
            }];
        } else {
            [[AnyRouter sharedInstance] openURL:@"/login" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
            }];
        }
    }];
}
+ (void)login {
    [[AnyRouter sharedInstance] registerRoute:@"/login" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        [AnyDevHelper saveToUserDefaults:SESSIONID value:@""];
        [AnyDevHelper saveBoolToUserDefaults:LOGIN_STATUS value:NO];
        AnyTimeLoginViewController *toVC = [[AnyTimeLoginViewController alloc]init];
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}

+ (void) next {
    [[AnyRouter sharedInstance] registerRoute:@"/next" handler:^(NSDictionary * _Nullable parameters, UIViewController * _Nullable viewController, RouterCallback _Nullable callback) {
        NSDictionary *detailParameters = parameters[@"parameters"];
        NSDictionary *rest = detailParameters[@"rest"];
        NSString *funny = rest[@"funny"];
        [AnyTimeHUD showLoadingHUD];
        [AnyHttpTool fetchProductDetailWithBox:funny depending:@"sajshgryi48613km" group:@"kjkjhkf580rf" success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            NSDictionary *productDetail = responseObject;
            NSDictionary *rocks = productDetail[@"rocks"];
            NSString *natural = rocks[@"natural"];
            if (natural.length > 0) {
                if ([natural isEqualToString:@"anytimef"]) { // 证件和人脸
                    [[AnyRouter sharedInstance] openURL:@"/anyoneAnytimef" parameters:productDetail from:nil callback:^(NSDictionary * _Nullable result) {}];
                } else if ([natural isEqualToString:@"anytimeg"]) { // 个人信息
                    [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController?type=1" parameters:productDetail from:nil callback:^(NSDictionary * _Nullable result) {}];
                } else if ([natural isEqualToString:@"anytimeh"]) { // 工作信息
                    [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController?type=2" parameters:productDetail from:nil callback:^(NSDictionary * _Nullable result) {}];
                } else if ([natural isEqualToString:@"anytimei"]) { // 联系人
                [[AnyRouter sharedInstance] openURL:@"/anyContactInforViewController" parameters:productDetail from:nil callback:^(NSDictionary * _Nullable result) {}];
                } else if ([natural isEqualToString:@"anytimej"]) { // 银行卡
                    [[AnyRouter sharedInstance] openURL:@"/anyWithdrawalInfoViewController" parameters:productDetail from:nil callback:^(NSDictionary * _Nullable result) {}];
                }
            } else {
                // meiyou
                NSString *agreed = rest[@"agreed"] ?: @"";
                [AnyTimeHUD showLoadingHUD];
                [AnyHttpTool getRedirectURLWithWestern:agreed inn:@"dsafcads@sfd" lead:@"v,avhfslkv44923" followed:@"fsaflifndsaf95wql" carriage:@"KHJKDSAFHJFMSAF" success:^(id  _Nonnull responseObject) {
                    NSString *disgusting = responseObject[@"disgusting"] ?: @"";
                    [[AnyRouter sharedInstance] openURL:disgusting parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) { }];
                } failure:^(NSError * _Nonnull error) {
                    [AnyTimeHUD hideHUD];
                    [AnyTimeHUD showTextWithText:error.localizedDescription];
                }];
                
            }
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];
    }];
}
+ (void)anyoneAnytimef { // 证件和人脸
    [[AnyRouter sharedInstance] registerRoute:@"/anyoneAnytimef" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *detailParameters = parameters[@"parameters"];
        NSDictionary *rest = detailParameters[@"rest"];
        NSString *funny = rest[@"funny"];
        [AnyTimeHUD showLoadingHUD];
        [AnyHttpTool fetchUserIdentityWithBox:funny ten:@"879hk740sd40mgy" success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            NSDictionary *shouldn = responseObject[@"shouldn"];
            NSString *arrived = [NSString stringWithFormat:@"%@", shouldn[@"arrived"]];
            NSString *ancient = [NSString stringWithFormat:@"%@", responseObject[@"ancient"]];
            if ([arrived integerValue] == 1) {
                if ([ancient integerValue] == 1) {
                    /// 跳转认证成功页面
                    [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentitySuccessfulViewController" parameters:detailParameters from:nil callback:^(NSDictionary * _Nullable result) { }];
                } else {
                    /// 跳转到证件
                    [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentity03ViewController" parameters:detailParameters from:nil callback:^(NSDictionary * _Nullable result) { }];
                }
            } else {
                /// 跳转到证件
                [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentityIDTypeViewController" parameters:detailParameters from:nil callback:^(NSDictionary * _Nullable result) { }];
            }
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];
    }];
}
/// 证件选择
+ (void)anyVerifyldentityIDTypeViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentityIDTypeViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *detailParameters = parameters[@"parameters"];
        AnyVerifyldentityIDTypeViewController *toVC = [[AnyVerifyldentityIDTypeViewController alloc]init];
        toVC.parameters = detailParameters;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 证件上传页面
+ (void)anyVerifyldentity02ViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentity02ViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSString *type = parameters[@"type"];
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentity02ViewController *toVC = [[AnyVerifyldentity02ViewController alloc]init];
        toVC.type = type;
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 人脸上传页面
+ (void)anyVerifyldentity03ViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentity03ViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentity03ViewController *toVC = [[AnyVerifyldentity03ViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 信息确认页面
+ (void)anyVerifyIdentityInfoConfirmedPop {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyIdentityInfoConfirmedPop" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        NSString *type = parameters[@"type"];
        AnyVerifyIdentityInfoConfirmedPop *toVC = [[AnyVerifyIdentityInfoConfirmedPop alloc]init];
        toVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        toVC.parameters = par[@"parameters"];
        toVC.detailParameters = par[@"detailParameters"];
        toVC.type = type;
        [vc presentViewController:toVC animated:YES completion:^{
            
        }];
    }];
}
/// 证件信息上传成功页面
+ (void) anyVerifyldentitySuccessfulViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyVerifyldentitySuccessfulViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        AnyVerifyldentitySuccessfulViewController *toVC = [[AnyVerifyldentitySuccessfulViewController alloc]init];
        toVC.parameters = par;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 身份信息和工作信息页面
+ (void) anyPersonalInforViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyPersonalInforViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSString *type = [NSString stringWithFormat:@"%@", parameters[@"type"]];
        NSDictionary *par = parameters[@"parameters"];
        NSArray *responded = par[@"responded"];
        NSString *handed = @"";
        for (NSDictionary *dict in responded) {
            NSString *natural = dict[@"natural"];
            if ([type isEqualToString:@"1"] && [natural isEqualToString:@"anytimeg"]) {
                handed = dict[@"handed"];
                break;
            } else if (![type isEqualToString:@"1"] && [natural isEqualToString:@"anytimeh"]) {
                handed = dict[@"handed"];
                break;
            } else {
                handed = @"";
            }
        }
        AnyPersonalInforViewController *toVC = [[AnyPersonalInforViewController alloc]init];
        toVC.parameters = par;
        toVC.type = type;
        toVC.title = handed;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 联系人信息页面
+ (void) anyContactInforViewController {
    [[AnyRouter sharedInstance] registerRoute:@"/anyContactInforViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        NSArray *responded = par[@"responded"];
        NSString *handed = @"";
        for (NSDictionary *dict in responded) {
            NSString *natural = dict[@"natural"];
            if ( [natural isEqualToString:@"anytimei"]) {
                handed = dict[@"handed"];
                break;
            } else {
                handed = @"";
            }
        }
        
        AnyContactInforViewController *toVC = [[AnyContactInforViewController alloc]init];
        toVC.parameters = par;
        toVC.title = handed;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}
/// 银行卡信息页面
+ (void)anyWithdrawalInfoViewController {
    
    [[AnyRouter sharedInstance] registerRoute:@"/anyWithdrawalInfoViewController" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        NSDictionary *par = parameters[@"parameters"];
        NSArray *responded = par[@"responded"];
        NSString *handed = @"";
        for (NSDictionary *dict in responded) {
            NSString *natural = dict[@"natural"];
            if ( [natural isEqualToString:@"anytimei"]) {
                handed = dict[@"handed"];
                break;
            } else {
                handed = @"";
            }
        }
        AnyWithdrawalInfoViewController *toVC = [[AnyWithdrawalInfoViewController alloc]init];
        toVC.parameters = par;
        toVC.title = handed;
        [vc.navigationController pushViewController:toVC animated:true];
    }];
}


+ (void)authenticationJump {
    [[AnyRouter sharedInstance] registerRoute:@"/authenticationJump" handler:^(NSDictionary * parameters, UIViewController * vc, RouterCallback callback) {
        
    }];
}
/// **跳转到 iOS 设置界面**
+ (void)openAppSettings {
    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
        [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
    }
}

+ (void)halibutQuinc {
    [[AnyRouter sharedInstance] registerRoute:@"/halibutQuinc" handler:^(NSDictionary * _Nullable parameters, UIViewController * _Nullable viewController, RouterCallback _Nullable callback) {
        AnyTimeMeSettingViewController *toVC = [[AnyTimeMeSettingViewController alloc]init];
        [viewController.navigationController pushViewController:toVC animated:true];
    }];
}
+ (void)sauceAnchovy {
    [[AnyRouter sharedInstance] registerRoute:@"/sauceAnchovy" handler:^(NSDictionary * _Nullable parameters, UIViewController * _Nullable viewController, RouterCallback _Nullable callback) {
        AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    }];
}
+ (void) kiwiVanillaY {
    [[AnyRouter sharedInstance] registerRoute:@"/kiwiVanillaY" handler:^(NSDictionary * _Nullable parameters, UIViewController * _Nullable viewController, RouterCallback _Nullable callback) {
        [[AnyRouter sharedInstance] openURL:@"/login" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
        }];
    }];
}
+ (void)tilapiaNutme {
    [[AnyRouter sharedInstance] registerRoute:@"/tilapiaNutme" handler:^(NSDictionary * _Nullable parameters, UIViewController * _Nullable viewController, RouterCallback _Nullable callback) {
        NSString *box = parameters[@"box"];
        NSString *url = [NSString stringWithFormat:@"/certificationDetails?box=%@",box];
        [[AnyRouter sharedInstance] openURL:url parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
    }];
}
@end
