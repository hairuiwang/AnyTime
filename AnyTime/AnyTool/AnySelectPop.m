//
//  AnySelectPop.m
//  AnyTime
//  
//  Created by wealon on 2025.
//  AnyTime.
//  
    

#import "AnySelectPop.h"
#import "AnySelectCell.h"

@interface AnySelectPop ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@end

@implementation AnySelectPop
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLORA(0x000000, 0.4);
    
    [self setupUI];
    
}
- (void)setupUI {
    self.bgImageView = [UIImageView new];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"info-confirm-icon"];
    CGFloat height = SCALED_HEIGHT(image.size.width, image.size.height, SCREEN_WIDTH - 38*2);
    CGFloat bottomHeight = SCALED_HEIGHT(image.size.width, 261, SCREEN_WIDTH - 38*2);
    CGFloat topSpace = SCALED_HEIGHT(image.size.width, 180, SCREEN_WIDTH - 38*2);
    
    self.bgImageView.image = image;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38);
        make.right.mas_equalTo(self.view.mas_right).offset(-38);
        make.height.mas_equalTo(height);
        make.centerY.mas_equalTo(self.view);
    }];
    UILabel *titleLabel = [AnyUIFactory labelWithText:@"Select Address" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15] textAlignment:(NSTextAlignmentCenter)];
    [self.bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(13);
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(82);
    }];
    self.titleLabel = titleLabel;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AnySelectCell class] forCellReuseIdentifier:@"AnySelectCell"];
    // 添加到视图
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left);
        make.right.mas_equalTo(self.bgImageView.mas_right);
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(topSpace);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom);
    }];
    
    UIButton *confirmButton = [AnyUIFactory buttonWithTitle:@"Confirm" textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor blackColor] cornerRadius:22 target:self action:@selector(confirmButtonClick)];
    [self.view addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(13);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *closeButton = [UIButton new];
    [closeButton setImage:[UIImage imageNamed:@"close-icon"] forState:(UIControlStateNormal)];
    [closeButton addTarget:self action:@selector(closeTouchClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(confirmButton.mas_bottom).offset(15);
    }];
}

- (void) closeTouchClick {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}
- (void) confirmButtonClick {
    if (self.selectIndexPath != nil) {
        if (self.selectHandler != nil) {
            AnySelectModel *model = self.dataSourceArray[self.selectIndexPath.row];
            self.selectHandler(model.title, self.selectIndexPath.row);
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}
// 返回 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnySelectCell" forIndexPath:indexPath];
    cell.isImage = self.isImage;
    AnySelectModel *model = self.dataSourceArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.isChose = indexPath == self.selectIndexPath;
    NSString *imageStr = model.imageStr;
    if (imageStr.length > 0) {
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中 Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [tableView reloadData];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

@end
