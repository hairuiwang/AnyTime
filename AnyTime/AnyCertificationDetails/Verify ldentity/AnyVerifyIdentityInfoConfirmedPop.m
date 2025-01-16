//
//  AnyVerifyIdentityInfoConfirmedPop.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

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
}


- (void) confirmButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void) closeTouchClick {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
