//
//  AnyTimeMeSettingViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "AnyTimeMeSettingViewController.h"
#import "AnyTimeMeSettingTableViewCell.h"
#import "AnyTimeCustomPopupView.h"
#import "AnyTimeLoginViewController.h"

@interface AnyTimeMeSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSArray * imageData;

@end

@implementation AnyTimeMeSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed = YES;

    [AnyNavigationBarUtil setNavigationBarTransparent:self transparent:YES];
    
    [AnyNavigationBarUtil setNavigationBarTitleFont:self font:[UIFont boldSystemFontOfSize:17] color:[UIColor blackColor]];
    
    [AnyNavigationBarUtil setCustomBackButton:self image:[UIImage imageNamed:@"back"] action:@selector(backClick)];
    
    self.navigationItem.title = @"Set Up";
    
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_order_bg"]];
    [self.view addSubview:bgImageView];

    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
    UIImageView * contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_me_contentbg"]];
    [self.view addSubview:contentImageView];
    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT + 20);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(225);
    }];
    
    self.data = @[@"Version", @"Logout", @"Account Cancellation"];
    self.imageData = @[@"anytime_me_about", @"anytime_me_set", @"anytime_me_aboutper"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.greenColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AnyTimeMeSettingTableViewCell class] forCellReuseIdentifier:@"AnyTimeMeSettingTableViewCell"];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentImageView.mas_left).offset(30);
        make.right.mas_equalTo(contentImageView.mas_right).offset(-15);
        make.top.mas_equalTo(contentImageView.mas_top).offset(15);
        make.bottom.mas_equalTo(contentImageView.mas_bottom).offset(-15);
    }];
    
    UIImageView * bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_me_banner"]];
    [self.view addSubview:bannerImageView];
    [bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(121);
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
    AnyTimeMeSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnyTimeMeSettingTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.data[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.imageData[indexPath.row]];
    cell.bottomLineView.hidden = (indexPath.row == self.data.count - 1);
    [cell configureCellWithIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selected: %@", self.data[indexPath.row]);
    if ([self.data[indexPath.row] isEqualToString:@"Logout"])
    {
        AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:self.view.bounds];
        popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
        popupView.titleText = @"Go Out";
        popupView.descriptionText = @"Are you sure you want to logout of your account?";
        popupView.firstButtonTitle = @"Confirm";
        popupView.secondButtonTitle = @"Cancel";
        
        popupView.firstButtonAction = ^{
            NSLog(@"First button tapped");
            [AnyTimeHUD showLoadingHUD];
            [AnyHttpTool logoutWithShowered:@"adsdasdassadad" assassins:@"asdadaaddaass" success:^(id  _Nonnull responseObject) {
                [AnyTimeHUD hideHUD];
                [AnyDevHelper saveToUserDefaults:SESSIONID value:@""];
                [AnyDevHelper saveBoolToUserDefaults:LOGIN_STATUS value:NO];

                AnyTimeLoginViewController * rootVC = [[AnyTimeLoginViewController alloc] init];
                CURRENT_WINDOW.rootViewController = rootVC;
                
            } failure:^(NSError * _Nonnull error) {
                [AnyTimeHUD hideHUD];
            }];
        };

        popupView.secondButtonAction = ^{
            NSLog(@"Second button tapped");
           
        };

        popupView.closeAction = ^{
            NSLog(@"Close button tapped");
        };

        [popupView showInView:self.view];
    }
    else if([self.data[indexPath.row] isEqualToString:@"Account Cancellation"])
    {
        AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initCancellationAccountWithFrame:self.view.bounds];
        popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbigbg"];
        popupView.titleText = @"Account Cancellation";
        popupView.descriptionText = @"Once an account is cancelled, itcannot be restored. To ensure thesecurity of your account, pleaseconfrm that account-relatedservices have been handleproperlybefore submitting your application.";
        popupView.firstButtonTitle = @"Cancel";
        popupView.secondButtonTitle = @"Delete Account";
        
        popupView.firstButtonAction = ^{
            NSLog(@"First button tapped");
        };

        popupView.secondButtonAction = ^{
            NSLog(@"Second button tapped");
            [AnyTimeHUD showLoadingHUD];
            [AnyHttpTool deactivateAccountWithGotten:@"adsasdadadsa" success:^(id  _Nonnull responseObject) {
                [AnyDevHelper saveToUserDefaults:SESSIONID value:@""];
                [AnyDevHelper saveBoolToUserDefaults:LOGIN_STATUS value:NO];
                
                AnyTimeLoginViewController * rootVC = [[AnyTimeLoginViewController alloc] init];
                CURRENT_WINDOW.rootViewController = rootVC;
                
                
                [AnyTimeHUD hideHUD];
            } failure:^(NSError * _Nonnull error) {
                [AnyTimeHUD hideHUD];
            }];
        };

        popupView.closeAction = ^{
            NSLog(@"Close button tapped");
        };

        [popupView showInView:self.view];
    }
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
