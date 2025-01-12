//
//  AnyTimeCustomTextField.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, AnyTimeCustomTextFieldType) {
    AnyTimeCustomTextFieldTypePhone,
    AnyTimeCustomTextFieldTypeCode,
    AnyTimeCustomTextFieldTypeNormal
};


typedef void (^TextFieldDidBeginEditingBlock)(void);
typedef void (^TextFieldDidEndEditingBlock)(void);
typedef void (^TextFieldDidChangeBlock)(NSString *text);
typedef void (^CodeButtonTappedBlock)(void);


@interface AnyTimeCustomTextField : UIView

@property (nonatomic, copy) TextFieldDidBeginEditingBlock textFieldDidBeginEditingBlock;
@property (nonatomic, copy) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;
@property (nonatomic, copy) TextFieldDidChangeBlock textFieldDidChangeBlock;
@property (nonatomic, copy) CodeButtonTappedBlock codeButtonTapped;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, assign) AnyTimeCustomTextFieldType type;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSString *placeholderText;
@property (nonatomic, assign) UIKeyboardType keyboardType; 


- (instancetype)initWithType:(AnyTimeCustomTextFieldType)type
                  borderWidth:(CGFloat)borderWidth
                  cornerRadius:(CGFloat)cornerRadius
                  borderColor:(UIColor *)borderColor
                  placeholder:(NSString *)placeholder
                  keyboardType:(UIKeyboardType)keyboardType
                   maxLength:(NSInteger)maxLength
                     hint:(NSString *)hint;


@end

NS_ASSUME_NONNULL_END
