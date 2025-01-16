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

@interface AnyTimeLoginViewController ()

@property (nonatomic, strong) AnyTimeCustomTextField *phoneTextField;
@property (nonatomic, strong) AnyTimeCustomTextField *codeTextField;

@property (nonatomic, strong) YYLabel *textLabel;
@property (nonatomic, strong) UIButton *checkboxButton;
@property (nonatomic, assign) BOOL isChecked;

@end

@implementation AnyTimeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
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
    
    NSString * currentText = [AnyDevHelper loadFromUserDefaults:@"LOGIN_COUNT"];
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
        [weakSelf goLogin];
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

}

- (void)getCode
{
//    9123123123
    if (self.phoneTextField.textField.text.length <= 0 ||self.phoneTextField.textField.text == nil)
    {
        [[AnyTimeHUD sharedManager] showTextWithText:@"Please enter your phone number" inView:self.view];
    }
    [[AnyTimeHUD sharedManager] showLoadingHUDInView:self.view];
   
    [AnyHttpTool requestCodeWithTurning:self.phoneTextField.textField.text direction:@"daasdasdaddd" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        [[AnyTimeHUD sharedManager] hideHUDInView:self.view];
        
    } failure:^(NSError * _Nonnull error) {
      
        [[AnyTimeHUD sharedManager] hideHUDInView:self.view];
    }];
}

- (void)goLogin
{
    [AnyHttpTool loginWithBoy:self.phoneTextField.textField.text talk:self.codeTextField.textField.text events:@"sadadadsdasdd" success:^(id  _Nonnull responseObject) {
        
        [AnyDevHelper saveToUserDefaults:@"LOGIN_COUNT" value:self.phoneTextField.textField.text];
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        AnyTimeRootBarViewController * rootVC = [[AnyTimeRootBarViewController alloc] init];
        window.rootViewController = rootVC;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)toggleCheckboxState {
    self.isChecked = !self.isChecked;
    self.checkboxButton.selected = self.isChecked;
}

- (void)showPrivacyAgreement {
    
    NSLog(@"Privacy Agreement clicked");
    
}


-(void)loginButtonTapped
{
    [self goLogin];
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
