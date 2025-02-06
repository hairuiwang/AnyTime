//
//  AnyTimeSmallCardSlotView.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeSmallCardSlotView.h"
#import "AnyTimeSmallCardSlotFirstCell.h"
#import "AnyTimeSmallCardSlotSecondCell.h"
#import "AnyTimeSmallCardSlotThirdCell.h"

@interface AnyTimeSmallCardSlotView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * smallCardData;
@property (nonatomic, strong) NSArray * smallCardKeepData;
@property (nonatomic, strong) NSArray * smallCardHmmData;

@end
@implementation AnyTimeSmallCardSlotView

- (instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dicData;
 {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSDictionary * dic = RDic(dicData);
        AnyTimeHomeModel * homeModel = [AnyTimeHomeModel mj_objectWithKeyValues:dic];
        AnyTimeActingModel * actModel = homeModel.acting;
        NSLog(@"homeModel ==%@",actModel.aura);
        self.smallCardData = RArr(actModel.murderous);
      
        AnyTimeHmmModel * hmmModel = homeModel.hmm;
        self.smallCardHmmData = RArr(hmmModel.murderous);
        
        AnyTimeKeepModel * keepModel = homeModel.keep;
        self.smallCardKeepData = RArr(keepModel.murderous);
        [self setupCollectionView];

        [self.collectionView reloadData];
    }
    return self;
}

- (void)getSmallCardData
{
    [AnyTimeHUD showLoadingHUD];
    [AnyHttpTool fetchHomePageWithAuras:@"saadaffffgf" apart:@"sdadadsad" success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        
        [AnyTimeHUD hideHUD];
        
        NSDictionary * dic = RDic(responseObject);
        AnyTimeHomeModel * homeModel = [AnyTimeHomeModel mj_objectWithKeyValues:dic];
        AnyTimeActingModel * actModel = homeModel.acting;
        NSLog(@"homeModel ==%@",actModel.aura);
        self.smallCardData = RArr(actModel.murderous);
      
        AnyTimeHmmModel * hmmModel = homeModel.hmm;
        self.smallCardHmmData = RArr(hmmModel.murderous);
        
        AnyTimeKeepModel * keepModel = homeModel.keep;
        self.smallCardKeepData = RArr(keepModel.murderous);
        
        [self.collectionView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            
        });
    } failure:^(NSError * _Nonnull error) {
        [AnyTimeHUD hideHUD];
    }];
}

- (void)setupCollectionView {
    if (self.collectionView) {
        return;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = rgba(0, 0, 0, 0);
    
    [self.collectionView registerClass:[AnyTimeSmallCardSlotFirstCell class] forCellWithReuseIdentifier:@"AnyTimeSmallCardSlotFirstCell"];
    [self.collectionView registerClass:[AnyTimeSmallCardSlotSecondCell class] forCellWithReuseIdentifier:@"AnyTimeSmallCardSlotSecondCell"];
    [self.collectionView registerClass:[AnyTimeSmallCardSlotThirdCell class] forCellWithReuseIdentifier:@"AnyTimeSmallCardSlotThirdCell"];
    
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    [self addSubview:self.collectionView];
  
    
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    mj_header.stateLabel.hidden = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;

    self.collectionView.mj_header = mj_header;
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)refreshData {
    
    [self getSmallCardData];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView 
{
    return (self.smallCardData.count  + 1 + 1);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.smallCardHmmData.count > 0)
    {
        if (section == 0)
        {
            return 1;
        }
        else if (section == 1) 
        {
            return 1;
        }
        else
        {
            return self.smallCardKeepData.count;
        }
    }
    else
    {
        if (section == 0)
        {
            return 1;
        }
        else
        {
            return self.smallCardKeepData.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (self.smallCardHmmData.count > 0)
    {
        if (indexPath.section == 0)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeSmallCardSlotFirstCell" forIndexPath:indexPath];
            
            AnyTimeSmallCardSlotFirstCell *firstCell = (AnyTimeSmallCardSlotFirstCell *)cell;  // 强制转换为对应的类型
            if (self.smallCardData.count > 0)
            {
                firstCell.murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.smallCardData[0]];
            }
        }
        else if (indexPath.section == 1)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeSmallCardSlotSecondCell" forIndexPath:indexPath];
            AnyTimeSmallCardSlotSecondCell * secondCell = (AnyTimeSmallCardSlotSecondCell *)cell;
            secondCell.bannerArray = self.smallCardHmmData;
            secondCell.smallCardSlotBannerSelect = ^(NSString * _Nonnull disgusting) {
                //点击预期提醒跳转
                [[AnyRouter sharedInstance] openURL:disgusting parameters:@{} from:nil callback:^(NSDictionary * _Nullable result) {
                }];
            };
        }
        else
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeSmallCardSlotThirdCell" forIndexPath:indexPath];
            AnyTimeSmallCardSlotThirdCell * thirdCell = (AnyTimeSmallCardSlotThirdCell *)cell;

            thirdCell.murderousModel = [AnyTimeKeepMurderousModel mj_objectWithKeyValues:self.smallCardKeepData[indexPath.row]];

        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeSmallCardSlotFirstCell" forIndexPath:indexPath];
            
            AnyTimeSmallCardSlotFirstCell *firstCell = (AnyTimeSmallCardSlotFirstCell *)cell;  // 强制转换为对应的类型
            if (self.smallCardData.count > 0)
            {
                firstCell.murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.smallCardData[0]];
            }
        }
        else
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeSmallCardSlotThirdCell" forIndexPath:indexPath];
            AnyTimeSmallCardSlotThirdCell * thirdCell = (AnyTimeSmallCardSlotThirdCell *)cell;

            thirdCell.murderousModel = [AnyTimeKeepMurderousModel mj_objectWithKeyValues:self.smallCardKeepData[indexPath.row]];

        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = indexPath.item;
    if (indexPath.section == 0) 
    {
        AnyTimeActMurderousModel * murderousModel = [AnyTimeActMurderousModel mj_objectWithKeyValues:self.smallCardData[0]];
        NSLog(@"funny === %@",murderousModel.funny);
        [AnyRouterTool applyForBox:murderousModel.funny];
    }
    else if (indexPath.section > 1)
    {
        AnyTimeKeepMurderousModel * murderousModel = [AnyTimeKeepMurderousModel mj_objectWithKeyValues:self.smallCardKeepData[indexPath.row]];
        NSLog(@"funny === %@",murderousModel.funny);
        [AnyRouterTool applyForBox:murderousModel.funny];
    }
    
    NSLog(@"Clicked item at index: %ld", (long)itemIndex);
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.bounds.size.width;
    CGFloat height = 0;
    if (self.smallCardHmmData.count > 0)
    {
        if (indexPath.section == 0)
        {
            height = 310;
        }
        else if (indexPath.section == 1)
        {
            height = 151;
        }
        else
        {
            height = 200;
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            height = 310;
        }
        else
        {
            height = 200;
        }
    }
   
    return CGSizeMake(width, height);
}


@end
