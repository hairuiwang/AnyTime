//
//  AnyVerifyIdentityInfoConfirmedPop.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    
#import "AnyTimeCustomPopupView.h"
#import "AnyVerifyIdentityInfoConfirmedPop.h"
#import "AnyInfoConfirmedView.h"
@interface AnyVerifyIdentityInfoConfirmedPop ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) AnyInfoConfirmedView *fullName;
@property (nonatomic, strong) AnyInfoConfirmedView *IDNO;
@property (nonatomic, strong) AnyInfoConfirmedView *dateBirth;
@end

@implementation AnyVerifyIdentityInfoConfirmedPop

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLORA(0x000000, 0.4);
    [self setupUI];
}


- (void)setupUI {
    self.bgImageView = [UIImageView new];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"info-confirm-icon"];
    CGFloat height = SCALED_HEIGHT(image.size.width, image.size.height, SCREEN_WIDTH - 38*2);
    self.bgImageView.image = image;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38);
        make.right.mas_equalTo(self.view.mas_right).offset(-38);
        make.height.mas_equalTo(height);
        make.centerY.mas_equalTo(self.view);
    }];
    
    UILabel *titleLabel = [AnyUIFactory labelWithText:@"Identity Information" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15] textAlignment:(NSTextAlignmentCenter)];
    [self.bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(13);
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(82);
    }];
    
    self.fullName = [[AnyInfoConfirmedView alloc] initWithFrame:(CGRectZero)];
    self.fullName.titleLabel.text  = @"Full Name";
    self.fullName.isClick = NO;
    self.IDNO = [[AnyInfoConfirmedView alloc] initWithFrame:(CGRectZero)];
    self.IDNO.titleLabel.text  = @"ID NO.";
    self.IDNO.isClick = NO;
    self.dateBirth = [[AnyInfoConfirmedView alloc] initWithFrame:(CGRectZero)];
    self.dateBirth.isClick = true;
    self.dateBirth.titleLabel.text  = @"Date of Birth";
    
    [self.view addSubview:self.fullName];
    [self.view addSubview:self.IDNO];
    [self.view addSubview:self.dateBirth];
    
    [self.fullName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgImageView.mas_left).offset(19);
        make.right.mas_equalTo(_bgImageView.mas_right).offset(-19);
        make.bottom.mas_equalTo(_bgImageView.mas_bottom).offset(-165);
    }];
    
    [self.IDNO mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgImageView.mas_left).offset(19);
        make.right.mas_equalTo(_bgImageView.mas_right).offset(-19);
        make.top.mas_equalTo(self.fullName.mas_bottom);
    }];
    
    [self.dateBirth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgImageView.mas_left).offset(19);
        make.right.mas_equalTo(_bgImageView.mas_right).offset(-19);
        make.top.mas_equalTo(self.IDNO.mas_bottom);
    }];
    __weak typeof(self) weakSelf = self;
    self.dateBirth.dateHandler = ^{
        [weakSelf dateSelect:weakSelf.dateBirth.textField.text];
    };
    
    UIButton *confirmButton = [AnyUIFactory buttonWithTitle:@"Confirm" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(confirmButtonClick)];
    [self.view addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(13);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *closeButton = [UIButton new];
    [closeButton setImage:[UIImage imageNamed:@"close-icon"] forState:(UIControlStateNormal)];
    [closeButton addTarget:self action:@selector(closeTouchClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(confirmButton.mas_bottom).offset(15);
    }];
    [self dataconfigured];
}
- (void) dataconfigured {
    if (self.parameters != nil) {
        NSString *groove = self.parameters[@"groove"];
        NSString *people = self.parameters[@"people"];
        NSString *ruins = self.parameters[@"ruins"];
        
        self.fullName.textField.text = groove;
        self.IDNO.textField.text = people;
        self.dateBirth.textField.text = ruins;
    }
}


- (void)dateSelect:(NSString *)date {
    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initDateSelectionWithFrame:self.view.bounds WithDateString:date];

    popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbigbg"];
    popupView.titleText = @"Date select";
    popupView.dateSelectAction = ^(NSString * _Nonnull date) {
        NSLog(@"date = %@",date);
        self.dateBirth.textField.text = date;
    };

    popupView.closeAction = ^{
        NSLog(@"Close button tapped");
    };

    [popupView showInView:self.view];
}

- (void) confirmButtonClick {
    if (self.dateBirth.textField.text.length == 0) {
        [AnyTimeHUD showTextWithText:@"Please select your date of birth"];
        return;
    }
    if (self.fullName.textField.text.length == 0) {
        [AnyTimeHUD showTextWithText:@"Please enter your full name"];
        return;
    }
    if (self.IDNO.textField.text.length == 0) {
        [AnyTimeHUD showTextWithText:@"Please enter your ID number"];
        return;
    }
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool saveUserIdentityWithRuins:self.dateBirth.textField.text people:self.IDNO.textField.text groove:self.fullName.textField.text aura:@"11" top:self.type flinched:@"cxczlkjsaldjalskdjlad" success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        self.complete();
        [self dismissViewControllerAnimated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.detailParameters from:nil callback:^(NSDictionary * _Nullable result) {
                }];
            });
            
        }];
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}
- (void) closeTouchClick {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
