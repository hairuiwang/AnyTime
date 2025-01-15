//
//  AnyBottomProductInfor.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyBottomProductInfor.h"

@interface AnyBottomProductInfor ()
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *goApplyButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceNameLabel;
@end

@implementation AnyBottomProductInfor
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBgView];
    }
    return self;
}
- (void)setupBgView {
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *img = [UIImage imageNamed:@"CertificationDetails_bottom_bg"];
    
    CGFloat width = SCREEN_WIDTH - 30;
    CGFloat height = SCALED_HEIGHT(img.size.width, img.size.height, width);
    
    bgImageView.image = img;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(height);
    }];
    
    
    self.leftButton =  [UIButton new];
    self.leftButton.userInteractionEnabled = NO;
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"CertificationDetails_bottom_bg_mask"] forState:(UIControlStateNormal)];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.leftButton setTitle:@"0.04%" forState:(UIControlStateNormal)];
    
    self.rightButton =  [UIButton new];
    self.rightButton.userInteractionEnabled = NO;
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"CertificationDetails_bottom_bg_mask"] forState:(UIControlStateNormal)];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton setTitle:@"150days" forState:(UIControlStateNormal)];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(13);
        make.top.mas_equalTo(self).offset(3);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(31);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-13);
        make.top.mas_equalTo(self).offset(3);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(31);
    }];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:50];
    self.priceLabel.textColor = [UIColor blackColor];
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(64);
        make.height.mas_equalTo(62);
    }];
    self.priceLabel.text = @"₱66,000";
    // 创建描边属性
    NSDictionary *attributes = @{
        NSStrokeColorAttributeName : [UIColor whiteColor],  // 描边颜色（白色）
        NSForegroundColorAttributeName : [UIColor blackColor],  // 文字颜色（黑色）
        NSStrokeWidthAttributeName : @(-7)  // 描边宽度（负数表示填充文字）
    };
    // 设置富文本
    self.priceLabel.attributedText = [[NSAttributedString alloc] initWithString:self.priceLabel.text attributes:attributes];

    
    
    self.priceNameLabel = [UILabel new];
    self.priceNameLabel.text = @"Loan amount";
    self.priceNameLabel.font = [UIFont systemFontOfSize:12];
    self.priceNameLabel.textColor = [UIColor whiteColor];
    self.priceNameLabel.backgroundColor = [UIColor blackColor];
    self.priceNameLabel.textAlignment = NSTextAlignmentCenter;
    self.priceNameLabel.layer.masksToBounds = YES;
    self.priceNameLabel.layer.cornerRadius = 10;
    self.priceNameLabel.layer.maskedCorners = kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    [self addSubview:self.priceNameLabel];
    [self.priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(40);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(27);
    }];
    
    
    self.goApplyButton =  [UIButton new];
    self.goApplyButton.userInteractionEnabled = NO;
    self.goApplyButton.backgroundColor = [UIColor blackColor];
    self.goApplyButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.goApplyButton setTitle:@"Go Apply " forState:(UIControlStateNormal)];
    [self.goApplyButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.goApplyButton.layer.cornerRadius = 20;
    self.goApplyButton.layer.masksToBounds = YES;
    [self addSubview:self.goApplyButton];
    [self addSubview:self.goApplyButton];
    [self.goApplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-11);
        make.width.mas_equalTo(181);
        make.height.mas_equalTo(40);
    }];
}
@end
