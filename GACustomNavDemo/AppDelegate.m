//
//  AppDelegate.m
//  hhhhDemo
//
//  Created by Gamin on 2020/8/8.
//  Copyright © 2020 gamin.com. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
