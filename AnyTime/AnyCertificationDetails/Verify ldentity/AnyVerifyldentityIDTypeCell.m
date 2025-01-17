//
//  AnyVerifyldentityIDTypeCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentityIDTypeCell.h"

@interface AnyVerifyldentityIDTypeCell ()
@property (nonatomic, strong) UIView *bgView;
@end

@implementation AnyVerifyldentityIDTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.borderColor = [UIColor blackColor].CGColor    ;
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(14);
        make.right.mas_equalTo(self.mas_right).offset(-14);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.height.mas_equalTo(44);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = HEXCOLOR(0xDEDEDE);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)setIsChose:(BOOL)isChose {
    _isChose = isChose;
    if (_isChose) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.bgView.backgroundColor = HEXCOLOR(0xFD761F);
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
}
@end
