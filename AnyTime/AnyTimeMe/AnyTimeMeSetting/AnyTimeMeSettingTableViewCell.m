//
//  AnyTimeMeSettingTableViewCell.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "AnyTimeMeSettingTableViewCell.h"

@implementation AnyTimeMeSettingTableViewCell

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
    
    self.versionLabel = [[UILabel alloc] init];
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = [UIColor blackColor];
    self.versionLabel.textAlignment = NSTextAlignmentRight;
    self.versionLabel.hidden = YES;
    [self.contentView addSubview:self.versionLabel];

    
    self.bottomLineView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomLineView];
    
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.arrowImageView.image = [UIImage imageNamed:@"anytime_me_rarrow"];
    [self.contentView addSubview:self.arrowImageView];
}

- (void)drawDashedLineWithLayerOnView:(UIView *)view 
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = rgba(255, 113, 25, 1).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.lineDashPattern = @[@5, @3];

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, view.bounds.size.height / 2)];
    [path addLineToPoint:CGPointMake(view.bounds.size.width, view.bounds.size.height / 2)];
    shapeLayer.path = path.CGPath;

    [view.layer addSublayer:shapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat padding = 15;
    CGFloat labelWidth = 100;

    self.iconImageView.frame = CGRectMake(padding, (cellHeight - 40) / 2, 40, 40);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, 0, self.contentView.bounds.size.width - 80, cellHeight);
    
    self.versionLabel.frame = CGRectMake(self.contentView.bounds.size.width - labelWidth - padding,
                                            0,
                                            labelWidth,
                                            self.contentView.bounds.size.height);
    
    self.bottomLineView.frame = CGRectMake(15, cellHeight - 1, self.contentView.bounds.size.width - 10, 1);
    
    [self drawDashedLineWithLayerOnView:self.bottomLineView];

    self.arrowImageView.frame = CGRectMake(self.contentView.bounds.size.width - 16, (cellHeight - 12) / 2, 6, 12);
}

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.arrowImageView.hidden = YES;
        self.versionLabel.hidden = NO;
        self.versionLabel.text = [AnyDevHelper appVersion];
    } else {
        self.arrowImageView.hidden = NO;
        self.versionLabel.hidden = YES; 
    }
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
