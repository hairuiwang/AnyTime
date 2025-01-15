//
//  AnyTimeMeViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeMeViewController.h"
#import "AnyTimeMeTableViewCell.h"
#import "AnyTimeMeSettingViewController.h"

@interface AnyTimeMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSArray * imageData;

@property (nonatomic, strong) NSArray<NSString *> *tabTitles;
@property (nonatomic, strong) UIImageView * contentImageView;

@end

@implementation AnyTimeMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.purpleColor;
//    UIButton *button = [AnyUIFactory buttonWithTitle:@"按钮" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20] backgroundColor:[UIColor redColor] cornerRadius:13 target:self action:@selector(buttonClick)];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.width.height.mas_equalTo(200);
//    }];
   
    self.tabTitles = @[@"All", @"Apply", @"Repayment", @"Finished"];

    
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_order_bg"]];
    bgImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    [self.view addSubview:bgImageView];

    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
    [self createHeaderUI];
    [self createContentUI];
}

- (void)createHeaderUI
{
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_me_headerbg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(152);
    }];
    
    UILabel * numLabel = [[UILabel alloc] init];
    numLabel.text = @"123456789";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont boldSystemFontOfSize:18];
    numLabel.textColor = UIColor.whiteColor;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:numLabel.text];
    NSRange range = NSMakeRange(3, 4); // 从第4位开始，长度为4
    [attributedString replaceCharactersInRange:range withString:@"****"];
    numLabel.attributedText = attributedString;
    
    [topImageView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImageView.mas_top).offset(20);
        make.left.mas_equalTo(topImageView.mas_left).offset(125);
        make.right.mas_equalTo(topImageView.mas_right).offset(-42);
        make.height.mas_equalTo(33);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Private Center";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = UIColor.blackColor;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STATUS_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(33);
    }];
    
    
    CGFloat buttonWidth = (self.view.frame.size.width - 30) / 4;
    UIView *buttonContainer = [[UIView alloc] init];
    buttonContainer.tag = 101;
    [self.view addSubview:buttonContainer];
    [buttonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(33);
    }];
    
    for (int i = 0; i < self.tabTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + i * buttonWidth, 0, buttonWidth, 33);
        [button setTitle:self.tabTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
       
        [button setTitleColor:rgba(251, 223, 0, 1) forState:UIControlStateNormal];

        [button setBackgroundImage:[UIImage imageNamed:@"anytime_me_btnbg"] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;

        [button addTarget:self action:@selector(tabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [buttonContainer addSubview:button];
       
    }
    
    self.contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_me_contentbg"]];
    [self.view addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonContainer.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(290);
    }];
}


- (void)tabButtonTapped:(UIButton *)sender
{
    NSInteger index = sender.tag;
    NSLog(@"index === %ld",(long)index);
}


- (void)createContentUI
{
    self.data = @[@"About Us", @"Service online", @"Settings", @"Privacy agreement"];
    self.imageData = @[@"anytime_me_about", @"anytime_me_service", @"anytime_me_set", @"anytime_me_privacya"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.greenColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AnyTimeMeTableViewCell class] forCellReuseIdentifier:@"AnyTimeMeTableViewCell"];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.contentImageView.mas_right).offset(-15);
        make.top.mas_equalTo(self.contentImageView.mas_top).offset(15);
        make.bottom.mas_equalTo(self.contentImageView.mas_bottom).offset(-15);
    }];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnyTimeMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyTimeMeTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.data[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.imageData[indexPath.row]];
    cell.bottomLineView.hidden = (indexPath.row == self.data.count - 1);
       
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selected: %@", self.data[indexPath.row]);
    if ([self.data[indexPath.row] isEqualToString:@"Settings"])
    {
        AnyTimeMeSettingViewController * setVC = [[AnyTimeMeSettingViewController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

- (void) buttonClick {
    [[AnyRouter sharedInstance] openURL:@"/certificationDetails" parameters:nil from:self callback:^(NSDictionary * _Nullable result) {

    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
