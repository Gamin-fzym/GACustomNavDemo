//
//  HomeViewController.m
//  hhhhDemo
//
//  Created by Gamin on 2020/8/8.
//  Copyright © 2020 gamin.com. All rights reserved.
//

#import "HomeViewController.h"
#import "RMNavigationBar.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self setNavigation];
}

- (void)setNavigation {
    self.rm_navgationBar = [RMNavigationBar navWithTitle:@"首页" rightItem:@"加" rightAction:^{
        // 新增

    } backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
