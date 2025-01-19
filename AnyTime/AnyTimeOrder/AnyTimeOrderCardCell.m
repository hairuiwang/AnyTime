//
//  AnyTimeOrderCardCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "AnyTimeOrderCardCell.h"

@interface AnyTimeOrderCardCell()

@property (nonatomic,strong) UIImageView * typeImage;
@property (nonatomic,strong) UILabel * typeLabel;
@property (nonatomic,strong) UIImageView * logoImage;
@property (nonatomic,strong) UILabel * loanLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * leftgrayLabel;
@property (nonatomic,strong) UILabel * rightgrayLabel;
@property (nonatomic,strong) UILabel * leftLabel;
@property (nonatomic,strong) UILabel * rightLabel;
@property (nonatomic,strong) UILabel * tipsLabel;
@property (nonatomic,strong) UIButton * goButton;

@end

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
    self.typeImage = [[UIImageView alloc] init];
//    self.typeImage.image = [UIImage imageNamed:@"anytime_order_green"];
    [self.contentView addSubview:self.typeImage];
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(35);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(95);
        make.width.mas_equalTo(61);
    }];
    
    self.typeLabel = [[UILabel alloc] init];
//    self.typeLabel.text = @"Repayment";
    self.typeLabel.font = PFSCFont(14);
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.typeImage addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.typeImage.mas_centerX).offset(10);
        make.centerY.mas_equalTo(self.typeImage.mas_centerY);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(61);

    }];
    
    self.typeLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    UIImageView * contentImage = [[UIImageView alloc] init];
    contentImage.image = [UIImage imageNamed:@"anytime_order_cellbg"];
    [self.contentView addSubview:contentImage];
    [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-65);
        make.height.mas_equalTo(183);
    }];
    
    self.logoImage = [[UIImageView alloc] init];
    self.logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_otherlogo"];
    [contentImage addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImage.mas_top).offset(15);
        make.left.mas_equalTo(contentImage.mas_left).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.loanLabel = [[UILabel alloc] init];
    self.loanLabel.text = @"AnyTime Loan ";
    self.loanLabel.font = PFSCFont(12);
    self.loanLabel.textColor = UIColor.whiteColor;
    self.loanLabel.adjustsFontSizeToFitWidth = YES;

    [contentImage addSubview:self.loanLabel];
    [self.loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImage.mas_centerY);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.text = @"₱66,000";
    self.contentLabel.font = PFSCFont(36);
    self.contentLabel.textColor = rgba(255, 113, 25, 1);
    self.contentLabel.adjustsFontSizeToFitWidth = YES;

    [contentImage addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentImage.mas_centerX);
        make.height.mas_equalTo(46);
    }];
    
    self.leftgrayLabel = [[UILabel alloc] init];
//    self.leftgrayLabel.text = @"Loan term";
    self.leftgrayLabel.font = PFSCFont(12);
    self.leftgrayLabel.adjustsFontSizeToFitWidth = YES;
    self.leftgrayLabel.textColor = rgba(188, 187, 185, 1);
    self.leftgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.leftgrayLabel];
    
    self.rightgrayLabel = [[UILabel alloc] init];
//    self.rightgrayLabel.text = @"Payment date";
    self.rightgrayLabel.font = PFSCFont(12);
    self.rightgrayLabel.adjustsFontSizeToFitWidth = YES;
    self.rightgrayLabel.textColor = rgba(188, 187, 185, 1);
    self.rightgrayLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.rightgrayLabel];
 
    [self.leftgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(35);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    [self.rightgrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftgrayLabel.mas_bottom);
        make.left.mas_equalTo(self.leftgrayLabel.mas_left);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    self.leftLabel = [[UILabel alloc] init];
//    self.leftLabel.text = @"0.04%";
    self.leftLabel.font = PFSCFont(15);
    self.leftLabel.textColor = UIColor.blackColor;
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel.adjustsFontSizeToFitWidth = YES;

    [contentImage addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
//    self.rightLabel.text = @"150days";
    self.rightLabel.font = PFSCFont(15);
    self.rightLabel.textColor = UIColor.blackColor;
    self.rightLabel.adjustsFontSizeToFitWidth = YES;

    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.rightLabel];
 
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftgrayLabel.mas_centerY);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightgrayLabel.mas_centerY);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(25);
    }];
    
    self.tipsLabel = [[UILabel alloc] init];
//    self.tipsLabel.text = @"*Pay on time to increase your credit score, pay now";
    self.tipsLabel.font = PFSCFont(10);
    self.tipsLabel.textColor = rgba(253, 0, 0, 1);
    self.tipsLabel.adjustsFontSizeToFitWidth = YES;
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    [contentImage addSubview:self.tipsLabel];
 
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rightgrayLabel.mas_bottom);
        make.left.mas_equalTo(contentImage.mas_left).offset(20);
        make.right.mas_equalTo(contentImage.mas_right).offset(-20);
        make.height.mas_equalTo(25);
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
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.left.mas_equalTo(self.contentView.mas_left).offset(75);
    }];
}

- (void)setGoldenModel:(AnyTimeOrderBlowGoldenModel *)goldenModel
{
    NSLog(@"gol === %@",goldenModel.pretending);
   
    self.typeLabel.text = goldenModel.through;

    if (goldenModel.now == 1)
    {
        self.typeImage.image = [UIImage imageNamed:@"anytime_order_green"];
//        self.typeLabel.text = @"Delay";
        self.typeLabel.textColor = UIColor.blackColor;

    }
    else if (goldenModel.now == 2)
    {
        self.typeImage.image = [UIImage imageNamed:@"anytime_order_yellow"];
//        self.typeLabel.text = @"Repayment";
        self.typeLabel.textColor = UIColor.blackColor;

    }
    else if (goldenModel.now == 3)
    {
        self.typeImage.image = [UIImage imageNamed:@"anytime_order_cyan"];
//        self.typeLabel.text = @"Applying";
        self.typeLabel.textColor = UIColor.blackColor;

    }
    else if (goldenModel.now == 4)
    {
        self.typeImage.image = [UIImage imageNamed:@"anytime_order_white"];
//        self.typeLabel.text = @"Review";
        self.typeLabel.textColor = rgba(231, 0, 255, 1);

    }
    else
    {
        self.typeImage.image = [UIImage imageNamed:@"anytime_order_white"];
//        self.typeLabel.text = @"Finish";
        self.typeLabel.textColor = rgba(200, 200, 200, 1);
    }
    
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:goldenModel.blood]];
    self.loanLabel.text = goldenModel.pretending;
    self.contentLabel.text = [NSString stringWithFormat:@"₱%@",goldenModel.easily];
    self.leftLabel.text = goldenModel.puzzle;
    self.rightLabel.text = goldenModel.injury;
    self.leftgrayLabel.text = goldenModel.passing;
    self.rightgrayLabel.text = goldenModel.nagging;
   
    if (goldenModel.touched.length > 0)
    {
        self.tipsLabel.hidden = NO;
        self.tipsLabel.text = goldenModel.touched;
    }
    else
    {
        self.tipsLabel.hidden = YES;
    }
    if (goldenModel.first.length >0)
    {
        self.goButton.hidden = NO;
        [self.goButton setTitle:goldenModel.first forState:UIControlStateNormal];
    }
    else
    {
        self.goButton.hidden = YES;
    }
}

@end
