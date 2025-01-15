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

@interface AnyCertificationDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AnyBottomProductInfor *bottomInforView;
@property (nonatomic, strong) UITableView *tableView;
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
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; // 示例：10 行
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
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 %ld 行", (long)indexPath.row);
    if (indexPath.section == 0) {
//        AnyVerifyldentityIDTypeViewController *vc = [[AnyVerifyldentityIDTypeViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentityIDTypeViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
    } else if (indexPath.section == 1 ){
        [[AnyRouter sharedInstance] openURL:@"/anyPersonalInforViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
        
    }else if (indexPath.section == 2 ){
        [[AnyRouter sharedInstance] openURL:@"/anyContactInforViewController" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {}];
        
    }
}

@end
