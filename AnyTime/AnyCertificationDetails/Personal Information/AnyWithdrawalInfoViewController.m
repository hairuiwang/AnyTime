//
//  AnyWithdrawalInfoViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyWithdrawalInfoViewController.h"
#import "AnyCertificationInfoCell.h"
@interface AnyWithdrawalInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *blow;

@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *oneArray;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *twoArray;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *threeArray;


@property (nonatomic, strong) NSString  *one_momentarily;
@property (nonatomic, strong) NSString  *two_momentarily;
@property (nonatomic, strong) NSString  *three_momentarily;
@end

@implementation AnyWithdrawalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneArray = [NSMutableArray array];
    self.twoArray = [NSMutableArray array];
    self.threeArray = [NSMutableArray array];
    
    self.blow = [NSMutableArray array];
    self.topImageView.image = [UIImage imageNamed:@"withdrawal-Info"];
    [self getData];
}
- (void)setupUI {
    [super setupUI];
    UIImageView *bgImageView = [UIImageView new];
    CGPoint stretchPoint = CGPointMake(100, 100); // 以 (100,100) 为基准点
    UIEdgeInsets insets = UIEdgeInsetsMake(stretchPoint.y, stretchPoint.x, stretchPoint.y, stretchPoint.x);
    UIImage *originalImage = [UIImage imageNamed:@"cer-bg-icon"];
    UIImage *resizableImage = [originalImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    bgImageView.image = resizableImage;
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-20);
    }];
    
    self.oneButton = [self createButton];
    [self.oneButton addTarget:self action:@selector(oneClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.twoButton = [self createButton];
    [self.twoButton addTarget:self action:@selector(twoClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.threeButton = [self createButton];
    [self.threeButton addTarget:self action:@selector(threeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.oneButton];
    [self.view addSubview:self.twoButton];
    [self.view addSubview:self.threeButton];
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(bgImageView.mas_top).offset(9);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(44);
    }];
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.twoButton.mas_left).offset(-6);
        make.top.mas_equalTo(bgImageView.mas_top).offset(9);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(44);
    }];
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.twoButton.mas_right).offset(6);
        make.top.mas_equalTo(bgImageView.mas_top).offset(9);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(44);
    }];
    self.oneButton.hidden = YES;
    self.twoButton.hidden = YES;
    self.threeButton.hidden = YES;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView new] ;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AnyCertificationInfoCell" bundle:nil] forCellReuseIdentifier:@"AnyCertificationInfoCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    self.tableView.layer.maskedCorners = kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    self.tableView.layer.cornerRadius = 12;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.twoButton.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-40);
    }];
    
    
}
- (void) getData {
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool fetchBindCardInfoWithHasn:@"0" kid:@"ssc931aRFScalk" success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        NSArray *excitedly = responseObject[@"excitedly"];
        for (int index = 0; index < excitedly.count; index++) {
            NSDictionary *dict = excitedly[index];
            [self.blow addObject:[NSMutableDictionary dictionaryWithDictionary:dict]];
            NSArray *excitedly = dict[@"excitedly"];
            
            if (index == 0) {
                self.oneButton.hidden = NO;
                [self.oneButton setTitle:[NSString stringWithFormat:@"%@",dict[@"handed"]] forState:(UIControlStateNormal)];
                self.one_momentarily = dict[@"aura"] ?: @"";
                [self.oneArray removeAllObjects];
                for (NSDictionary *item in excitedly) {
                    [self.oneArray addObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                }
            } else if (index == 1) {
                self.twoButton.hidden = NO;
                [self.twoButton setTitle:[NSString stringWithFormat:@"%@",dict[@"handed"]] forState:(UIControlStateNormal)];
                [self.twoArray removeAllObjects];
                self.two_momentarily = dict[@"aura"] ?: @"";
                for (NSDictionary *item in excitedly) {
                    [self.twoArray addObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                }
            } else if (index == 2) {
                self.threeButton.hidden = NO;
                [self.threeButton setTitle:[NSString stringWithFormat:@"%@",dict[@"handed"]] forState:(UIControlStateNormal)];
                self.three_momentarily = dict[@"aura"] ?: @"";
                [self.threeArray removeAllObjects];
                for (NSDictionary *item in excitedly) {
                    [self.threeArray addObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                }
            }
        }
        [self oneClick];
        
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
    }];
}
- (UIButton *)createButton {
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 22;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
    return button;
}
- (void) sureButtonClick {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    NSArray<NSMutableDictionary *> *resultArray;
    if (self.selectButton == self.oneButton) {
        resultArray = self.oneArray;
        [par setObject:@"1" forKey:@"top"];
        [par setObject:self.one_momentarily forKey:@"food"];
        
    } else if (self.selectButton == self.twoButton) {
        resultArray = self.twoArray;
        [par setObject:@"2" forKey:@"top"];
        [par setObject:self.two_momentarily forKey:@"food"];
    } else if (self.selectButton == self.threeButton) {
        resultArray = self.threeArray;
        [par setObject:self.three_momentarily forKey:@"top"];
        [par setObject:self.three_momentarily forKey:@"food"];
    }
    
    NSDictionary *rest = self.parameters[@"rest"];
    NSString *funny = rest[@"funny"];
    [par setObject:funny forKey:@"box"];
    
    for (NSDictionary * dict in resultArray) {
        NSString *momentarily = dict[@"momentarily"];
        NSString *kittens = dict[@"kittens"];
        if ([kittens isEqualToString:@"anytimel"]) {
            [par setObject:dict[@"longer"] ?: @"" forKey:momentarily];
        } else {
            [par setObject:dict[@"aura"] ?: @"" forKey:momentarily];
        }
    }
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool submitBindCardInfoWithParameters:par success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        self.endTime = [AnyDevHelper currentTimestamp];
        [AnyHttpTool reportRiskGate:funny commanded:@"8" agreed:@"" allowance:self.stateTime large:self.endTime father:@"dfsdfsdaflkdsafndslf" success:^(id  _Nonnull responseObject) {
        } failure:^(NSError * _Nonnull error) {
        }];
        [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.parameters from:self callback:^(NSDictionary * _Nullable result) {}];
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}
- (void)oneClick {
    NSLog(@"oneClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.oneButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
    [self.tableView reloadData];
}

- (void)twoClick {
    NSLog(@"twoClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.twoButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
    [self.tableView reloadData];
}

- (void)threeClick {
    NSLog(@"threeClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.threeButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectButton == self.oneButton) {
        return self.oneArray.count;
    } else if (self.selectButton == self.twoButton) {
        return self.twoArray.count;
    } else if (self.selectButton == self.threeButton) {
        return self.threeArray.count;
    }
    return 0;
}

// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyCertificationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyCertificationInfoCell" forIndexPath:indexPath];
    if (self.selectButton == self.oneButton) {
        NSMutableDictionary *dict = self.oneArray[indexPath.row];
        cell.titleLabel.text = dict[@"handed"] ?: @"";
        cell.textField.placeholder = dict[@"staying"] ?: @"";
        cell.textField.text =  dict[@"longer"] ?: @"";
        cell.isLeftImageView = NO;
        NSString *kittens = dict[@"kittens"];
        NSString *tongue = [NSString stringWithFormat:@"%@", dict[@"tongue"]];
        cell.textField.keyboardType = [tongue isEqualToString:@"1"] ? UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        if ([kittens isEqualToString:@"anytimel"]) {
            cell.isClick = NO;
            cell.textChangeHandler = ^(NSString * _Nonnull result) {
                dict[@"longer"] = result;
            };
        } else {
            cell.isClick = YES;
            cell.textChangeHandler = nil;
        }
        
    } else if (self.selectButton == self.twoButton) {
        NSMutableDictionary *dict = self.twoArray[indexPath.row];
        cell.titleLabel.text = dict[@"handed"] ?: @"";
        cell.textField.placeholder = dict[@"staying"] ?: @"";
        cell.textField.text =  dict[@"longer"] ?: @"";
        cell.isLeftImageView = NO;
        NSString *kittens = dict[@"kittens"];
        NSString *tongue = [NSString stringWithFormat:@"%@", dict[@"tongue"]];
        cell.textField.keyboardType = [tongue isEqualToString:@"1"] ? UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        if ([kittens isEqualToString:@"anytimel"]) {
            cell.isClick = NO;
            cell.textChangeHandler = ^(NSString * _Nonnull result) {
                dict[@"longer"] = result;
            };
        } else {
            cell.isClick = YES;
            cell.textChangeHandler = nil;
        }
        
    } else if (self.selectButton == self.threeButton) {
        NSMutableDictionary *dict = self.threeArray[indexPath.row];
        cell.titleLabel.text = dict[@"handed"] ?: @"";
        cell.textField.placeholder = dict[@"staying"] ?: @"";
        cell.textField.text =  dict[@"longer"] ?: @"";
        cell.isLeftImageView = NO;
        NSString *kittens = dict[@"kittens"];
        NSString *tongue = [NSString stringWithFormat:@"%@", dict[@"tongue"]];
        cell.textField.keyboardType = [tongue isEqualToString:@"1"] ? UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        if ([kittens isEqualToString:@"anytimel"]) {
            cell.isClick = NO;
            cell.textChangeHandler = ^(NSString * _Nonnull result) {
                dict[@"longer"] = result;
            };
        } else {
            cell.isClick = YES;
            cell.textChangeHandler = nil;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 %ld 行", (long)indexPath.row);
    if (self.selectButton == self.oneButton) {
        NSMutableDictionary *dict = self.oneArray[indexPath.row];
        NSString *kittens = dict[@"kittens"];
        if ([kittens isEqualToString:@"anytimek"]) {
            [self enumPopView:dict];
        }
    } else if (self.selectButton == self.twoButton) {
        NSMutableDictionary *dict = self.twoArray[indexPath.row];
        NSString *kittens = dict[@"kittens"];
        if ([kittens isEqualToString:@"anytimek"]) {
            [self enumPopView:dict];
        }
    } else if (self.selectButton == self.threeButton) {
        NSMutableDictionary *dict = self.threeArray[indexPath.row];
        NSString *kittens = dict[@"kittens"];
        if ([kittens isEqualToString:@"anytimek"]) {
            [self enumPopView:dict];
        }
    }
}

- (void)enumPopView:(NSMutableDictionary *)dict {
    NSArray *clicked = dict[@"clicked"] ?: @[];
    NSMutableArray<AnySelectModel *> *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in clicked) {
        AnySelectModel *model = [AnySelectModel new];
        model.title = [NSString stringWithFormat:@"%@", dict[@"groove"]];
        model.imageStr = dict[@"seems"] ?: @"";
        [dataArray addObject:model];
    }
    AnySelectPop *pop = [[AnySelectPop alloc]init];
    pop.dataSourceArray = dataArray;
    pop.isImage = YES;
    pop.selectHandler = ^(NSString * _Nonnull address, NSInteger index) {
        dict[@"longer"] = address;
        NSDictionary *dd = clicked[index];
        NSString *aura = [NSString stringWithFormat:@"%@", dd[@"aura"]];
        dict[@"aura"] = aura;
        [self.tableView reloadData];
    };
    pop.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pop animated:YES completion:^{
    }];
    pop.titleLabel.text = [NSString stringWithFormat:@"%@",dict[@"handed"]];
}
@end
