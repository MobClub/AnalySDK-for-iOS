//
//  GameAnalyViewController.m
//  AnalySDKDemo
//
//  Created by 陈剑东 on 2018/1/25.
//  Copyright © 2018年 Mob. All rights reserved.
//

#import "GameAnalyViewController.h"
#import <AnalySDK/AnalySDK.h>
@interface GameAnalyViewController ()

@end

@implementation GameAnalyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    CGFloat width = 100;
    CGFloat height = 40;
    CGFloat midX = ( self.view.frame.size.width - 100 ) / 2;
    CGFloat midY = 70;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"用户注册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(userRegist) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [button setTitle:@"用户登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"用户更新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(userUpdate) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"角色创建" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(roleCreate) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"角色登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(roleLogin) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"角色更新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(roleUpdate) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
    midY += 60;
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"支付事件" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(midX, midY, width, height);
    [self.view addSubview:button];
    
}

- (void)userRegist
{
    ALSDKUser *user = [ALSDKUser userWithId:@"userid-123456" regType:@"WX" regChannel:@"iOS"];
    [AnalySDK userRegist:user];
}

- (void)userLogin
{
    ALSDKUser *user = [ALSDKUser userWithId:@"userid-123456" loginType:@"WX" loginChannel:@"iOS"];
    [AnalySDK userLogin:user];
}

- (void)userUpdate
{
    ALSDKUser *user = [ALSDKUser userWithId:@"userid-123456"];
    user.nickName = @"updated-nickname";
    user.gender = @"不知道男女";
    user.customProperties = @{@"customkey1":@"自定义1",@"customkey2":@"自定义2"};
    [AnalySDK userUpdate:user];
}

- (void)roleCreate
{
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid-123456" roleId:@"roleid-123456"];
    
    [AnalySDK roleCreate:role];
}

- (void)roleLogin
{
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid-123456" roleId:@"roleid-123456"];
    [AnalySDK roleLogin:role];
}

- (void)roleUpdate
{
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid-123456" roleId:@"roleid-123456"];
    role.customProperties = @{@"customproperty1":@"自定义属性"};
    role.roName = @"nameupdated";
    
    [AnalySDK roleUpdate:role];
}

- (void)pay
{
    ALSDKPayEvent *payevent = [[ALSDKPayEvent alloc] init];
    payevent.payMoney = 1100;
    
    [AnalySDK trackPayEvent:payevent];
}

@end
