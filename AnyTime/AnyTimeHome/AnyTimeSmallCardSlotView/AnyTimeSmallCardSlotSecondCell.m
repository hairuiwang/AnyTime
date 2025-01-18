//
//  AnyTimeSmallCardSlotSecondCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/13.
//

#import "AnyTimeSmallCardSlotSecondCell.h"

@interface AnyTimeSmallCardSlotSecondCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray * bannerArr;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AnyTimeSmallCardSlotSecondCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.bannerArr = [NSArray array];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 0, 360, 121)];
    self.scrollView.contentSize = CGSizeMake(360 * 2, 121);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    [self.contentView addSubview:self.scrollView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    UILabel * loanLabel = [[UILabel alloc] init];
    loanLabel.text = @"Supermarket loan";
    loanLabel.font = FuturaFont(18);
    loanLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:loanLabel];
    [loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < self.bannerArr.count; i++)
    {
        AnyTimeHmmMurderousModel * murModel = self.bannerArr[i];

        UIImageView * contentImage = [[UIImageView alloc] init];
        contentImage.userInteractionEnabled = YES;
        contentImage.image = [UIImage imageNamed:@"anytime_home_smallcard_second"];
        [self.scrollView addSubview:contentImage];
        [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.equalTo(self.scrollView.mas_left).offset(i * 360);
            make.width.mas_equalTo(360);
            make.height.mas_equalTo(121);
        }];
        
        UILabel * contentLabel = [[UILabel alloc] init];
        contentLabel.text = murModel.few;
        contentLabel.font = FuturaFont(18);
        contentLabel.textColor = UIColor.blackColor;
        contentLabel.numberOfLines = 2;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        [contentImage addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentImage.mas_top).offset(5);
            make.left.mas_equalTo(contentImage.mas_left).offset(25);
            make.height.mas_equalTo(90);
            make.width.mas_equalTo(220);
        }];

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        tapGesture.numberOfTapsRequired = 1;
        contentImage.tag = 3000 + i;
        [contentImage addGestureRecognizer:tapGesture];
    }
}

- (void)imageTapped:(UITapGestureRecognizer *)gesture {
    
    NSInteger index = gesture.view.tag - 3000;
    
    NSLog(@"Clicked image at index: %ld", (long)index);
    
    AnyTimeHmmMurderousModel * murModel = self.bannerArr[index];
       
    NSLog(@"murModel: %@", murModel.disgusting);
    if (self.smallCardSlotBannerSelect) {
        self.smallCardSlotBannerSelect(murModel.disgusting);
    }
}



- (void)autoScroll
{
    if (self.bannerArr.count >= 2)
    {
        CGFloat currentOffset = self.scrollView.contentOffset.x;
        
        CGFloat nextOffset = currentOffset + 360;
        if (nextOffset >= self.scrollView.contentSize.width)
        {
            nextOffset = 0;
        }
        
        [self.scrollView setContentOffset:CGPointMake(nextOffset, 0) animated:YES];
    }
}



#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (self.scrollView.contentOffset.x + pageWidth / 2) / pageWidth;
    NSLog(@"page === %ld",(long)page);
}

- (void)setBannerArray:(NSArray *)bannerArray
{
    NSArray * mModelArray = [AnyTimeHmmMurderousModel mj_objectArrayWithKeyValuesArray:bannerArray];

    self.bannerArr = mModelArray;
}
@end
