//
//  AnyTimeCustomPopupView.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeCustomPopupView.h"

@interface AnyTimeCustomPopupView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation AnyTimeCustomPopupView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = rgba(0, 0, 0, 0.7);
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor grayColor];
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.numberOfLines = 0;
    [self addSubview:self.descriptionLabel];
    
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.firstButton setBackgroundColor:[UIColor blackColor]];
    [self.firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.firstButton.layer.cornerRadius = 22;
    self.firstButton.clipsToBounds = YES;
    [self.firstButton addTarget:self action:@selector(firstButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.firstButton];

    self.secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondButton.layer.borderColor = rgba(0, 0, 0, 1).CGColor;
    self.secondButton.layer.borderWidth = 1;
    [self.secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.secondButton.layer.cornerRadius = 22;
    self.secondButton.clipsToBounds = YES;
    
    [self.secondButton addTarget:self action:@selector(secondButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.secondButton];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"anytime_alertcancel"] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    CGFloat padding = 15;
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(150);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@300);
        make.height.equalTo(@276);
    }];
      
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@30);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-30);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstButton.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.width.height.equalTo(@20);
    }];
    
}

#pragma mark - Setter Methods

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setDescriptionText:(NSString *)descriptionText {
    self.descriptionLabel.text = descriptionText;
}

- (void)setFirstButtonTitle:(NSString *)firstButtonTitle {
    [self.firstButton setTitle:firstButtonTitle forState:UIControlStateNormal];
}

- (void)setSecondButtonTitle:(NSString *)secondButtonTitle {
    [self.secondButton setTitle:secondButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Show and Dismiss Methods

- (void)showInView:(UIView *)parentView {
    [parentView addSubview:self];
    self.frame = parentView.bounds;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Button Actions

- (void)firstButtonTapped {
    if (self.firstButtonAction) {
        self.firstButtonAction();
    }
    [self dismiss];
}

- (void)secondButtonTapped {
    if (self.secondButtonAction) {
        self.secondButtonAction();
    }
    [self dismiss];
}

- (void)closeButtonTapped {
    if (self.closeAction) {
        self.closeAction();
    }
    [self dismiss];
}


@end
