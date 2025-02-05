//
//  AnyTimeLoginViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLoginViewController.h"
#import "AnyTimeCustomTextField.h"
#import <YYText/YYText.h>
#import "AnyTimeRootBarViewController.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "FBSDKCoreKit/FBSDKCoreKit.h"

@interface AnyTimeLoginViewController ()

@property (nonatomic, strong) AnyTimeCustomTextField *phoneTextField;
@property (nonatomic, strong) AnyTimeCustomTextField *codeTextField;

@property (nonatomic, strong) YYLabel *textLabel;
@property (nonatomic, strong) UIButton *checkboxButton;
@property (nonatomic, assign) BOOL isChecked;

@property (nonatomic, strong) NSString *stateTime;
@property (nonatomic, strong) NSString *endTime;
@end

@implementation AnyTimeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    
    UIImageView * bgImage = [[UIImageView alloc] init];
    bgImage.image = [UIImage imageNamed:@"anytime_loginbg"];
    [self.view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
    UIImageView * contentBgImage = [[UIImageView alloc] init];
    contentBgImage.image = [UIImage imageNamed:@"anytime_login_contentbg"];
    contentBgImage.userInteractionEnabled = YES;
    [self.view addSubview:contentBgImage];
    
    [contentBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.view.mas_top).offset(170);
        make.height.mas_equalTo(307);
    }];
    
    UILabel * phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"Telephone";
    phoneLabel.font = BOLD_FONT_SIZE(15);
    phoneLabel.textColor = UIColor.blackColor;
    [contentBgImage addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentBgImage.mas_top).offset(21);
        make.left.mas_equalTo(contentBgImage.mas_left).offset(38);
        make.right.mas_equalTo(contentBgImage.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    
    self.phoneTextField = [[AnyTimeCustomTextField alloc] initWithType:AnyTimeCustomTextFieldTypePhone
                                                  borderWidth:1.0
                                                cornerRadius:22
                                                  borderColor:[UIColor blackColor]
                                                  placeholder:@"Ingresar número móvil"
                                                  keyboardType:UIKeyboardTypePhonePad maxLength:11 hint:@"More than 11 digits"];
    [contentBgImage addSubview:self.phoneTextField];
    [self.phoneTextField layoutIfNeeded];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentBgImage.mas_top).offset(58);
        make.left.mas_equalTo(contentBgImage.mas_left).offset(38);
        make.right.mas_equalTo(contentBgImage.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    
    NSString * currentText = [AnyDevHelper loadFromUserDefaults:LOGIN_COUNT];
    if (currentText.length > 0)
    {
        self.phoneTextField.textField.text = currentText;
    }
    
    self.phoneTextField.textFieldDidChangeBlock = ^(NSString * _Nonnull text) {
        NSLog(@"phoneTextField === %@",text);
    };
    
    UILabel * codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"Verification code";
    codeLabel.font = BOLD_FONT_SIZE(15);
    codeLabel.textColor = UIColor.blackColor;
    [contentBgImage addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(21);
        make.left.mas_equalTo(contentBgImage.mas_left).offset(38);
        make.right.mas_equalTo(contentBgImage.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    
    self.codeTextField = [[AnyTimeCustomTextField alloc] initWithType:AnyTimeCustomTextFieldTypeCode
                                                 borderWidth:1.0
                                               cornerRadius:22
                                                 borderColor:[UIColor blackColor]
                                                 placeholder:@"Please enter verification code"
                                                 keyboardType:UIKeyboardTypeNumberPad maxLength:4 hint:@"More than 4 digits"];
    [contentBgImage addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(58);
        make.left.mas_equalTo(contentBgImage.mas_left).offset(38);
        make.right.mas_equalTo(contentBgImage.mas_right).offset(-14);
        make.height.mas_equalTo(44);
    }];
    
    WEAK_SELF
    self.codeTextField.textFieldDidChangeBlock = ^(NSString * _Nonnull text) {
        NSLog(@"text === %@",text);
        if (text.length >= 6) {
            [weakSelf goLogin:text];

        }
    };
    self.codeTextField.codeButtonTapped = ^{
        NSLog(@"code");
        [weakSelf getCode];
    };
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor blackColor];
    loginButton.layer.cornerRadius = 22;
    [loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [contentBgImage addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentBgImage.mas_bottom).offset(-22);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(contentBgImage.mas_centerX);
    }];
    
    UIImageView * tipsBgImage = [[UIImageView alloc] init];
    tipsBgImage.image = [UIImage imageNamed:@"anytime_login_tipsbg"];
    [self.view addSubview:tipsBgImage];
    
    [tipsBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.top.mas_equalTo(contentBgImage.mas_bottom).offset(90);
        make.height.mas_equalTo(80.5);
    }];
   
    self.checkboxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkboxButton setImage:[UIImage imageNamed:@"anytime_login_unse"] forState:UIControlStateNormal];
    [self.checkboxButton setImage:[UIImage imageNamed:@"anytime_login_se"] forState:UIControlStateSelected];
    self.checkboxButton.selected = YES;
    self.isChecked = YES;
    [self.checkboxButton addTarget:self action:@selector(toggleCheckboxState) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkboxButton];
    [self.checkboxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipsBgImage.mas_left).offset(22);
        make.height.width.mas_equalTo(20);
        make.bottom.mas_equalTo(tipsBgImage.mas_bottom).offset(-20);
    }];
    
    self.textLabel = [[YYLabel alloc] init];
    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkboxButton.mas_right).offset(2);
        make.right.mas_equalTo(tipsBgImage.mas_right).offset(-20);
        make.height.mas_equalTo(44);
        make.centerY.mas_equalTo(self.checkboxButton.mas_centerY);
    }];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree to the Privacy Agreement"];
    
    NSRange linkRange = [text.string rangeOfString:@"Privacy Agreement"];

    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:linkRange];

    [text yy_setTextHighlightRange:linkRange color:UIColor.redColor backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self showPrivacyAgreement];
    }];
    
    text.yy_font = [UIFont systemFontOfSize:12];
    text.yy_color = [UIColor blackColor];
    self.textLabel.attributedText = text;
    [self.textLabel sizeToFit];

    [self googleMarket];
}
-(void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)googleMarket
{
    BOOL isLoginGoogleMarket = ![[NSUserDefaults standardUserDefaults] boolForKey:@"isLoginGoogleMarket"];
    if (!isLoginGoogleMarket) 
    {
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
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoginGoogleMarket"];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
}
- (void)getCode
{
//    9123123123
    if (self.phoneTextField.textField.text.length <= 0 ||self.phoneTextField.textField.text == nil)
    {
        [AnyTimeHUD showTextWithText:@"Please enter your phone number"];
    }
    
    [AnyTimeHUD showLoadingHUD];
    self.stateTime = [AnyDevHelper currentTimestampMillis];
    [AnyDevHelper saveToUserDefaults:@"loginStateTime" value:self.stateTime];
    
    [AnyHttpTool requestCodeWithTurning:self.phoneTextField.textField.text direction:@"daasdasdaddd" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        [AnyTimeHUD hideHUD];
        [self.codeTextField startCountdown];
        
    } failure:^(NSError * _Nonnull error) {
      
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}

- (void)goLogin:(NSString *)code
{
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool loginWithBoy:self.phoneTextField.textField.text talk:code events:@"sadadadsdasdd" success:^(id  _Nonnull responseObject) {
        NSLog(@"login === %@",responseObject);
        NSDictionary * loginDic = RDic(responseObject);
        NSString * ssidStr = loginDic[@"sure"];
        if (ssidStr.length)
        {
            [AnyDevHelper saveToUserDefaults:SESSIONID value:ssidStr];
        }
        
        [AnyTimeHUD hideHUD];
        
        [AnyDevHelper saveToUserDefaults:LOGIN_COUNT value:self.phoneTextField.textField.text];
        
        [AnyDevHelper saveBoolToUserDefaults:LOGIN_STATUS value:YES];
        self.endTime = [AnyDevHelper currentTimestampMillis];
        [AnyDevHelper saveToUserDefaults:@"loginEndTime" value:self.endTime];
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
        window.rootViewController = rootVC;
        
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}

- (void)toggleCheckboxState {
    self.isChecked = !self.isChecked;
    self.checkboxButton.selected = self.isChecked;
}

- (void)showPrivacyAgreement {
    
    NSLog(@"Privacy Agreement clicked");
    [[AnyRouter sharedInstance] openURL:[NSString stringWithFormat:@"%@/onionHibis",API] parameters:nil from:self callback:^(NSDictionary * _Nullable result) {

    }];
}


-(void)loginButtonTapped
{
    [self goLogin:self.codeTextField.textField.text];
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
