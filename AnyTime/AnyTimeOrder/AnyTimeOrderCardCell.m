//
//  AnyTimeOrderCardCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "AnyTimeOrderCardCell.h"

@implementation AnyTimeOrderCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView * typeImage = [[UIImageView alloc] init];
    typeImage.image = [UIImage imageNamed:@"anytime_order_green"];
    [self.contentView addSubview:typeImage];
    [typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(35);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(95);
        make.width.mas_equalTo(61);
    }];
    
    UILabel * typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"Repayment";
    typeLabel.font = PFSCFont(14);
    typeLabel.textColor = UIColor.blackColor;
    typeLabel.adjustsFontSizeToFitWidth = YES;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [typeImage addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(typeImage.mas_centerX).offset(10);
        make.centerY.mas_equalTo(typeImage.mas_centerY);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(61);

    }];
    
    typeLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    UIImageView * contentImage = [[UIImageView alloc] init];
    contentImage.image = [UIImage imageNamed:@"anytime_order_cellbg"];
    [self.contentView addSubview:contentImage];
    [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-65);
        make.height.mas_equalTo(183);
    }];
    
    UIImageView * logoImage = [[UIImageView alloc] init];
    logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_otherlogo"];
    [contentImage addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImage.mas_top).offset(15);
        make.left.mas_equalTo(contentImage.mas_left).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel * loanLabel = [[UILabel alloc] init];
    loanLabel.text = @"AnyTime Loan ";
    loanLabel.font = PFSCFont(12);
    loanLabel.textColor = UIColor.whiteColor;
    [contentImage addSubview:loanLabel];
    [loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logoImage.mas_centerY);
        make.left.mas_equalTo(logoImage.mas_right).offset(5);
        make.height.mas_equalTo(20);
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
    
    UILabel * leftgrayLabel = [[UILabel alloc] init];
    leftgrayLabel.text = @"Loan term";
    leftgrayLabel.font = PFSCFont(12);
    leftgrayLabel.textColor = rgba(188, 187, 185, 1);
    leftgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:leftgrayLabel];
    
    UILabel * rightgrayLabel = [[UILabel alloc] init];
    rightgrayLabel.text = @"Payment date";
    rightgrayLabel.font = PFSCFont(12);
    rightgrayLabel.textColor = rgba(188, 187, 185, 1);
    rightgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:rightgrayLabel];
 
    [leftgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(35);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    [rightgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftgrayLabel.mas_bottom);
        make.left.mas_equalTo(leftgrayLabel.mas_left);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
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
        make.centerY.mas_equalTo(leftgrayLabel.mas_centerY);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightgrayLabel.mas_centerY);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    UILabel * tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"*Pay on time to increase your credit score, pay now";
    tipsLabel.font = PFSCFont(10);
    tipsLabel.textColor = rgba(253, 0, 0, 1);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:tipsLabel];
 
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightgrayLabel.mas_bottom);
        make.left.mas_equalTo(contentImage.mas_left).offset(20);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.height.mas_equalTo(25);
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
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.left.mas_equalTo(self.contentView.mas_left).offset(75);
    }];
}

@end
