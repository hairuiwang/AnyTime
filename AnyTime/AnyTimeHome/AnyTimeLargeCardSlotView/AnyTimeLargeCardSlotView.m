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

@end

@implementation AnyTimeLargeCardSlotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
    }
    return self;
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
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFirstCell" forIndexPath:indexPath];
            break;
        case 1:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotSecondCell" forIndexPath:indexPath];
            break;
        case 2:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotThirdCell" forIndexPath:indexPath];
            break;
        case 3:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyTimeLargeCardSlotFourthCell" forIndexPath:indexPath];
            break;
        default:
            cell.backgroundColor = [UIColor whiteColor];
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = indexPath.item;
    
    NSLog(@"Clicked item at index: %ld", (long)itemIndex);
//    [[AnyRouter sharedInstance] openURL:@"/certificationDetails" parameters:nil from:nil callback:^(NSDictionary * _Nullable result) {
//
//    }];
    
//    AnyAddressPop *toVC = [[AnyAddressPop alloc]init];
//    toVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [[[AnyRouter sharedInstance] getCurrentViewController] presentViewController:toVC animated:YES completion:^{
//    }];
    AnySelectPop *pop = [[AnySelectPop alloc]init];
    pop.modalPresentationStyle = UIModalPresentationOverFullScreen;
    AnySelectModel *model = [[AnySelectModel alloc] init];
    model.title = @"11111";
    AnySelectModel *model2 = [[AnySelectModel alloc] init];
    model2.title = @"2222";
    pop.dataSourceArray = @[
        model,
        model2
    ];
    [[[AnyRouter sharedInstance] getCurrentViewController] presentViewController:pop animated:YES completion:^{
    }];
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
