//
//  AnyTimeSmallCardSlotSecondCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotSecondCell.h"

@implementation AnyTimeSmallCardSlotSecondCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView * contentImage = [[UIImageView alloc] init];
    contentImage.image = [UIImage imageNamed:@"anytime_home_smallcard_second"];
    [self.contentView addSubview:contentImage];
 
    [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(121);
    }];
    
    UILabel * loanLabel = [[UILabel alloc] init];
    loanLabel.text = @"Supermarket loan";
    loanLabel.font = FuturaFont(18);
    loanLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:loanLabel];
    [loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(30);
    }];
}
@end
