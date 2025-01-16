//
//  AnyAddressPop.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyAddressPop.h"
#import "AnyAddressCell.h"
@interface AnyAddressPop ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *selectTitleDict;

@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *twoArray;
@property (nonatomic, strong) NSArray *threeArray;

@property (nonatomic, strong) NSString *level;
@end

@implementation AnyAddressPop

- (void)viewDidLoad {
    [super viewDidLoad];
    self.level = @"1";
    self.selectTitleDict = [NSMutableDictionary dictionary];
    [self.selectTitleDict setObject:@"" forKey:@"1"];
    [self.selectTitleDict setObject:@"" forKey:@"2"];
    [self.selectTitleDict setObject:@"" forKey:@"3"];
    self.view.backgroundColor = HEXCOLORA(0x000000, 0.4);
    NSDictionary *data = [AnyRouter sharedInstance].cityData;
    NSArray *citys = data[@"blow"];
    if ([citys isKindOfClass:[NSArray class]]) {
        self.cityArray = citys;
    } else {
        self.cityArray = @[];
    }
    
    [self setupUI];
    [self buttonRecovery];
    
}
- (void)setupUI {
    self.bgImageView = [UIImageView new];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"info-confirm-icon"];
    CGFloat height = SCALED_HEIGHT(image.size.width, image.size.height, SCREEN_WIDTH - 38*2);
    CGFloat bottomHeight = SCALED_HEIGHT(image.size.width, 261, SCREEN_WIDTH - 38*2);
    CGFloat bottomHeightTopSpace = SCALED_HEIGHT(image.size.width, 200, SCREEN_WIDTH - 38*2);
    
    self.bgImageView.image = image;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38);
        make.right.mas_equalTo(self.view.mas_right).offset(-38);
        make.height.mas_equalTo(height);
        make.centerY.mas_equalTo(self.view);
    }];
    UILabel *titleLabel = [AnyUIFactory labelWithText:@"Select Address" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15] textAlignment:(NSTextAlignmentCenter)];
    [self.bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(13);
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(82);
    }];
    
    
    
    
    self.oneButton = [self createButton];
    self.oneButton.tag = 1;
    self.twoButton = [self createButton];
    self.twoButton.tag = 2;
    self.threeButton = [self createButton];
    self.threeButton.tag = 3;
    [self.view addSubview:self.oneButton];
    [self.view addSubview:self.twoButton];
    [self.view addSubview:self.threeButton];
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgImageView);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(-bottomHeightTopSpace);
        make.height.mas_equalTo(17);
    }];
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.twoButton);
        make.right.mas_equalTo(self.twoButton.mas_left).offset(-19);
        make.height.mas_equalTo(17);
    }];
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.twoButton);
        make.left.mas_equalTo(self.twoButton.mas_right).offset(19);
        make.height.mas_equalTo(17);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnyAddressCell class] forCellReuseIdentifier:@"AnyAddressCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left);
        make.right.mas_equalTo(self.bgImageView.mas_right);
        make.top.mas_equalTo(self.twoButton.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom);
    }];
    
    UIButton *confirmButton = [AnyUIFactory buttonWithTitle:@"Confirm" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(confirmButtonClick)];
    [self.view addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(13);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *closeButton = [UIButton new];
    [closeButton setImage:[UIImage imageNamed:@"close-icon"] forState:(UIControlStateNormal)];
    [closeButton addTarget:self action:@selector(closeTouchClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(confirmButton.mas_bottom).offset(15);
    }];
}
- (UIButton *)createButton {
    UIButton *button = [UIButton new];
    [button setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setTitleColor:HEXCOLOR(0xFC902E) forState:(UIControlStateSelected)];
    button.titleLabel.font = [UIFont systemFontOfSize:12 weight:(UIFontWeightMedium)];
    [button addTarget:self action:@selector(cityButtonTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
- (void)cityButtonTouch:(UIButton *)button {
    NSArray *array;
    if (button.tag == 1) {
        array = self.cityArray;
    } else if (button.tag == 2) {
        array = self.twoArray;
    } else if (button.tag == 3) {
        array = self.threeArray;
    }
    if (array.count == 0) {
        return;
    }
    
    self.oneButton.selected = NO;
    self.twoButton.selected = NO;
    self.threeButton.selected = NO;
    button.selected = YES;
    
    NSString *key = [NSString stringWithFormat:@"%ld", button.tag];
    NSString *title = self.selectTitleDict[key];
    if (title.length > 0) {
        
    }
    self.level = key;
    [self.tableView reloadData];
}
- (void) closeTouchClick {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}
- (void) confirmButtonClick {
    NSString *oneTitle = self.selectTitleDict[@"1"];
    NSString *twoTitle = self.selectTitleDict[@"2"];
    NSString *threeTitle = self.selectTitleDict[@"3"];
    if (oneTitle.length > 0 && twoTitle.length > 0 && threeTitle.length > 0) {
        if (self.addressHandler) {
            NSString *address = [NSString stringWithFormat:@"%@-%@-%@",oneTitle, twoTitle, threeTitle];
            self.addressHandler(address);
            [self dismissViewControllerAnimated:true completion:^{
            }];
        }
    } else {
        
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.level isEqualToString:@"1"]) {
        return  self.cityArray.count;
    } else if ([self.level isEqualToString:@"2"]) {
        return  self.twoArray.count;
    } else if ([self.level isEqualToString:@"3"]) {
        return  self.threeArray.count;
    }
    return 0;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyAddressCell" forIndexPath:indexPath];
    if ([self.level isEqualToString:@"1"]) {
        NSDictionary *dict = self.cityArray[indexPath.row];
        NSString *text = dict[@"groove"];
        NSString *oneTitel = self.selectTitleDict[@"1"];
        cell.titleLabel.text = text;
        if ([text isEqualToString:oneTitel]) {
            cell.isChose = YES;
        } else {
            cell.isChose = NO;
        }
    } else if ([self.level isEqualToString:@"2"]) {
        NSDictionary *dict = self.twoArray[indexPath.row];
        NSString *text = dict[@"groove"];
        NSString *twoTitel = self.selectTitleDict[@"2"];
        cell.titleLabel.text = text;
        if ([text isEqualToString:twoTitel]) {
            cell.isChose = YES;
        } else {
            cell.isChose = NO;
        }
    } else if ([self.level isEqualToString:@"3"]) {
        NSDictionary *dict = self.threeArray[indexPath.row];
        NSString *text = dict[@"groove"];
        NSString *threeTitel = self.selectTitleDict[@"3"];
        cell.titleLabel.text = text;
        if ([text isEqualToString:threeTitel]) {
            cell.isChose = YES;
        } else {
            cell.isChose = NO;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.level isEqualToString:@"1"]) {
        NSDictionary *dict = self.cityArray[indexPath.row];
        NSString *text = dict[@"groove"];
        [self.selectTitleDict setObject:text forKey:@"1"];
        [self.oneButton setTitle:text forState:(UIControlStateNormal)];
        self.twoArray = dict[@"blow"];
        self.threeArray = @[];
        self.level = @"2";
        [self buttonRecovery];
    } else if ([self.level isEqualToString:@"2"]) {
        NSDictionary *dict = self.twoArray[indexPath.row];
        NSString *text = dict[@"groove"];
        [self.selectTitleDict setObject:text forKey:@"2"];
        [self.twoButton setTitle:text forState:(UIControlStateNormal)];
        self.threeArray = dict[@"blow"];
        
        self.level = @"3";
        [self buttonRecovery];
    } else if ([self.level isEqualToString:@"3"]) {
        NSDictionary *dict = self.threeArray[indexPath.row];
        NSString *text = dict[@"groove"];
        [self.selectTitleDict setObject:text forKey:@"3"];
        [self.threeButton setTitle:text forState:(UIControlStateNormal)];
    }
}
- (void)buttonRecovery {
    if ([self.level isEqualToString:@"1"]) {
        [self.oneButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.twoButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.threeButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.selectTitleDict setObject:@"" forKey:@"1"];
        [self.selectTitleDict setObject:@"" forKey:@"2"];
        [self.selectTitleDict setObject:@"" forKey:@"3"];
        self.oneButton.selected = YES;
        self.twoButton.selected = NO;
        self.threeButton.selected = NO;
    } else if ([self.level isEqualToString:@"2"]) {
        [self.twoButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.threeButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.selectTitleDict setObject:@"" forKey:@"2"];
        [self.selectTitleDict setObject:@"" forKey:@"3"];
        self.oneButton.selected = NO;
        self.twoButton.selected = YES;
        self.threeButton.selected = NO;
    } else if ([self.level isEqualToString:@"3"]) {
        [self.oneButton setTitle:@"Seleccionar" forState:(UIControlStateNormal)];
        [self.selectTitleDict setObject:@"" forKey:@"3"];
        self.oneButton.selected = NO;
        self.twoButton.selected = NO;
        self.threeButton.selected = YES;
    }
    [self.tableView reloadData];
}
@end
