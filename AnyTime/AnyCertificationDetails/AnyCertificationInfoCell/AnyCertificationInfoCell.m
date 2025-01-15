//
//  AnyCertificationInfoCell.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyCertificationInfoCell.h"

@implementation AnyCertificationInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textField.textColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self.button setTitle:@"" forState:(UIControlStateNormal)];
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.button.hidden = YES;
    self.rightImageView = [UIImageView new];
    self.rightImageView.image = [UIImage imageNamed:@"right_arrow_icon"];
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textField.mas_centerY);
        make.right.mas_equalTo(self.textField.mas_right).offset(-5);
        make.width.height.mas_equalTo(14);
    }];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    self.rightImageView.hidden = YES;
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 44)];
    self.leftImageView = [UIImageView new];
    self.leftImageView.frame = CGRectMake(10, 4.5, 35, 35);
    [self.leftView addSubview:self.leftImageView];
    self.leftView.layer.masksToBounds = YES;
    self.textField.leftView = self.leftView;
    
    self.textField.text = @"11111";
}
- (void)textFieldDidChange:(UITextField *)textField {
    if (self.textChangeHandler) {
        self.textChangeHandler(textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    if (_isClick) {
        self.rightImageView.hidden = NO;
        self.textField.userInteractionEnabled = NO;
    } else {
        self.rightImageView.hidden = YES;
        self.textField.userInteractionEnabled = YES;
    }
}
- (void)setIsLeftImageView:(BOOL)isLeftImageView {
    _isLeftImageView = isLeftImageView;
    if (_isLeftImageView) {
        self.leftView.frame = CGRectMake(0, 0, 53, 44);
    } else {
        self.leftView.frame = CGRectMake(0, 0, 0, 0);
    }
}
@end
