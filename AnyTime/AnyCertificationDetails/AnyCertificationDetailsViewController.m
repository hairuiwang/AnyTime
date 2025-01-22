//
//  AnyCertificationDetailsViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnyCertificationDetailsViewController.h"
#import "AnyBottomProductInfor.h"
#import "AnyCertificationDetailsCell.h"
#import "AnyVerifyldentityIDTypeViewController.h"
#import <SDWebImage/SDWebImage.h>
@interface AnyCertificationDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AnyBottomProductInfor *bottomInforView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *detailsDict;
@property (nonatomic, strong) NSArray *respondedArray;
@end

@implementation AnyCertificationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xFFECD7);
    // 设置导航栏透明
    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    // 设置导航栏标题字体和颜色
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    // 自定义返回按钮
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    self.navigationItem.title = @"Product Detail";
    [self setupView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}
- (void)setupView {
    self.bottomInforView = [[AnyBottomProductInfor alloc]initWithFrame:(CGRectZero)];
    [self.view addSubview:self.bottomInforView];
    [self.bottomInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnyCertificationDetailsCell class] forCellReuseIdentifier:@"AnyCertificationDetailsCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.bottomInforView.mas_top);
    }];
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    mj_header.stateLabel.hidden = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = mj_header;
}
- (void) getData {
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool fetchProductDetailWithBox:self.box depending:@"sflsdafhdsgf" group:@"fadflkdhsagf" success:^(id  _Nonnull responseObject) {
        [AnyTimeHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        self.detailsDict = responseObject;
        self.bottomInforView.detailsDict = self.detailsDict;
        self.respondedArray = responseObject[@"responded"] ?: @[];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.respondedArray.count;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyCertificationDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyCertificationDetailsCell" forIndexPath:indexPath];
    NSDictionary *dict = self.respondedArray[indexPath.section];
    NSString *arrived = [NSString stringWithFormat:@"%@", dict[@"arrived"]];
    cell.isBy = [arrived integerValue] == 1;
    NSString *handed = [NSString stringWithFormat:@"%@", dict[@"handed"]];
    NSString *staying = [NSString stringWithFormat:@"%@", dict[@"staying"]];
    NSString *formed = [NSString stringWithFormat:@"%@", dict[@"formed"]];
    cell.titleLabel.text = handed;
    cell.subLabel.text = staying;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:formed]];
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.respondedArray[indexPath.section];
    NSString *arrived = [NSString stringWithFormat:@"%@", dict[@"arrived"]];
    BOOL isBy = [arrived integerValue] == 1;
    if (isBy) {
        NSString *natural = dict[@"natural"];
        if ([natural isEqualToString:@"anytimef"]) { // 成功
            [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentitySuccessfulViewController" parameters:self.detailsDict from:nil callback:^(NSDictionary * _Nullable result) {}];
        } else if ([natural isEqualToString:@"anytimeg"]) { // 个人信息
            [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController?type=1" parameters:self.detailsDict from:nil callback:^(NSDictionary * _Nullable result) {}];
        } else if ([natural isEqualToString:@"anytimeh"]) { // 工作信息
            [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController?type=2" parameters:self.detailsDict from:nil callback:^(NSDictionary * _Nullable result) {}];
        } else if ([natural isEqualToString:@"anytimei"]) { // 联系人
        [[AnyRouter sharedInstance] openURL:@"/anyContactInforViewController" parameters:self.detailsDict from:nil callback:^(NSDictionary * _Nullable result) {}];
        } else if ([natural isEqualToString:@"anytimej"]) { // 银行卡
            [[AnyRouter sharedInstance] openURL:@"/anyWithdrawalInfoViewController" parameters:self.detailsDict from:nil callback:^(NSDictionary * _Nullable result) {}];
        }
        
        
    } else {
        [[AnyRouter sharedInstance] openURL:@"/next" parameters:self.detailsDict from:self callback:^(NSDictionary * _Nullable result) {}];
    }
    
    
    
    return;
    if (indexPath.section == 0) {
        [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentityIDTypeViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
    } else if (indexPath.section == 1 ){
        [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
        
    }else if (indexPath.section == 2 ){
        [[AnyRouter sharedInstance] openURL:@"/anyContactInforViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
        
    } else if (indexPath.section == 3 ){
        [[AnyRouter sharedInstance] openURL:@"/anyWithdrawalInfoViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
        
    }
}

@end
