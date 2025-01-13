//
//  AnyTimeSmallCardSlotFirstCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotFirstCell.h"
#import "OutlineLabel.h"

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

    UILabel * leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"0.04%";
    leftLabel.font = PFSCFont(15);
    leftLabel.textColor = UIColor.whiteColor;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:leftLabel];
    
    UILabel * rightLabel = [[UILabel alloc] init];
    rightLabel.text = @"150days";
    rightLabel.font = PFSCFont(15);
    rightLabel.textColor = UIColor.whiteColor;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:rightLabel];
 
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
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(40);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UIImageView * logoImage = [[UIImageView alloc] init];
    logoImage.image = [UIImage imageNamed:@"anytime_home_smallcard_firslogo"];
    [self.contentView addSubview:logoImage];
 
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(leftImage.mas_right).offset(20);
        make.width.mas_equalTo(41);
        make.height.mas_equalTo(41);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AnyTime Loan";
    titleLabel.font = PFSCFont(15);
    titleLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logoImage.mas_centerY);
        make.left.mas_equalTo(logoImage.mas_right).offset(10);
        make.right.mas_equalTo(rightImage.mas_left).offset(-20);
        make.height.mas_equalTo(41);
    }];

    OutlineLabel * contentLabel = [[OutlineLabel alloc] init];
    contentLabel.text = @"₱66,000";
    contentLabel.font = PFSCFont(64);
    contentLabel.textColor = UIColor.blackColor;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [bgImage addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UILabel * amountLabel = [[UILabel alloc] init];
    amountLabel.text = @"\nLoan amount";
    amountLabel.font = PFSCFont(12);
    amountLabel.layer.cornerRadius = 10;
    amountLabel.numberOfLines = 0;
    amountLabel.layer.masksToBounds = YES;
    amountLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.textColor = UIColor.whiteColor;
    amountLabel.backgroundColor = UIColor.blackColor;
    [amountView addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(amountView.mas_centerX);
        make.top.mas_equalTo(amountView.mas_top).offset(-20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
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
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-22);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}
@end
