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
@end

@implementation AnyWithdrawalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (UIButton *)createButton {
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 22;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
    return button;
}

- (void)oneClick {
    NSLog(@"oneClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.oneButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
    
}

- (void)twoClick {
    NSLog(@"twoClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.twoButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
}

- (void)threeClick {
    NSLog(@"threeClick");
    self.selectButton.backgroundColor = [UIColor blackColor];
    self.selectButton = self.threeButton;
    self.selectButton.backgroundColor = HEXCOLOR(0xFD761F);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyCertificationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyCertificationInfoCell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 %ld 行", (long)indexPath.row);
}
@end
