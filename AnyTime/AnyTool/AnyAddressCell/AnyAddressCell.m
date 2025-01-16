//
//  AnyAddressCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyAddressCell.h"
@interface AnyAddressCell ()

@end
@implementation AnyAddressCell

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
    self.titleLabel = [AnyUIFactory labelWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15 weight:(UIFontWeightHeavy)] textAlignment:(NSTextAlignmentCenter)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.layer.cornerRadius = 10;
    self.titleLabel.layer.masksToBounds = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.top.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setIsChose:(BOOL)isChose {
    _isChose = isChose;
    if (_isChose) {
        self.titleLabel.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
    } else {
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
}
@end
