//
//  AnyTimeSmallCardSlotThirdCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotThirdCell.h"

@implementation AnyTimeSmallCardSlotThirdCell

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
    contentImage.image = [UIImage imageNamed:@"anytime_home_smallcard_other"];
    [self.contentView addSubview:contentImage];
    [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(183);
    }];
    
    UIImageView * logoImage = [[UIImageView alloc] init];
    logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_otherlogo"];
    [contentImage addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImage.mas_top).offset(25);
        make.left.mas_equalTo(contentImage.mas_left).offset(40);
        make.width.mas_equalTo(27);
        make.height.mas_equalTo(27);
    }];
    
    UILabel * loanLabel = [[UILabel alloc] init];
    loanLabel.text = @"AnyTime Loan ";
    loanLabel.font = PFSCFont(12);
    loanLabel.textColor = UIColor.blackColor;
    [contentImage addSubview:loanLabel];
    [loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logoImage.mas_centerY);
        make.left.mas_equalTo(logoImage.mas_right).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"₱66,000";
    contentLabel.font = PFSCFont(36);
    contentLabel.textColor = rgba(255, 113, 25, 1);
    [contentImage addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentImage.mas_centerX);
        make.height.mas_equalTo(46);
    }];
    
    UILabel * leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"0.04%";
    leftLabel.font = PFSCFont(15);
    leftLabel.textColor = UIColor.blackColor;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:leftLabel];
    
    UILabel * rightLabel = [[UILabel alloc] init];
    rightLabel.text = @"150days";
    rightLabel.font = PFSCFont(15);
    rightLabel.textColor = UIColor.blackColor;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:rightLabel];
 
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(-8);
        make.left.mas_equalTo(self.contentView.mas_left).offset(80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(-8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    UILabel * leftgrayLabel = [[UILabel alloc] init];
    leftgrayLabel.text = @"Loan term";
    leftgrayLabel.font = PFSCFont(12);
    leftgrayLabel.textColor = rgba(188, 187, 185, 1);
    leftgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:leftgrayLabel];
    
    UILabel * rightgrayLabel = [[UILabel alloc] init];
    rightgrayLabel.text = @"Interest rate";
    rightgrayLabel.font = PFSCFont(12);
    rightgrayLabel.textColor = rgba(188, 187, 185, 1);
    rightgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:rightgrayLabel];
 
    [leftgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    [rightgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    UIButton * goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goButton setTitle:@"Go Apply" forState:UIControlStateNormal];
    goButton.titleLabel.font = ArialFont(18);
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor blackColor];
    goButton.layer.cornerRadius = 18;
    goButton.userInteractionEnabled = NO;
    [self.contentView addSubview:goButton];
    
    [goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}
@end
