//
//  AnyPersonalInforViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyPersonalInforViewController.h"
#import "AnyCertificationInfoCell.h"

@interface AnyPersonalInforViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *excitedly;
@end

@implementation AnyPersonalInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.excitedly = [NSMutableArray array];
    if ([self.type isEqualToString:@"1"]) {
        self.topImageView.image = [UIImage imageNamed:@"personal-info"] ;
    } else {
        self.topImageView.image = [UIImage imageNamed:@"work-Information"] ;
    }
    
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
    self.tableView.layer.borderColor = [UIColor clearColor].CGColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.borderWidth = 1;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-40);
    }];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-20);
    }];
}

- (void) getData {
    NSDictionary *rest = self.parameters[@"rest"];
    NSString *funny = rest[@"funny"];
    [AnyTimeHUD showLoadingHUD];
    if ([self.type isEqualToString:@"1"]) {
        // 个人
        [AnyHttpTool fetchUserInfoWithBox:funny success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            NSArray *excitedly = responseObject[@"excitedly"] ?: @[];
            [self.excitedly removeAllObjects];
            for (NSDictionary *dict in excitedly) {
                NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dict];
                [self.excitedly addObject:data];
            }
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];
    } else {
        [AnyHttpTool fetchWorkInfoWithBox:funny success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            NSArray *excitedly = responseObject[@"excitedly"] ?: @[];
            [self.excitedly removeAllObjects];
            for (NSDictionary *dict in excitedly) {
                NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dict];
                [self.excitedly addObject:data];
            }
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];

    }
}

- (void) sureButtonClick {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in self.excitedly) {
        NSString *kittens = dict[@"kittens"];
        if ([kittens isEqualToString:@"anytimek"]) {
            [par setObject:dict[@"aura"] forKey:dict[@"momentarily"]];
        } else {
            [par setObject:dict[@"longer"] forKey:dict[@"momentarily"]];
        }
    }
    NSDictionary *rest = self.parameters[@"rest"];
    NSString *funny = rest[@"funny"];
    [par setObject:funny forKey:@"box"];
    [AnyTimeHUD showLoadingHUD];
    if ([self.type isEqualToString:@"1"]) {
        [AnyHttpTool saveUserInfoWithParameters:par success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            self.endTime = [AnyDevHelper currentTimestamp];
            [AnyHttpTool reportRiskGate:funny commanded:@"5" agreed:@"" allowance:self.stateTime large:self.endTime father:@"csfkdsalfhsldaf" success:^(id  _Nonnull responseObject) {
            } failure:^(NSError * _Nonnull error) {
            }];
            [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.parameters from:self callback:^(NSDictionary * _Nullable result) { }];
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];
    } else {
        [AnyHttpTool saveWorkInfoWith:par success:^(id  _Nonnull responseObject) {
            [AnyTimeHUD hideHUD];
            self.endTime = [AnyDevHelper currentTimestamp];
            [AnyHttpTool reportRiskGate:funny commanded:@"6" agreed:@"" allowance:self.stateTime large:self.endTime father:@"csfkdsalfhsldaf" success:^(id  _Nonnull responseObject) {
            } failure:^(NSError * _Nonnull error) {
            }];
            [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.parameters from:self callback:^(NSDictionary * _Nullable result) { }];
        } failure:^(NSError * _Nonnull error) {
            [AnyTimeHUD hideHUD];
            [AnyTimeHUD showTextWithText:error.localizedDescription];
        }];
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.excitedly.count;
}

// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyCertificationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyCertificationInfoCell" forIndexPath:indexPath];
    NSMutableDictionary *dict = self.excitedly[indexPath.row];
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
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 %ld 行", (long)indexPath.row);
    NSMutableDictionary *dict = self.excitedly[indexPath.row];
    NSString *kittens = dict[@"kittens"];
    if ([kittens isEqualToString:@"anytimek"]) {
        [self enumPopView:dict];
    } else if ([kittens isEqualToString:@"anytimem"]) {
        [self citySelect:dict];
    }
}
- (void)enumPopView:(NSMutableDictionary *)dict {
    NSArray *clicked = dict[@"clicked"] ?: @[];
    NSMutableArray<AnySelectModel *> *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in clicked) {
        AnySelectModel *model = [AnySelectModel new];
        model.title = [NSString stringWithFormat:@"%@", dict[@"groove"]];
        [dataArray addObject:model];
    }
    AnySelectPop *pop = [[AnySelectPop alloc]init];
    pop.dataSourceArray = dataArray;
    
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
- (void)citySelect:(NSMutableDictionary *)dict {
    AnyAddressPop *toVC = [[AnyAddressPop alloc]init];
    toVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    toVC.addressHandler = ^(NSString * _Nonnull address) {
        dict[@"longer"] = address;
        [self.tableView reloadData];
    };
    [self presentViewController:toVC animated:YES completion:^{
    }];
}
@end
