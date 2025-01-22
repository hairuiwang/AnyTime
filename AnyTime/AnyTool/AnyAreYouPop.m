//
//  AnyAreYouPop.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyAreYouPop.h"

@interface AnyAreYouPop ()
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation AnyAreYouPop

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLORA(0x000000, 0.4);
    
    [self setupUI];
}

-(void) setupUI {
    self.bgImageView = [UIImageView new];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"are_you_icon"];
    CGFloat height = SCALED_HEIGHT(image.size.width, image.size.height, SCREEN_WIDTH - 38*2);
    CGFloat bottomHeight = SCALED_HEIGHT(image.size.width, 139, SCREEN_WIDTH - 38*2);
    CGFloat topSpace = SCALED_HEIGHT(image.size.width, 56, SCREEN_WIDTH - 38*2);
    
    self.bgImageView.image = image;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38);
        make.right.mas_equalTo(self.view.mas_right).offset(-38);
        make.height.mas_equalTo(height);
        make.centerY.mas_equalTo(self.view);
    }];
    UILabel *titleLabel = [AnyUIFactory labelWithText:@"Are you certain that you wish to skip the verification of this information? " textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15] textAlignment:(NSTextAlignmentCenter)];
    titleLabel.numberOfLines = 0;
    [self.bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(13);
        make.right.mas_equalTo(self.bgImageView.mas_right).offset(-18);
        make.top.mas_equalTo(self.bgImageView.mas_centerY).offset(-80);
    }];
    
    UILabel *messageLabel = [AnyUIFactory labelWithText:@"*Please note that finishing the authentication process will enhance the likelihood of your loan being a pproved." textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:(NSTextAlignmentCenter)];
    messageLabel.numberOfLines = 0;
    [self.bgImageView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.bgImageView.mas_right).offset(-30);
        make.top.mas_equalTo(self.bgImageView.mas_centerY).offset(40);
    }];
    
    UIButton *confirmButton = [AnyUIFactory buttonWithTitle:@"Confirm" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(confirmButtonClick)];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(18);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *giveUpButton = [AnyUIFactory buttonWithTitle:@"Give Up" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] cornerRadius:22 target:self action:@selector(giveUpButtonClick)];
    [self.view addSubview:giveUpButton];
    giveUpButton.layer.cornerRadius = 22;
    giveUpButton.layer.borderWidth = 1;
    giveUpButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [giveUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.top.mas_equalTo(confirmButton.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *closeButton = [UIButton new];
    [closeButton setImage:[UIImage imageNamed:@"close-icon"] forState:(UIControlStateNormal)];
    [closeButton addTarget:self action:@selector(closeTouchClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(giveUpButton.mas_bottom).offset(15);
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
- (void) giveUpButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.giveUpBlock) {
            self.giveUpBlock();
        }
    }];
}
@end
