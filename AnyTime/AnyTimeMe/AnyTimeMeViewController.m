//
//  AnyTimeMeViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/12.
//

#import "AnyTimeMeViewController.h"

@interface AnyTimeMeViewController ()

@end

@implementation AnyTimeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.purpleColor;
    UIButton *button = [AnyUIFactory buttonWithTitle:@"按钮" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20] backgroundColor:[UIColor redColor] cornerRadius:13 target:self action:@selector(buttonClick)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    
}
- (void) buttonClick {
    [[AnyRouter sharedInstance] openURL:@"/certificationDetails" from:self callback:^(NSDictionary * _Nullable result) {

    }];
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
