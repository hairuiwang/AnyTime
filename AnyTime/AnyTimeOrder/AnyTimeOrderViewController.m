//
//  AnyTimeOrderViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeOrderViewController.h"
#import "AnyTimeOrderCardCell.h"
#import "EmptyOrdersViewController.h"

@interface AnyTimeOrderViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray<NSString *> *tabTitles;
@property (nonatomic, strong) NSArray<NSString *> *tabSImages;
@property (nonatomic, strong) NSArray<NSString *> *tabUSImages;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UICollectionViewController *currentVC;

@end

@implementation AnyTimeOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
  
    self.tabTitles = @[@"All", @"Apply", @"Repayment", @"Finished"];
    self.tabSImages = @[@"anytime_order_btn1s",@"anytime_order_btn3s",@"anytime_order_btn3s",@"anytime_order_btn4s"];
    self.tabUSImages = @[@"anytime_order_btn1us",@"anytime_order_btn3us",@"anytime_order_btn3us",@"anytime_order_btn4us"];

    
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_order_bg"]];
    bgImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    [self.view addSubview:bgImageView];

    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_order_header"]];
    topImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(85);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Order";
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
    
    for (int i = 0; i < self.tabTitles.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + i * buttonWidth, 0, buttonWidth, 33);
        [button setTitle:self.tabTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
       
        [button setTitleColor:rgba(1, 1, 1, 0.3) forState:UIControlStateNormal];

        [button setBackgroundImage:[UIImage imageNamed:self.tabUSImages[i]] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;

        [button addTarget:self action:@selector(tabButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [buttonContainer addSubview:button];
        
        if (i == 0) {
            [button setBackgroundImage:[UIImage imageNamed:self.tabSImages[i]] forState:UIControlStateNormal];
            [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        }
    }

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonContainer.mas_bottom).offset(15);
        make.top.mas_equalTo(buttonContainer.mas_bottom).offset(15);
           make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    UIViewController *initialVC = [self viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[initialVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.backgroundImage = [UIImage new];
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.barTintColor = rgba(0, 0, 0, 0);
    self.tabBarController.tabBar.backgroundColor = rgba(0, 0, 0, 0);
    self.pageViewController.view.backgroundColor = rgba(0, 0, 0, 0);

    [self getOrderAllList];
}

- (void)getOrderAllList
{
    [self.dataArray removeAllObjects];

    [AnyHttpTool getOrderListWithTurtle:@"4" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
        AnyTimeOrderModel * orderModel = [AnyTimeOrderModel mj_objectWithKeyValues:responseObject];
        NSLog(@"responseObject == %@",orderModel.puppy);
       
        self.dataArray = [AnyTimeOrderBlowModel mj_objectArrayWithKeyValuesArray:orderModel.blow];
        
        [self.currentVC.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.currentVC.collectionView.mj_header endRefreshing];
        });
        
//        EmptyOrdersViewController * vc = [[EmptyOrdersViewController alloc] init];
//        vc.tryAgainButtonAction = ^{
//            [self getOrderAllList];
//        };
//        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getOrderApplyList
{
    [self.dataArray removeAllObjects];

    [AnyHttpTool getOrderListWithTurtle:@"7" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
        AnyTimeOrderModel * orderModel = [AnyTimeOrderModel mj_objectWithKeyValues:responseObject];
        NSLog(@"responseObject == %@",orderModel.puppy);
       
        self.dataArray = [AnyTimeOrderBlowModel mj_objectArrayWithKeyValuesArray:orderModel.blow];
        
        [self.currentVC.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.currentVC.collectionView.mj_header endRefreshing];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getOrderRepaymentList
{
    [self.dataArray removeAllObjects];

    [AnyHttpTool getOrderListWithTurtle:@"6" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
                
        AnyTimeOrderModel * orderModel = [AnyTimeOrderModel mj_objectWithKeyValues:responseObject];
        NSLog(@"responseObject == %@",orderModel.puppy);
       
        self.dataArray = [AnyTimeOrderBlowModel mj_objectArrayWithKeyValuesArray:orderModel.blow];
        
        [self.currentVC.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.currentVC.collectionView.mj_header endRefreshing];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getOrderFinishedList
{
    [self.dataArray removeAllObjects];

    [AnyHttpTool getOrderListWithTurtle:@"5" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
        AnyTimeOrderModel * orderModel = [AnyTimeOrderModel mj_objectWithKeyValues:responseObject];
        NSLog(@"responseObject == %@",orderModel.puppy);
       
        self.dataArray = [AnyTimeOrderBlowModel mj_objectArrayWithKeyValuesArray:orderModel.blow];
        
        [self.currentVC.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.currentVC.collectionView.mj_header endRefreshing];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Tab Button Action
- (void)tabButtonTapped:(UIButton *)sender 
{
    NSInteger index = sender.tag;
    NSLog(@"index === %ld",(long)index);
    if (index == self.currentIndex) return;
    if (index == 0)
    {
        //all
        [self getOrderAllList];
    }
    else if (index == 1)
    {
        //apply
        [self getOrderApplyList];
    }
    else if (index == 2)
    {
        //repayment
        [self getOrderRepaymentList];
    }
    else
    {
        //finished
        [self getOrderFinishedList];
    }
    
    UIPageViewControllerNavigationDirection direction = index > self.currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    self.currentIndex = index;
    
    UIViewController *vc = [self viewControllerAtIndex:index];
    [self.pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:nil];
    
    [self updateTabButtonColorsForSelectedIndex:index];
}


#pragma mark - UIPageViewController Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController
    didFinishAnimating:(BOOL)finished
 previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
    transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        UIViewController *currentVC = pageViewController.viewControllers.firstObject;
        NSInteger index = ((UICollectionViewController *)currentVC).collectionView.tag;
        self.currentIndex = index;
        
        [self updateTabButtonColorsForSelectedIndex:index];
    }
}



- (void)updateTabButtonColorsForSelectedIndex:(NSInteger)selectedIndex 
{
    UIView *buttonContainer = [self.view viewWithTag:101];
    for (UIView *subview in buttonContainer.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            NSInteger buttonIndex = button.tag;
            
            [button setTitleColor:(button.tag == selectedIndex ? [UIColor blackColor] : rgba(1, 1, 1, 0.3)) forState:UIControlStateNormal];

            if (buttonIndex == selectedIndex) {
                [button setBackgroundImage:[UIImage imageNamed:self.tabSImages[buttonIndex]] forState:UIControlStateNormal];
            } else {
                [button setBackgroundImage:[UIImage imageNamed:self.tabUSImages[buttonIndex]] forState:UIControlStateNormal];
            }
        }
    }
}


#pragma mark - UIPageViewController DataSource
- (UIViewController *)viewControllerAtIndex:(NSInteger)index 
{
    if (index < 0 || index >= self.tabTitles.count) return nil;
    
    UICollectionViewController * vc = [[UICollectionViewController alloc] initWithCollectionViewLayout:[self createLayout]];
    vc.collectionView.tag = index;
    vc.collectionView.backgroundColor = rgba(0, 0, 0, 0);
    [vc.collectionView registerClass:[AnyTimeOrderCardCell class] forCellWithReuseIdentifier:@"AnyTimeOrderCardCell"];
    vc.collectionView.dataSource = self;
    vc.collectionView.delegate = self;
//    no data or 404
//    EmptyOrdersViewController * vc = [[EmptyOrdersViewController alloc] init];
    NSLog(@"indes ==== %ld",(long)index);
    
    self.currentVC = vc;
    
    if (index == 0)
    {
        vc.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOrderAllList)];
    }
    else if (index == 1)
    {
        vc.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOrderApplyList)];
    }
    else if (index == 2)
    {
        vc.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOrderRepaymentList)];
    }
    else
    {
        vc.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOrderFinishedList)];

    }
    [vc.collectionView.mj_header beginRefreshing];
    vc.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    return vc;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((UICollectionViewController *)viewController).collectionView.tag;
    return [self viewControllerAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((UICollectionViewController *)viewController).collectionView.tag;
    return [self viewControllerAtIndex:index + 1];
}

#pragma mark - UICollectionView Layout
- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, 50);
    layout.minimumLineSpacing = 10;
    return layout;
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, 200);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath 
{
    AnyTimeOrderCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeOrderCardCell" forIndexPath:indexPath];
    if (self.dataArray.count > 0)
    {
        AnyTimeOrderBlowModel * blowModel = self.dataArray[indexPath.row];
        
        cell.goldenModel = [AnyTimeOrderBlowGoldenModel mj_objectWithKeyValues: blowModel.golden];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 执行点击逻辑，例如打印信息
    NSLog(@"Tapped on Page %ld - Item %ld", (long)collectionView.tag, (long)indexPath.item);
    AnyTimeOrderBlowModel * blowModel = self.dataArray[indexPath.row];
    
    AnyTimeOrderBlowGoldenModel * goldenModel = [AnyTimeOrderBlowGoldenModel mj_objectWithKeyValues: blowModel.golden];
    NSLog(@"goldenModel === %@",goldenModel.sour);
}

@end
