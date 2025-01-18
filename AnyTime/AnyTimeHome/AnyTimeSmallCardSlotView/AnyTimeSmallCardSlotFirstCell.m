//
//  AnyTimeSmallCardSlotFirstCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotFirstCell.h"
#import "OutlineLabel.h"

@interface AnyTimeSmallCardSlotFirstCell()

@property(nonatomic,strong) UILabel * leftLabel;
@property(nonatomic,strong) UILabel * rightLabel;
@property(nonatomic,strong) UIImageView * logoImage;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) OutlineLabel * contentLabel;
@property(nonatomic,strong) UILabel * amountLabel;
@property(nonatomic,strong) UIButton * goButton;

@end

@implementation AnyTimeSmallCardSlotFirstCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView * bgImage = [[UIImageView alloc] init];
    bgImage.image = [UIImage imageNamed:@"anytime_home_smallcard_first"];
    [self.contentView addSubview:bgImage];
    
    UIImageView * leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"anytime_home_smallcard_firstl"];
    [self.contentView addSubview:leftImage];
  
    
    UIImageView * rightImage = [[UIImageView alloc] init];
    rightImage.image = [UIImage imageNamed:@"anytime_home_smallcard_firsr"];
    [self.contentView addSubview:rightImage];

    self.leftLabel = [[UILabel alloc] init];
//    self.leftLabel.text = @"0.04%";
    self.leftLabel.font = PFSCFont(15);
    self.leftLabel.textColor = UIColor.whiteColor;
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
//    self.rightLabel.text = @"150days";
    self.rightLabel.font = PFSCFont(15);
    self.rightLabel.textColor = UIColor.whiteColor;
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rightLabel];
 
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(62);
    }];
    
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(62);
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(40);
    }];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftImage.mas_bottom).offset(-15);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(250);
    }];
    
    self.logoImage = [[UIImageView alloc] init];
//    self.logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_firslogo"];
    [self.contentView addSubview:self.logoImage];
 
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(leftImage.mas_right).offset(20);
        make.width.mas_equalTo(41);
        make.height.mas_equalTo(41);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = @"AnyTime Loan";
    self.titleLabel.font = PFSCFont(15);
    self.titleLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImage.mas_centerY);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(10);
        make.right.mas_equalTo(rightImage.mas_left).offset(-20);
        make.height.mas_equalTo(41);
    }];

    self.contentLabel = [[OutlineLabel alloc] init];
//    self.contentLabel.text = @"₱66,000";
    self.contentLabel.font = PFSCFont(64);
    self.contentLabel.textColor = UIColor.blackColor;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    [bgImage addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage.mas_top).offset(65);
        make.left.mas_equalTo(bgImage.mas_left).offset(15);
        make.right.mas_equalTo(bgImage.mas_right).offset(-15);
        make.height.mas_equalTo(80);
    }];
    
    
    UIView * amountView = [[UIView alloc] init];
    amountView.layer.masksToBounds = YES;
    [bgImage addSubview:amountView];
    [amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage.mas_top).offset(40);
        make.centerX.mas_equalTo(bgImage.mas_centerX);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(27);
    }];
    
    self.amountLabel = [[UILabel alloc] init];
//    self.amountLabel.text = @"\nLoan amount";
    self.amountLabel.font = PFSCFont(12);
    self.amountLabel.layer.cornerRadius = 10;
    self.amountLabel.numberOfLines = 0;
    self.amountLabel.layer.masksToBounds = YES;
    self.amountLabel.textAlignment = NSTextAlignmentCenter;
    self.amountLabel.textColor = UIColor.whiteColor;
    self.amountLabel.backgroundColor = UIColor.blackColor;
    [amountView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(amountView.mas_centerX);
        make.top.mas_equalTo(amountView.mas_top).offset(-20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
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
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-22);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}

- (void)setMurderousModel:(AnyTimeActMurderousModel *)murderousModel
{
    self.leftLabel.text = murderousModel.disgust;
    self.rightLabel.text = murderousModel.killed;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:murderousModel.blood]];
    self.titleLabel.text = murderousModel.pretending;
    self.contentLabel.text = [NSString stringWithFormat:@"₱%@",murderousModel.similar];
    self.amountLabel.text = [NSString stringWithFormat:@"\n%@",murderousModel.punk];
    [self.goButton setTitle:murderousModel.scent forState:UIControlStateNormal];
}

@end
