//
//  AnyTimeLargeCardSlotSecondCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeLargeCardSlotSecondCell.h"

@interface AnyTimeLargeCardSlotSecondCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray * bannerArr;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AnyTimeLargeCardSlotSecondCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.bannerArr = @[@"anytime_home_banner1",@"anytime_home_banner2"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 0, 360, 115)];
    self.scrollView.contentSize = CGSizeMake(360 * 2, 114);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    [self.contentView addSubview:self.scrollView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


- (void)imageTapped:(UITapGestureRecognizer *)gesture {
    
    NSInteger index = gesture.view.tag;
    
    NSLog(@"Clicked image at index: %ld", (long)index);
    
    
    if (index == 0) {
        
        NSLog(@"Go to detail for banner 1");
    } else if (index == 1) {
        
        NSLog(@"Go to detail for banner 2");
    }
}



- (void)autoScroll
{
    CGFloat currentOffset = self.scrollView.contentOffset.x;
    
    CGFloat nextOffset = currentOffset + 360;
    if (nextOffset >= self.scrollView.contentSize.width)
    {
        nextOffset = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(nextOffset, 0) animated:YES];
}



#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (self.scrollView.contentOffset.x + pageWidth / 2) / pageWidth;
    NSLog(@"page === %ld",(long)page);
}

- (void)setBannerArray:(NSArray *)bannerArray
{
    NSArray * mModelArray = [AnyTimeForestMurderousModel mj_objectArrayWithKeyValuesArray:bannerArray];
    NSLog(@"mModel === %@",mModelArray);
    
    for (int i = 0; i < mModelArray.count; i++)
    {
        AnyTimeForestMurderousModel * murModel = mModelArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 360, 0, 360, 114)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:murModel.violent]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        tapGesture.numberOfTapsRequired = 1;
        imageView.tag = 2000 + i;
        [imageView addGestureRecognizer:tapGesture];
    }
}

@end
