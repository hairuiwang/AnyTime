//
//  AnyTimeSmallCardSlotThirdCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotThirdCell.h"

@interface AnyTimeSmallCardSlotThirdCell ()

@property(nonatomic,strong) UIImageView * logoImage;
@property(nonatomic,strong) UILabel * loanLabel;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) UILabel * leftLabel;
@property(nonatomic,strong) UILabel * rightLabel;
@property(nonatomic,strong) UILabel * leftgrayLabel;
@property(nonatomic,strong) UILabel * rightgrayLabel;
@property(nonatomic,strong) UIButton * goButton;

@end

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
    
    self.logoImage = [[UIImageView alloc] init];
//    self.logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_otherlogo"];
    [contentImage addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImage.mas_top).offset(25);
        make.left.mas_equalTo(contentImage.mas_left).offset(40);
        make.width.mas_equalTo(27);
        make.height.mas_equalTo(27);
    }];
    
    self.loanLabel = [[UILabel alloc] init];
//    self.loanLabel.text = @"AnyTime Loan ";
    self.loanLabel.font = PFSCFont(12);
    self.loanLabel.textColor = UIColor.blackColor;
    [contentImage addSubview:self.loanLabel];
    [self.loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImage.mas_centerY);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
//    self.contentLabel.text = @"₱66,000";
    self.contentLabel.font = PFSCFont(36);
    self.contentLabel.textColor = rgba(255, 113, 25, 1);
    [contentImage addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentImage.mas_centerX);
        make.height.mas_equalTo(46);
    }];
    
    self.leftLabel = [[UILabel alloc] init];
//    self.leftLabel.text = @"0.04%";
    self.leftLabel.font = PFSCFont(15);
    self.leftLabel.textColor = UIColor.blackColor;
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
//    self.rightLabel.text = @"150days";
    self.rightLabel.font = PFSCFont(15);
    self.rightLabel.textColor = UIColor.blackColor;
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.rightLabel];
 
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(-8);
        make.left.mas_equalTo(self.contentView.mas_left).offset(80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(-8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    self.leftgrayLabel = [[UILabel alloc] init];
//    self.leftgrayLabel.text = @"Loan term";
    self.leftgrayLabel.font = PFSCFont(12);
    self.leftgrayLabel.textColor = rgba(188, 187, 185, 1);
    self.leftgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.leftgrayLabel];
    
    self.rightgrayLabel = [[UILabel alloc] init];
//    self.rightgrayLabel.text = @"Interest rate";
    self.rightgrayLabel.font = PFSCFont(12);
    self.rightgrayLabel.textColor = rgba(188, 187, 185, 1);
    self.rightgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.rightgrayLabel];
 
    [self.leftgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    [self.rightgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rightLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-80);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    self.goButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.goButton setTitle:@"Go Apply" forState:UIControlStateNormal];
    self.goButton.titleLabel.font = ArialFont(18);
    [self.goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.goButton.backgroundColor = [UIColor blackColor];
    self.goButton.layer.cornerRadius = 18;
    self.goButton.userInteractionEnabled = NO;
    [self.contentView addSubview:self.goButton];
    
    [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}

- (void)setMurderousModel:(AnyTimeKeepMurderousModel *)murderousModel
{
    NSLog(@" ==== %@",murderousModel.hearing);
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:murderousModel.blood]];
    self.loanLabel.text = murderousModel.pretending;
    self.contentLabel.text = [NSString stringWithFormat:@"₱%@",murderousModel.similar];
    self.leftLabel.text = murderousModel.killed;
    self.rightLabel.text = murderousModel.disgust;
    self.leftgrayLabel.text = murderousModel.seem;
    self.rightgrayLabel.text = murderousModel.source;
    [self.goButton setTitle:murderousModel.scent forState:UIControlStateNormal];
}

@end
