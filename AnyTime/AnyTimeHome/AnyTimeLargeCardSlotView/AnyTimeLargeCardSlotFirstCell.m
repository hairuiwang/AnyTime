//
//  AnyTimeLargeCardSlotFirstCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotFirstCell.h"

@implementation AnyTimeLargeCardSlotFirstCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = [UIImage imageNamed:@"anytime_home_titleimage"];
    [self.contentView addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(-22);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(110);
    }];
    
    UIImageView * xrImage = [[UIImageView alloc] init];
    xrImage.image = [UIImage imageNamed:@"anytime_home_xiaoren"];
    [self.contentView addSubview:xrImage];
    [xrImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImage.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(163);
        make.height.mas_equalTo(177);
    }];
   
    UIImageView * contentBgImage = [[UIImageView alloc] init];
    contentBgImage.image = [UIImage imageNamed:@"anytime_home_numbg"];
    [self.contentView addSubview:contentBgImage];
    [contentBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImage.mas_bottom).offset(35);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-125);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(77);
    }];
    
    NSString *numberString = @"66000";
       
    CGFloat labelWidth = 30;
    CGFloat labelHeight = 44;
    CGFloat labelMargin = 10;
    
    CGFloat xOffset = 20;
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 16, labelWidth, labelHeight)];
        
        label.text = [NSString stringWithFormat:@"%C", [numberString characterAtIndex:i]];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FuturaFont(38);
        label.layer.borderWidth = 1.5;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.backgroundColor = [UIColor yellowColor];
        
        [contentBgImage addSubview:label];
        
        xOffset += labelWidth + labelMargin;
    }
    

    UIImageView * jsqBgImage = [[UIImageView alloc] init];
    jsqBgImage.image = [UIImage imageNamed:@"anytime_home_jsqbg"];
    [self.contentView addSubview:jsqBgImage];
    [jsqBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImage.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(18);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }];
    
    UIImageView * jsqImage = [[UIImageView alloc] init];
    jsqImage.image = [UIImage imageNamed:@"anytime_home_jsq"];
    [jsqBgImage addSubview:jsqImage];
    [jsqImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jsqBgImage.mas_top).offset(4);
        make.left.mas_equalTo(jsqBgImage.mas_left).offset(9);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(21);
    }];
    
    UILabel * jsqLabel = [[UILabel alloc] init];
    jsqLabel.text = @"0.04% / day";
    jsqLabel.textColor = UIColor.blackColor;
    jsqLabel.font = PFSCFont(15);
    [jsqBgImage addSubview:jsqLabel];
    [jsqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(jsqImage.mas_right);
        make.centerY.mas_equalTo(jsqImage.mas_centerY);
        make.height.mas_equalTo(21);
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
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
    }];
    
    UIImageView * szBgImage = [[UIImageView alloc] init];
    szBgImage.image = [UIImage imageNamed:@"anytime_home_jsqbg"];
    [self.contentView addSubview:szBgImage];
    [szBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-45);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-120);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(35);
    }];
    
    UIImageView * szImage = [[UIImageView alloc] init];
    szImage.image = [UIImage imageNamed:@"anytime_home_sz"];
    [szBgImage addSubview:szImage];
    [szImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(szBgImage.mas_top).offset(4);
        make.left.mas_equalTo(szBgImage.mas_left).offset(9);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(21);
    }];
    
    UILabel * szLabel = [[UILabel alloc] init];
    szLabel.text = @"150days";
    szLabel.textColor = UIColor.blackColor;
    szLabel.font = PFSCFont(15);
    [szBgImage addSubview:szLabel];
    [szLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(szImage.mas_right);
        make.centerY.mas_equalTo(szImage.mas_centerY);
        make.height.mas_equalTo(21);
    }];
    
}

@end
