//
//  EmptyOrdersViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/14.
//

#import "EmptyOrdersViewController.h"

@interface EmptyOrdersViewController ()

@end

@implementation EmptyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = rgba(0, 0, 0, 0);
    
    UIImageView *folderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anytime_order_nodata"]];
    folderImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:folderImageView];
    [folderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.mas_equalTo(165);
        make.height.mas_equalTo(153);
    }];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"You have no orders";
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(folderImageView.mas_bottom).offset(20);
    }];
    
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyButton setTitle:@"Go Apply" forState:UIControlStateNormal];
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    applyButton.backgroundColor = [UIColor blackColor];
    applyButton.layer.cornerRadius = 25;
    applyButton.clipsToBounds = YES;
    [self.view addSubview:applyButton];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(messageLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    if (!self.isNoData)
    {
        folderImageView.image = [UIImage imageNamed:@"anytime_order_404"];
        messageLabel.text = @"No network now";
        [applyButton setTitle:@"Try Again" forState:UIControlStateNormal];
        [applyButton addTarget:self action:@selector(tryAgainButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [applyButton addTarget:self action:@selector(applyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)applyButtonTapped {
    if (self.applyButtonAction) {
        self.applyButtonAction();
    }
}

- (void)tryAgainButtonTapped {
    if (self.tryAgainButtonAction) {
        self.tryAgainButtonAction();
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
