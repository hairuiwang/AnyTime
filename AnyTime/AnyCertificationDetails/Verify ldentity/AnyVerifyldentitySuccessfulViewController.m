//
//  AnyVerifyldentitySuccessfulViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyVerifyldentitySuccessfulViewController.h"
#import "AnyVerifyldentity02Cell.h"
#import "AnyVerifyldentitySuccessfull01Cell.h"
#import "AnyCertificationInfoCell.h"

@interface AnyVerifyldentitySuccessfulViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AnyVerifyldentitySuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    self.view.backgroundColor = HEXCOLOR(0xFFECD7);
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    
    
    UIImageView *bgImageView = [UIImageView new];
    CGPoint stretchPoint = CGPointMake(100, 100); // 以 (100,100) 为基准点
    UIEdgeInsets insets = UIEdgeInsetsMake(stretchPoint.y, stretchPoint.x, stretchPoint.y, stretchPoint.x);
    UIImage *originalImage = [UIImage imageNamed:@"result_bg"];
    UIImage *resizableImage = [originalImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    bgImageView.image = resizableImage;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.view);
    }];
    
    UIImageView *topImageView = [UIImageView new];
    topImageView.image = [UIImage imageNamed:@"successful_icon"];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    
    
    UIImageView *tab_bgImageView = [UIImageView new];
    CGPoint tab_stretchPoint = CGPointMake(100, 100); // 以 (100,100) 为基准点
    UIEdgeInsets tab_insets = UIEdgeInsetsMake(tab_stretchPoint.y, tab_stretchPoint.x, tab_stretchPoint.y, tab_stretchPoint.x);
    UIImage *tab_originalImage = [UIImage imageNamed:@"cer-bg-icon"];
    UIImage *tab_resizableImage = [tab_originalImage resizableImageWithCapInsets:tab_insets resizingMode:UIImageResizingModeStretch];
    tab_bgImageView.image = tab_resizableImage;
    [self.view addSubview:tab_bgImageView];
    
    UIButton *sureButton = [AnyUIFactory buttonWithTitle:@"Sure" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(sureButtonClick)];
    [self.view addSubview:sureButton];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(273);
    }];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnyVerifyldentitySuccessfull01Cell class] forCellReuseIdentifier:@"AnyVerifyldentitySuccessfull01Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AnyCertificationInfoCell" bundle:nil] forCellReuseIdentifier:@"AnyCertificationInfoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    self.tableView.layer.maskedCorners = kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    self.tableView.layer.cornerRadius = 12;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.layer.borderWidth = 1;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 20))];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(topImageView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(sureButton.mas_top).offset(-20);
    }];
    [tab_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.tableView);
    }];
    [sureButton setTitle:@"Next" forState:(UIControlStateNormal)];
    
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:true];
}
- (void) sureButtonClick {
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    }
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor blackColor];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 44);
    UILabel *tableHeaderLabel = [UILabel new];
    tableHeaderLabel.text = section == 0 ? @"PRC ID":@"Face";
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
    if (section == 2) {
        return 0.01;
    }
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 0.01, 0.01))];
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.01;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        AnyCertificationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyCertificationInfoCell" forIndexPath:indexPath];
        cell.textField.userInteractionEnabled = NO;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"Full Name";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"ID NO.";
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"Date of Birth";
        }
        return cell;
    } else {
        AnyVerifyldentitySuccessfull01Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyVerifyldentitySuccessfull01Cell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.iconImageView.image = [UIImage imageNamed:@"successful_icon_01"];
        } else {
            cell.iconImageView.image = [UIImage imageNamed:@"successful_icon_02"];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
