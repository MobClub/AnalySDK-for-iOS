//
//  AppDelegate.m
//  AnalySDKDemo
//
//  Created by 陈剑东 on 2017/6/8.
//  Copyright © 2017年 Mob. All rights reserved.
//

#import "AppDelegate.h"
#import "MLDMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MLDMainViewController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
