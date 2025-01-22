//
//  AnySelectCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnySelectCell.h"
@interface AnySelectCell ()
@property (nonatomic, strong) UIView *bgView;


@end
@implementation AnySelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupLabel];
    }
    return self;
}
- (void)setupLabel {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.top.bottom.mas_equalTo(self);
        make.height.mas_equalTo(39);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView);
    }];
    
    self.iconImageView = [UIImageView new];
    [self.bgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-14);
        make.width.height.mas_equalTo(25);
    }];
}
- (void)setIsImage:(BOOL)isImage {
    _isImage = isImage;
    if (_isImage) {
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(25);
        }];
    } else {
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(0);
        }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setIsChose:(BOOL)isChose {
    _isChose = isChose;
    if (_isChose) {
        self.bgView.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
    } else {
        self.bgView.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
}
@end
