//
//  AnyTimeLargeCardSlotThirdCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotThirdCell.h"
#import "GradientBorderLabel.h"

@implementation AnyTimeLargeCardSlotThirdCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView * tipsImage = [[UIImageView alloc] init];
    tipsImage.image = [UIImage imageNamed:@"anytime_home_thirdtips"];
    [self.contentView addSubview:tipsImage];
    [tipsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-142);
        make.height.mas_equalTo(50);
    }];
    
    GradientBorderLabel * tipsLabel = [[GradientBorderLabel alloc] init];
    tipsLabel.text = @"Several major features";
    tipsLabel.textColor = UIColor.whiteColor;
    tipsLabel.font = PFSCFont(15);
    [tipsImage addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipsImage.mas_left).offset(10);
        make.centerY.mas_equalTo(tipsImage.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    [tipsLabel layoutIfNeeded];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 1);

    NSDictionary *attributes = @{
        NSFontAttributeName: PFSCFont(15),
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSShadowAttributeName: shadow
    };

    tipsLabel.attributedText = [[NSAttributedString alloc] initWithString:tipsLabel.text attributes:attributes];

    
    UIImageView * bgImage = [[UIImageView alloc] init];
    [self.contentView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsImage.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(250);
    }];
    
    UIImageView * hImage = [[UIImageView alloc] init];
    hImage.image = [UIImage imageNamed:@"anytime_home_thirdh"];
    [bgImage addSubview:hImage];
    
    [hImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage.mas_top).offset(25);
        make.left.mas_equalTo(bgImage.mas_left).offset(15);
        make.right.mas_equalTo(bgImage.mas_right).offset(-15);
        make.height.mas_equalTo(64);
    }];
    
    UILabel * hLabel = [[UILabel alloc] init];
    hLabel.text = @"High loan amount";
    hLabel.textColor = UIColor.blackColor;
    hLabel.font = PFSCFont(14);
    [hImage addSubview:hLabel];
    [hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hImage.mas_left).offset(175);
        make.centerY.mas_equalTo(hImage.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView * uImage = [[UIImageView alloc] init];
    uImage.image = [UIImage imageNamed:@"anytime_home_thirdu"];
    [bgImage addSubview:uImage];
    [uImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hImage.mas_bottom);
        make.left.mas_equalTo(bgImage.mas_left).offset(15);
        make.right.mas_equalTo(bgImage.mas_right).offset(-15);
        make.height.mas_equalTo(64);
    }];
    
    UILabel * uLabel = [[UILabel alloc] init];
    uLabel.text = @"Unsecured loans";
    uLabel.textColor = UIColor.blackColor;
    uLabel.font = PFSCFont(14);
    uLabel.textAlignment = NSTextAlignmentCenter;
    [uImage addSubview:uLabel];
    [uLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(uImage.mas_left).offset(15);
        make.centerY.mas_equalTo(uImage.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView * qImage = [[UIImageView alloc] init];
    qImage.image = [UIImage imageNamed:@"anytime_home_thirdq"];
    [bgImage addSubview:qImage];
    [qImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(uImage.mas_bottom);
        make.left.mas_equalTo(bgImage.mas_left).offset(15);
        make.right.mas_equalTo(bgImage.mas_right).offset(-15);
        make.height.mas_equalTo(64);
    }];
    
    UILabel * qLabel = [[UILabel alloc] init];
    qLabel.text = @"Quick Review";
    qLabel.textColor = UIColor.blackColor;
    qLabel.font = PFSCFont(14);
    [qImage addSubview:qLabel];
    [qLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(qImage.mas_left).offset(195);
        make.centerY.mas_equalTo(qImage.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
}

@end
