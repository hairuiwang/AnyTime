//
//  AnyTimeLargeCardSlotFirstCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotFirstCell.h"
@interface AnyTimeLargeCardSlotFirstCell()

@property(nonatomic,strong) UILabel * jsqLabel;
@property(nonatomic,strong) UILabel * szLabel;
@property(nonatomic,strong) UIButton * goButton;

@end
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
    
    NSString * numberString = @"66000";
       
    CGFloat labelWidth = 30;
    CGFloat labelHeight = 44;
    CGFloat labelMargin = 10;
    
    CGFloat xOffset = 20;
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 16, labelWidth, labelHeight)];
        
//        label.text = [NSString stringWithFormat:@"%C", [numberString characterAtIndex:i]];
        label.tag = 1001 + i;
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
    
    self.jsqLabel = [[UILabel alloc] init];
//    self.jsqLabel.text = @"0.04% / day";
    self.jsqLabel.textColor = UIColor.blackColor;
    self.jsqLabel.font = PFSCFont(15);
    self.jsqLabel.adjustsFontSizeToFitWidth = YES;
    [jsqBgImage addSubview:self.jsqLabel];
    [self.jsqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(jsqImage.mas_right);
        make.centerY.mas_equalTo(jsqImage.mas_centerY);
        make.height.mas_equalTo(21);
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
    
    self.szLabel = [[UILabel alloc] init];
//    self.szLabel.text = @"150days";
    self.szLabel.textColor = UIColor.blackColor;
    self.szLabel.font = PFSCFont(15);
    self.szLabel.adjustsFontSizeToFitWidth = YES;
    [szBgImage addSubview:self.szLabel];
    [self.szLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(szImage.mas_right).offset(5);
        make.centerY.mas_equalTo(szImage.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(21);
    }];
    
}

- (void)setMurderousModel:(AnyTimeActMurderousModel *)murderousModel
{
    if([murderousModel.similar containsString:@","])
    {
        NSString *numberString = murderousModel.similar;
        NSString *formattedString = [numberString stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSLog(@"Formatted string: %@", formattedString);  // 输出: 50000
        for (int i = 0; i < 5; i++) {
            
            UILabel *labelToModify = (UILabel *)[self viewWithTag:1001 + i];
            if (labelToModify) {
                labelToModify.text = [NSString stringWithFormat:@"%C", [formattedString characterAtIndex:i]];
            }
        }
    }
    NSLog(@"murderousModel === %@",murderousModel.similar);
    
    self.jsqLabel.text = murderousModel.disgust;
    self.szLabel.text = murderousModel.killed;
    
    [self.goButton setTitle:murderousModel.scent forState:UIControlStateNormal];

}

@end
