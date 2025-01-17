//
//  AnyTimeLargeCardSlotView.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotView.h"
#import "AnyTimeLargeCardSlotFirstCell.h"
#import "AnyTimeLargeCardSlotSecondCell.h"
#import "AnyTimeLargeCardSlotThirdCell.h"
#import "AnyTimeLargeCardSlotFourthCell.h"

@interface AnyTimeLargeCardSlotView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * largeCardData;
@property (nonatomic, strong) NSArray * largeCardBannerData;

@end

@implementation AnyTimeLargeCardSlotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)getLargeCardData
{
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool fetchHomePageWithAuras:@"saadaffffgf" apart:@"sdadadsad" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        
        [AnyTimeHUD hideHUD];
        
        NSDictionary * dic = RDic(responseObject);
        AnyTimeHomeModel * homeModel = [AnyTimeHomeModel mj_objectWithKeyValues:dic];
        AnyTimeActingModel * actModel = homeModel.acting;
        NSLog(@"homeModel ==%@",actModel.aura);
        self.largeCardData = RArr(actModel.murderous);
      
        AnyTimeForestModel * forsetModel = homeModel.forest;
        self.largeCardBannerData = RArr(forsetModel.murderous);
        
        [self.collectionView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            
        });
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
    }];
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = rgba(0, 0, 0, 0);
    
    [self.collectionView registerClass:[AnyTimeLargeCardSlotFirstCell class] forCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFirstCell"];
    [self.collectionView registerClass:[AnyTimeLargeCardSlotSecondCell class] forCellWithReuseIdentifier:@"AnyTimeLargeCardSlotSecondCell"];
    [self.collectionView registerClass:[AnyTimeLargeCardSlotThirdCell class] forCellWithReuseIdentifier:@"AnyTimeLargeCardSlotThirdCell"];
    [self.collectionView registerClass:[AnyTimeLargeCardSlotFourthCell class] forCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFourthCell"];
       
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    [self addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)refreshData {
    
    [self getLargeCardData];
}
#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView 
{
    if (self.largeCardBannerData.count == 0)
    {
        return 3;
    }
    else
    {
        return 4;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;  // 外部声明 cell 变量

    if (self.largeCardBannerData.count == 0)
    {
        switch (indexPath.section) {
            case 0: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFirstCell" forIndexPath:indexPath];
                AnyTimeLargeCardSlotFirstCell *firstCell = (AnyTimeLargeCardSlotFirstCell *)cell;  // 强制转换为对应的类型
                
                firstCell.murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.largeCardData[0]];
            }
                break;
            case 1: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotThirdCell" forIndexPath:indexPath];
                
            }
                break;
            case 2: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFourthCell" forIndexPath:indexPath];
            }
                break;
            default:
                cell.backgroundColor = [UIColor whiteColor];
                break;
        }
    }
    else
    {
        switch (indexPath.section) {
            case 0: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFirstCell" forIndexPath:indexPath];
                AnyTimeLargeCardSlotFirstCell *firstCell = (AnyTimeLargeCardSlotFirstCell *)cell;  
                firstCell.murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.largeCardData[0]];
            }
                break;
            case 1: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotSecondCell" forIndexPath:indexPath];
                
                AnyTimeLargeCardSlotSecondCell * secondCell = (AnyTimeLargeCardSlotSecondCell *)cell;
                secondCell.bannerArray = self.largeCardBannerData;
            }
                break;
            case 2: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotThirdCell" forIndexPath:indexPath];
            }
                break;
            case 3: {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFourthCell" forIndexPath:indexPath];
            }
                break;
            default:
                cell.backgroundColor = [UIColor whiteColor];
                break;
        }
    }


    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = indexPath.item;
    if (itemIndex == 0)
    {
        AnyTimeActMurderousModel * murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.largeCardData[0]];
        [AnyRouterTool applyForBox:murderousModel.funny];
    }
    NSLog(@"Clicked item at index: %ld", (long)itemIndex);
//    [[AnyRouter sharedInstance] openURL:@"/certificationDetails" parameters:nil from:nil callback:^(NSDictionary * _Nullable result) {
//
//    }];
    
//    AnyAddressPop *toVC = [[AnyAddressPop alloc]init];
//    toVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [[[AnyRouter sharedInstance] getCurrentViewController] presentViewController:toVC animated:YES completion:^{
//    }];
//    AnySelectPop *pop = [[AnySelectPop alloc]init];
//    pop.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    AnySelectModel *model = [[AnySelectModel alloc] init];
//    model.title = @"11111";
//    AnySelectModel *model2 = [[AnySelectModel alloc] init];
//    model2.title = @"2222";
//    pop.dataSourceArray = @[
//        model,
//        model2
//    ];
//    [[[AnyRouter sharedInstance] getCurrentViewController] presentViewController:pop animated:YES completion:^{
//    }];
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.bounds.size.width; // 设置宽度为自定义视图的宽度
    
    // 根据不同的 section 设置不同的高度
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:
            height = 267;
            break;
        case 1:
            height = 130;
            break;
        case 2:
            height = 310;
            break;
        case 3:
            height = 310;
            break;
        default:
            height = 100; 
            break;
    }
    
    return CGSizeMake(width, height);
}


@end
