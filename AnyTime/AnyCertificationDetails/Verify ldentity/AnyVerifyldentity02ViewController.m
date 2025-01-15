//
//  AnyVerifyldentity02ViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentity02ViewController.h"
#import "AnyVerifyldentity02Cell.h"

@interface AnyVerifyldentity02ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AnyVerifyldentity02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Verify ldentity";
    
}

- (void)setupUI {
    [super setupUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnyVerifyldentity02Cell class] forCellReuseIdentifier:@"AnyVerifyldentity02Cell"];
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
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor blackColor];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 44);
    UILabel *tableHeaderLabel = [UILabel new];
    tableHeaderLabel.text = section == 0 ? self.type:   @"Please confrm your identity information";
    tableHeaderLabel.font = [UIFont boldSystemFontOfSize:15];
    tableHeaderLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:tableHeaderLabel];
    [tableHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.centerY.mas_equalTo(headerView);
    }];
    
    return headerView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyVerifyldentity02Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyVerifyldentity02Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.bgImageView.image = [UIImage imageNamed:@"description02"];
    } else {
        cell.bgImageView.image = [UIImage imageNamed:@"description01"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) sureButtonClick {
}

@end
