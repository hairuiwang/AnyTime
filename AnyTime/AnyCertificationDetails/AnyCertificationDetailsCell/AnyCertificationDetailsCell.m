//
//  AnyCertificationDetailsCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyCertificationDetailsCell.h"

@interface AnyCertificationDetailsCell ()

@end

@implementation AnyCertificationDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupBgView];
    }
    return self;
}
- (void)setupBgView {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *img = [UIImage imageNamed:@"authentication_item_bg"];
    
    CGFloat width = SCREEN_WIDTH - 30;
    CGFloat height = SCALED_HEIGHT(img.size.width, img.size.height, width);
    
    bgImageView.image = img;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(height);
    }];
    
    self.stateImageView = [UIImageView new];
    self.stateImageView.image = [UIImage imageNamed:@"no-certified"];
    [self addSubview:self.stateImageView];
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(9);
        make.top.mas_equalTo(self.mas_top).offset(23);
        make.width.mas_equalTo(122);
        make.height.mas_equalTo(55);
    }];
    
    
    self.iconImageView = [UIImageView new];
    [self addSubview:self.iconImageView];
    
    self.iconImageView.backgroundColor = [UIColor clearColor];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).offset(-17);
        make.top.mas_equalTo(bgImageView.mas_top).offset(53);
        make.width.mas_equalTo(143);
        make.height.mas_equalTo(109);
    }];
    
    self.titleLabel = [AnyUIFactory labelWithText:@"Verify ldentity" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15] textAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgImageView.mas_left).offset(27);
        make.top.mas_equalTo(self.stateImageView.mas_bottom);
        make.right.mas_equalTo(self.iconImageView.mas_left);
    }];
     
    self.subLabel = [AnyUIFactory labelWithText:@"To accurately verify your identity and understand your basic information" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] textAlignment:(NSTextAlignmentLeft)];
    self.subLabel.numberOfLines = 0;
    [self addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgImageView.mas_left).offset(27);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
        make.right.mas_equalTo(self.iconImageView.mas_left);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setIsBy:(BOOL)isBy {
    _isBy = isBy;
    if (_isBy) {
        self.stateImageView.image = [UIImage imageNamed:@"certified"];
    } else {
        self.stateImageView.image = [UIImage imageNamed:@"no-certified"];
    }
}
@end
