//
//  AnyVerifyldentitySuccessfull01Cell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentitySuccessfull01Cell.h"

@implementation AnyVerifyldentitySuccessfull01Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"successful_icon_01"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(32);
        make.right.mas_equalTo(self.mas_right).offset(-32);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    self.iconImageView = imageView;
    
    UIImageView *desImageView = [UIImageView new];
    desImageView.image = [UIImage imageNamed:@"succ_icon"];
    [self addSubview:desImageView];
    [desImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(imageView);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
