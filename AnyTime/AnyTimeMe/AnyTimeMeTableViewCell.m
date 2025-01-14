//
//  AnyTimeMeTableViewCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "AnyTimeMeTableViewCell.h"

@implementation AnyTimeMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.bottomLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomLineView];
    
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.arrowImageView.image = [UIImage imageNamed:@"anytime_me_rarrow"];
    [self.contentView addSubview:self.arrowImageView];
}

- (void)drawDashedLineWithLayerOnView:(UIView *)view {
    // 创建 CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = rgba(255, 113, 25, 1).CGColor; // 虚线颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;       // 填充颜色
    shapeLayer.lineWidth = 1;                                  // 虚线宽度
    shapeLayer.lineDashPattern = @[@5, @3];                    // 虚线的线段长度和间隔

    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, view.bounds.size.height / 2)];         // 起点
    [path addLineToPoint:CGPointMake(view.bounds.size.width, view.bounds.size.height / 2)]; // 终点

    shapeLayer.path = path.CGPath;

    // 添加到目标 View 的图层
    [view.layer addSublayer:shapeLayer];
}



// 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat padding = 15;
    
    self.iconImageView.frame = CGRectMake(padding, (cellHeight - 40) / 2, 40, 40);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, 0, self.contentView.bounds.size.width - 80, cellHeight);
    
    self.bottomLineView.frame = CGRectMake(15, cellHeight - 1, self.contentView.bounds.size.width - 10, 1);
    
    [self drawDashedLineWithLayerOnView:self.bottomLineView];

    self.arrowImageView.frame = CGRectMake(self.contentView.bounds.size.width - 16, (cellHeight - 12) / 2, 6, 12);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
