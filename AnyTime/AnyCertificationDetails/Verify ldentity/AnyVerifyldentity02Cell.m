//
//  AnyVerifyldentity02Cell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentity02Cell.h"


@interface AnyVerifyldentity02Cell ()
@end

@implementation AnyVerifyldentity02Cell

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
    
    self.bgImageView = [UIImageView new];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setImage:(UIImage *)image {
    _image = image;
    CGFloat width = SCREEN_WIDTH - 30;
    CGFloat height = SCALED_HEIGHT(_image.size.width, _image.size.height, width);
    self.bgImageView.image = _image;
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
@end
