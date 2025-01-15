//
//  AnyVerifyldentityIDTypeViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentityIDTypeViewController.h"
#import "AnyVerifyldentityIDTypeCell.h"
@interface AnyVerifyldentityIDTypeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *openDict;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation AnyVerifyldentityIDTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openDict = [NSMutableDictionary dictionary];
    self.selectArray = [NSMutableArray array];
    [self.openDict setObject:@"0" forKey:@"0"];
    [self.openDict setObject:@"0" forKey:@"1"];
    [self.openDict setObject:@"0" forKey:@"2"];
    [self.openDict setObject:@"0" forKey:@"3"];
    [self.openDict setObject:@"0" forKey:@"4"];
    self.navigationItem.title = @"Verify ldentity";
}

- (void)setupUI {
    [super setupUI];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.backgroundColor = [UIColor blackColor];
    tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 44);
    UILabel *tableHeaderLabel = [UILabel new];
    tableHeaderLabel.text = @"Select an id to verify your identity";
    tableHeaderLabel.font = [UIFont boldSystemFontOfSize:15];
    tableHeaderLabel.textColor = [UIColor whiteColor];
    [tableHeaderView addSubview:tableHeaderLabel];
    [tableHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableHeaderView);
        make.centerY.mas_equalTo(tableHeaderView);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnyVerifyldentityIDTypeCell class] forCellReuseIdentifier:@"AnyVerifyldentityIDTypeCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    self.tableView.layer.maskedCorners = kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    self.tableView.layer.cornerRadius = 12;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.borderWidth = 1;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-20);
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"%ld", section];
    NSString *number = self.openDict[key];
    if ([number isEqualToString:@"0"]) {
        return 0;
    } else {
        return 5;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = @"Recommended lD Type";
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    headerLabel.textColor = [UIColor blackColor];
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).offset(15);
        make.centerY.mas_equalTo(headerView.mas_centerY);
    }];
    NSString *key = [NSString stringWithFormat:@"%ld", section];
    NSString *number = self.openDict[key];
    UIImageView *iconImageView = [UIImageView new];
    if ([number isEqualToString:@"0"]) {
        iconImageView.image = [UIImage imageNamed:@"down_icon"];
    } else {
        iconImageView.image = [UIImage imageNamed:@"up_icon"];
    }
    [headerView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView.mas_right).offset(-14);
        make.centerY.mas_equalTo(headerView.mas_centerY);
    }];
    UIButton *button = [UIButton new];
    button.tag = section;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(openClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView);
    }];
    return headerView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyVerifyldentityIDTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyVerifyldentityIDTypeCell" forIndexPath:indexPath];
    if (self.indexPath == indexPath) {
        cell.isChose = true;
    } else {
        cell.isChose = NO;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 %ld 行", (long)indexPath.row);
    if (self.indexPath == indexPath) {
        self.indexPath = nil;
    } else {
        self.indexPath = indexPath;
    }
    [tableView reloadData];
}
- (void)openClick:(UIButton *)button {
    NSString *key = [NSString stringWithFormat:@"%ld", button.tag];
    NSString *number = self.openDict[key];
    if ([number isEqualToString:@"0"]) {
        [self.openDict setObject:@"1" forKey:key];
    } else {
        [self.openDict setObject:@"0" forKey:key];
    }
    [self.tableView reloadData];
}
- (void) sureButtonClick {
    if (self.indexPath == nil) {
        NSLog(@"请选择");
        return;
    }
    
}
@end
