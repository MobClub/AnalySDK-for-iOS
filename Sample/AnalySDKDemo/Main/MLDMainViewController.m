//
//  MLDMainViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDMainViewController.h"
#import "MLDSceneViewController.h"
#import "GameAnalyViewController.h"
#import <AnalySDK/AnalySDK.h>
@interface MLDMainViewController ()

@end

@implementation MLDMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ALSDKUser *user = [ALSDKUser userWithId:@"userid-123456"];
    user.nickName = @"李四";
    user.gender = @"Male";
    user.province = @"上海";
    user.country = @"China";

    [AnalySDK userLogin:user];
    
    [self addChildViewControllers];
}

- (void)doSomeThing
{
    
    [AnalySDK trackEvent:@"doSomeThing" eventParams:@{@"key":@"value"}];
    
}

/**
 添加所有子控制器
 */
- (void)addChildViewControllers
{
    // 场景
    MLDSceneViewController *sceneCtr = [[MLDSceneViewController alloc] init];
    [self addChildViewController:sceneCtr navTitle:@"场景" tabTitle:@"常见应用场景" imageName:@"cjyycj"];
    
    GameAnalyViewController *gameVC = [[GameAnalyViewController alloc] init];
    [self addChildViewController:gameVC navTitle:@"游戏专版" tabTitle:@"游戏专版" imageName:@"cjyycj"];
}

/**
 添加一个子控制器

 @param childController 子控制器
 @param navTitle 导航栏标题
 @param tabTitle tabBar标题
 @param imageName tabBar图片名称
 */
- (void)addChildViewController:(UIViewController *)childController
                      navTitle:(NSString *)navTitle
                      tabTitle:(NSString *)tabTitle
                     imageName:(NSString *)imageName
{
    childController.navigationItem.title = navTitle;
    childController.tabBarItem.title = tabTitle;
    
    childController.tabBarItem.image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSString *selImgName = [NSString stringWithFormat:@"%@2",imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed: selImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childController.tabBarItem setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName : [UIColor blackColor],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:11]
                                                         }
                                              forState:UIControlStateNormal];
    
    CGFloat b = (0x4E8BED & 0xff) / 255.0;
    CGFloat g = (0x4E8BED >> 8 & 0xff) / 255.0;
    CGFloat r = (0x4E8BED >> 16 & 0xff) / 255.0;
    [childController.tabBarItem setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName : [UIColor colorWithRed:r green:g blue:b alpha:1],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:11]
                                                         }
                                              forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

@end
