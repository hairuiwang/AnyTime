//
//  AnyTimeCustomTextField.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//
#import "AnyTimeCustomTextField.h"

@interface AnyTimeCustomTextField () <UITextFieldDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, strong) NSString *inputHint;

@end

@implementation AnyTimeCustomTextField

- (instancetype)initWithType:(AnyTimeCustomTextFieldType)type
                  borderWidth:(CGFloat)borderWidth
                  cornerRadius:(CGFloat)cornerRadius
                  borderColor:(UIColor *)borderColor
                  placeholder:(NSString *)placeholder
                  keyboardType:(UIKeyboardType)keyboardType
                   maxLength:(NSInteger)maxLength
                     hint:(NSString *)hint {
    self = [super init];
    if (self) {
        self.type = type;
        self.borderWidth = borderWidth;
        self.cornerRadius = cornerRadius;
        self.borderColor = borderColor;
        self.placeholderText = placeholder;
        self.keyboardType = keyboardType;
        self.maxLength = maxLength; // 设置最大长度
        self.inputHint = hint;     // 设置错误提示
        
        [self setupViews];
    }
    return self;
}


- (void)setupViews
{
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    
    // 设置文本框
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = self.placeholderText;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = [UIColor blackColor];
    self.textField.layer.cornerRadius = self.cornerRadius;
    self.textField.layer.masksToBounds = YES;
    self.textField.delegate = self;  // 设置代理
    self.textField.keyboardType = self.keyboardType;  // 设置键盘类型
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.textField];
    
    switch (self.type) {
        case AnyTimeCustomTextFieldTypePhone: {
            [self setupPhoneTextField];
            break;
        }
        case AnyTimeCustomTextFieldTypeCode: {
            [self setupCodeTextField];
            break;
        }
        case AnyTimeCustomTextFieldTypeNormal: {
            [self setupNormalTextField];
            break;
        }
    }
}

- (void)setupPhoneTextField {
    [self layoutIfNeeded];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(50);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    UILabel *prefixLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 40, 44)];
    prefixLabel.text = @"+63";
    prefixLabel.textColor = [UIColor blackColor];
    prefixLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:prefixLabel];
    
    [prefixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(50);
    }];
    
    self.textField.placeholder = @"Ingresar número móvil";
}

- (void)setupCodeTextField {
    [self layoutIfNeeded];

    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeButton.layer.cornerRadius = 22;
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.backgroundColor = [UIColor blackColor];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"Code"];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];
    [self.codeButton setAttributedTitle:attrString forState:UIControlStateNormal];
       
    [self.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(44);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    [self.codeButton addTarget:self action:@selector(startCountdown) forControlEvents:UIControlEventTouchUpInside];
    
    self.textField.placeholder = @"Please enter verification code";

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.codeButton.mas_left).offset(-10);
    }];
}

- (void)setupNormalTextField {
    self.textField.placeholder = self.placeholderText;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = [UIColor blackColor];
}

- (void)startCountdown {
    self.countdown = 30;
    [self.codeButton setEnabled:NO];
    [self.codeButton setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
    
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
    
    // 返回事件
    if (self.codeButtonTapped) {
        self.codeButtonTapped();
    }
}

- (void)updateCountdown {
    self.countdown--;
    if (self.countdown <= 0) {
        [self.timer invalidate];
        [self.codeButton setEnabled:YES];
        [self.codeButton setBackgroundColor:[UIColor blackColor]];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"Code"];
        [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];
        [self.codeButton setAttributedTitle:attrString forState:UIControlStateNormal];
    }
    else
    {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lds", (long)self.countdown]];
        [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];
        [self.codeButton setAttributedTitle:attrString forState:UIControlStateNormal];
    }
}

#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (self.textFieldDidBeginEditingBlock) {
        self.textFieldDidBeginEditingBlock();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock();
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
       

       if (newText.length > self.maxLength) {
//           [self showAlertWithMessage:self.inputHint];
           NSLog(@"inputHint === %@",self.inputHint);
           return NO;
       }
       
    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock(textField.text);
    }
    
    return YES;
}

@end
