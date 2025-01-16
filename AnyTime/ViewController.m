//
//  ViewController.m
//  AnyTime
//
//  Created by Tingyu on 2025/1/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [[AnyNetRequest sharedManager] POST:GetCode parameters:@{@"turning":@"9123123123"} success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
    }];
}


@end
