//
//  AnyTimeCustomPopupView.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeCustomPopupView.h"

@interface AnyTimeCustomPopupView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *checkboxButton;
@property (nonatomic, assign) BOOL isChecked;


//date select
@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) NSMutableArray *days;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *years;

@property (nonatomic, strong) UIButton * cameraBtn;
@property (nonatomic, strong) UIButton * photosBtn;

@end

@implementation AnyTimeCustomPopupView

- (instancetype)initGoOutAccountWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)initCancellationAccountWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupCancellationConstraints];
    }
    return self;
}

- (instancetype)initNoNetWorkWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupNoNetWork];
    }
    return self;
}

- (instancetype)initDateSelectionWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupDateSelection];
    }
    return self;
}

- (instancetype)initPhotoGraphWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPhotoGraph];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = rgba(0, 0, 0, 0.7);
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor grayColor];
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.numberOfLines = 0;
    [self addSubview:self.descriptionLabel];
    
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.firstButton setBackgroundColor:[UIColor blackColor]];
    [self.firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.firstButton.layer.cornerRadius = 22;
    self.firstButton.clipsToBounds = YES;
    [self addSubview:self.firstButton];

    self.secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondButton.layer.borderColor = rgba(0, 0, 0, 1).CGColor;
    self.secondButton.layer.borderWidth = 1;
    [self.secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.secondButton.layer.cornerRadius = 22;
    self.secondButton.clipsToBounds = YES;
   
    [self addSubview:self.secondButton];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"anytime_alertcancel"] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
}

- (void)setupConstraints
{
    CGFloat padding = 15;
    
    [self.firstButton addTarget:self action:@selector(firstButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    [self.secondButton addTarget:self action:@selector(secondButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(150);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@300);
        make.height.equalTo(@276);
    }];
      
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@30);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-30);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstButton.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.width.height.equalTo(@20);
    }];
    
}

- (void)setupCancellationConstraints
{
    CGFloat padding = 15;
    
    [self.firstButton addTarget:self action:@selector(firstCButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    [self.secondButton addTarget:self action:@selector(secondCButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(150);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@300);
        make.height.equalTo(@353);
    }];
      
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@30);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(190);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    self.checkboxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkboxButton setImage:[UIImage imageNamed:@"anytime_login_unse"] forState:UIControlStateNormal];
    [self.checkboxButton setImage:[UIImage imageNamed:@"anytime_login_se"] forState:UIControlStateSelected];
    [self.checkboxButton addTarget:self action:@selector(toggleCheckboxState) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkboxButton];
    [self.checkboxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descriptionLabel.mas_left).offset(22);
        make.height.width.mas_equalTo(20);
        make.top.mas_equalTo(self.descriptionLabel.mas_bottom);
    }];
    
    UILabel * tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"I have read and agree to the above";
    tipsLabel.font = PFSCFont(12);
    tipsLabel.textColor = rgba(255, 134, 2, 1);
    [self addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkboxButton.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.checkboxButton.mas_centerY);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstButton.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.width.height.equalTo(@20);
    }];
    
}

- (void)setupNoNetWork
{
    CGFloat padding = 15;
 
    [self.firstButton addTarget:self action:@selector(turningOnButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    [self.secondButton addTarget:self action:@selector(secondButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@300);
        make.height.equalTo(@238);
    }];
   
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(30);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-30);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.secondButton.mas_top).offset(-10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
}

- (void)setupDateSelection
{
    CGFloat padding = 15;
 
    [self.firstButton addTarget:self action:@selector(firstButtonDateSelect) forControlEvents:UIControlEventTouchUpInside];

    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@300);
        make.height.equalTo(@395);
    }];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@44);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.width.height.equalTo(@20);
    }];
    
    self.months = [self generateArrayFrom:1 to:12];
    self.years = [self generateArrayFrom:1900 to:9999];
    self.days = [NSMutableArray arrayWithArray:[self generateArrayFrom:1 to:31]];

    self.datePicker = [[UIPickerView alloc] init];
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
    
    [self addSubview:self.datePicker];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(180);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-padding);
    }];
    
    UIButton *confirmButton = [AnyUIFactory buttonWithTitle:@"Confirm" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(dateConfirmButtonClick)];
    [self addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(50);
        make.right.mas_equalTo(self.mas_right).offset(-50);
        make.top.mas_equalTo(self.backgroundImageView.mas_bottom).offset(13);
        make.height.mas_equalTo(44);
    }];
 
}

- (void)firstButtonDateSelect
{
    NSInteger selectedDayIndex = [self.datePicker selectedRowInComponent:0];
    NSInteger selectedMonthIndex = [self.datePicker selectedRowInComponent:1];
    NSInteger selectedYearIndex = [self.datePicker selectedRowInComponent:2];

    NSString *selectedDay = self.days[selectedDayIndex];
    NSString *selectedMonth = self.months[selectedMonthIndex];
    NSString *selectedYear = self.years[selectedYearIndex];

    NSLog(@"date: %@-%@-%@", selectedDay, selectedMonth, selectedYear);
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@-%@", selectedDay, selectedMonth, selectedYear];
    if (self.dateSelectAction) {
        self.dateSelectAction(dateStr);
    }
}

- (NSArray *)generateArrayFrom:(NSInteger)start to:(NSInteger)end {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = start; i <= end; i++) {
        [array addObject:[NSString stringWithFormat:@"%02ld", (long)i]];
    }
    return [array copy];
}


- (void)updateDaysForMonth:(NSInteger)month year:(NSInteger)year {
    NSInteger daysInMonth;

    if (month == 2) {
        BOOL isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        daysInMonth = isLeapYear ? 29 : 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        daysInMonth = 30;
    } else {
        daysInMonth = 31;
    }

    [self.days removeAllObjects];
    [self.days addObjectsFromArray:[self generateArrayFrom:1 to:daysInMonth]];
    [self.datePicker reloadComponent:0];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.days.count;
    } else if (component == 1) {
        return self.months.count;
    } else {
        return self.years.count;
    }
}
- (void)dateConfirmButtonClick {
    if (self.dateSelectAction) {
        NSInteger selectedRow1 = [self.datePicker selectedRowInComponent:0];
        NSInteger selectedRow2 = [self.datePicker selectedRowInComponent:1];
        NSInteger selectedRow3 = [self.datePicker selectedRowInComponent:2];

        NSString *value1 = self.days[selectedRow1];
        NSString *value2 = self.months[selectedRow2];
        NSString *value3 = self.years[selectedRow3];
        self.dateSelectAction([NSString stringWithFormat:@"%@-%@-%@",value1, value2, value3]);
        
        [self dismiss];
    }
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.days[row];
    } else if (component == 1) {
        return self.months[row];
    } else {
        return self.years[row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
    if (component == 1 || component == 2)
    {
        NSInteger selectedMonth = [self.months[[pickerView selectedRowInComponent:1]] intValue];
        NSInteger selectedYear = [self.years[[pickerView selectedRowInComponent:2]] intValue];
        [self updateDaysForMonth:selectedMonth year:selectedYear];
    }
}


- (void)setupPhotoGraph
{
    CGFloat padding = 20;
    self.backgroundColor = rgba(0, 0, 0, 0.7);
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@300);
        make.height.equalTo(@330);
    }];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
    }];
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraBtn setImage:[UIImage imageNamed:@"anytime_alert_camera"] forState:UIControlStateNormal];
    [self.cameraBtn setTitle:@"Photograph" forState:UIControlStateNormal];
    [self.cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cameraBtn.titleLabel.font = PFSCFont(10);
    [self.cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.cameraBtn];
    
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundImageView.mas_left).offset(30);
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-60);
        make.width.equalTo(@100);
        make.height.equalTo(@58);
    }];
    
    self.photosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.photosBtn setImage:[UIImage imageNamed:@"anytime_alert_photos"] forState:UIControlStateNormal];
    [self.photosBtn setTitle:@"Photo Album" forState:UIControlStateNormal];
    [self.photosBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.photosBtn.titleLabel.font = PFSCFont(10);
    [self.photosBtn addTarget:self action:@selector(photosBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.photosBtn];
    
    [self.photosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-30);
        make.bottom.equalTo(self.backgroundImageView.mas_bottom).offset(-60);
        make.width.equalTo(@100);
        make.height.equalTo(@58);
    }];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"anytime_alertcancel"] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
    [self.closeButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.backgroundImageView.mas_bottom).offset(10);
    }];
    
}

- (void)cameraBtnClick
{
    [self dismiss] ;
    if (self.camcerButtonAction) {
        self.camcerButtonAction();
       
    }
}

- (void)photosBtnClick
{
    [self dismisscompletion:^{
        if (self.photosButtonAction) {
            self.photosButtonAction();
        }
    }];
    
}

-(void)layoutSubviews
{
    [self.cameraBtn layoutButtonWithEdgeStyle:ButtonEdgeStyleImageTop spacing:10];
    [self.photosBtn layoutButtonWithEdgeStyle:ButtonEdgeStyleImageTop spacing:10];

}

#pragma mark - Setter Methods

- (void)toggleCheckboxState {
    self.isChecked = !self.isChecked;
    self.checkboxButton.selected = self.isChecked;
}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setDescriptionText:(NSString *)descriptionText {
    self.descriptionLabel.text = descriptionText;
}

- (void)setFirstButtonTitle:(NSString *)firstButtonTitle {
    [self.firstButton setTitle:firstButtonTitle forState:UIControlStateNormal];
}

- (void)setSecondButtonTitle:(NSString *)secondButtonTitle {
    [self.secondButton setTitle:secondButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Show and Dismiss Methods

- (void)showInView:(UIView *)parentView {
    [parentView addSubview:self];
    self.frame = parentView.bounds;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)dismisscompletion:(void (^ __nullable)(void))completion {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        completion();
    }];
}

#pragma mark - Button Actions

- (void)turningOnButtonTapped
{
    if (self.firstButtonAction) {
        self.firstButtonAction();
    }
}

- (void)firstButtonTapped {
    if (self.firstButtonAction) {
        self.firstButtonAction();
    }
    [self dismiss];
}

- (void)secondButtonTapped {
    if (self.secondButtonAction) {
        self.secondButtonAction();
    }
    [self dismiss];
}

- (void)firstCButtonTapped {
    if (self.isChecked == NO) {
        NSLog(@"no select");
    }
    if (self.firstButtonAction) {
        self.firstButtonAction();
    }
    [self dismiss];
}

- (void)secondCButtonTapped {
    if (self.isChecked == NO) {
        NSLog(@"no select");
    }
    if (self.secondButtonAction) {
        self.secondButtonAction();
    }
    [self dismiss];
}

- (void)closeButtonTapped {
    if (self.closeAction) {
        self.closeAction();
    }
    [self dismiss];
}


@end
