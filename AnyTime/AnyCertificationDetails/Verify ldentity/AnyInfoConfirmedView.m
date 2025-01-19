//
//  AnyInfoConfirmedView.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyInfoConfirmedView.h"
@interface AnyInfoConfirmedView ()

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *button;
@end
@implementation AnyInfoConfirmedView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void) setupUI {
    self.titleLabel = [AnyUIFactory labelWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] textAlignment:(NSTextAlignmentCenter)];
    self.textField = [UITextField new];
    self.textField.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightBold)];
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.textColor = [UIColor blackColor];
    self.textField.layer.cornerRadius = 10;
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    self.textField.layer.borderWidth = 1;
    
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(17);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(36);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    self.rightImageView = [UIImageView new];
    self.rightImageView.image = [UIImage imageNamed:@"right_arrow_icon"];
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textField.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.width.height.mas_equalTo(14);
    }];
    self.rightImageView.hidden = YES;
    
    self.button = [UIButton new];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.textField);
    }];
}
- (void) buttonClick {
    if (self.dateHandler) {
        self.dateHandler();
    }
}
- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    
    self.button.hidden = !_isClick;
    self.rightImageView.hidden = !_isClick;
}
@end

