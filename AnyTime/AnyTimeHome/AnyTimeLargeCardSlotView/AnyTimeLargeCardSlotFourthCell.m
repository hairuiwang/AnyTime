//
//  AnyTimeLargeCardSlotFourthCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotFourthCell.h"
#import "BorderLabel.h"

@implementation AnyTimeLargeCardSlotFourthCell

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
    bgImage.image = [UIImage imageNamed:@"anytime_home_fourthbg"];
    [self.contentView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    BorderLabel * faqLabel = [[BorderLabel alloc] init];
    faqLabel.text = @"Frequently asked questions";
    faqLabel.textColor = UIColor.whiteColor;
    faqLabel.font = ArialFont(17);
    [bgImage addSubview:faqLabel];
    [faqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage.mas_top);
        make.centerX.mas_equalTo(bgImage.mas_centerX);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(60);
    }];


    UILabel * loanLabel = [[UILabel alloc] init];
    loanLabel.text = @"1.What information is needed for a loan?";
    loanLabel.textColor = UIColor.whiteColor;
    loanLabel.adjustsFontSizeToFitWidth = YES;
    loanLabel.backgroundColor = rgba(255, 113, 25, 1);
    loanLabel.layer.cornerRadius = 15;
    loanLabel.layer.masksToBounds = YES;
    loanLabel.font = ArialFont(17);
    [bgImage addSubview:loanLabel];
    [loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage.mas_top).offset(82);
        make.centerX.mas_equalTo(bgImage.mas_centerX);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(30);
    }];
  
    UILabel * loanaLabel = [[UILabel alloc] init];
    loanaLabel.text = @"  Identity card, income certificate, bank statement, etc. Mortgage loans also require collateral-related materials.   ";
    loanaLabel.textColor = UIColor.blackColor;
    loanaLabel.font = ArialFont(17);
    loanaLabel.numberOfLines = 2;
    loanaLabel.adjustsFontSizeToFitWidth = YES;
    loanaLabel.backgroundColor = rgba(243, 243, 243, 1);
    [bgImage addSubview:loanaLabel];
    [loanaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loanLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(bgImage.mas_left).offset(2);
        make.right.mas_equalTo(bgImage.mas_right).offset(-2);
        make.height.mas_equalTo(60);
    }];
    
    UILabel * processLabel = [[UILabel alloc] init];
    processLabel.text = @"2.What is the loan application process?";
    processLabel.textColor = UIColor.whiteColor;
    processLabel.font = ArialFont(17);
    processLabel.adjustsFontSizeToFitWidth = YES;
    processLabel.backgroundColor = rgba(255, 113, 25, 1);
    processLabel.layer.cornerRadius = 15;
    processLabel.layer.masksToBounds = YES;
    [bgImage addSubview:processLabel];
    [processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loanaLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(bgImage.mas_centerX);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(30);
    }];
    
    UILabel * processaLabel = [[UILabel alloc] init];
    processaLabel.text = @"  Prepare documents → submit application → institution review → sign contract → release loan.   ";
    processaLabel.textColor = UIColor.blackColor;
    processaLabel.backgroundColor = rgba(243, 243, 243, 1);
    processaLabel.font = PFSCFont(17);
    processaLabel.numberOfLines = 2;
    processaLabel.adjustsFontSizeToFitWidth = YES;
    [bgImage addSubview:processaLabel];
    [processaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(processLabel.mas_bottom);
        make.left.mas_equalTo(bgImage.mas_left).offset(2);
        make.right.mas_equalTo(bgImage.mas_right).offset(-2);
        make.height.mas_equalTo(60);
    }];
}

@end
