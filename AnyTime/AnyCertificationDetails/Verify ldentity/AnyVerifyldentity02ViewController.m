//
//  AnyVerifyldentity02ViewController.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    
#import "AnyCameraUtil.h"
#import "AnyVerifyldentity02ViewController.h"
#import "AnyVerifyldentity02Cell.h"
#import "AnyTimeCustomPopupView.h"
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
    UIImageView *bgImageView = [UIImageView new];
    CGPoint stretchPoint = CGPointMake(100, 100); // 以 (100,100) 为基准点
    UIEdgeInsets insets = UIEdgeInsetsMake(stretchPoint.y, stretchPoint.x, stretchPoint.y, stretchPoint.x);
    UIImage *originalImage = [UIImage imageNamed:@"cer-bg-icon"];
    UIImage *resizableImage = [originalImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    bgImageView.image = resizableImage;
    [self.view addSubview:bgImageView];
    
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
    [self.sureButton setTitle:@"Next" forState:(UIControlStateNormal)];
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
        cell.image = [UIImage imageNamed:@"description02"];
    } else {
        cell.image = [UIImage imageNamed:@"description01"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initPhotoGraphWithFrame:self.view.bounds];
    popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbigbg"];
    popupView.titleText = @"Please select";
//    popupView.firstButtonTitle = @"Confirm";
//    popupView.secondButtonTitle = @"Stop";
    
    popupView.camcerButtonAction = ^{
        [self camerEx];
    };

    popupView.photosButtonAction = ^{
        NSLog(@"Second button tapped");
    };

    popupView.closeAction = ^{
        NSLog(@"Close button tapped");
    };

    [popupView showInView:self.view];
}
- (void)camerEx {
    [AnyCameraUtil requestCameraPermission:^(BOOL isGranted) {
        if (isGranted) {
            [AnyCameraUtil takePhotoFromViewController:self useFrontCamera:NO completion:^(UIImage * _Nullable image) {
                [self uploadFaceIDImageWithTowers:@"11" image:image];
            }];
        } else {
            AnyTimeCustomPopupView *popupView = [[AnyTimeCustomPopupView alloc] initGoOutAccountWithFrame:self.view.bounds];
            popupView.backgroundImage = [UIImage imageNamed:@"anytime_alertbg"];
            popupView.titleText = @"Camera permissions";
            popupView.descriptionText = @"Requires camera rights";
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
        }
    }];
}
- (void) uploadFaceIDImageWithTowers:(NSString *)towers image:(UIImage *)image {
    NSDictionary *rest = self.parameters[@"rest"];
    NSString *funny = rest[@"funny"];
    [AnyHttpTool uploadFaceIDImageWithTowers:towers box:funny aura:@"11" casually:image top:self.type weird:@"" direction:@"fsfdsglkhlfdsgh" tower:@"" success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void) sureButtonClick {
    [[AnyRouter sharedInstance] openURL:@"/anyVerifyldentity03ViewController?type=3333" parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {

    }];
}

@end
