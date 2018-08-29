//
//  AnalySDKDemoTests.m
//  AnalySDKDemoTests
//
//  Created by 陈剑东 on 2018/8/14.
//  Copyright © 2018年 Mob. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AnalySDK/AnalySDK.h>
#import <CoreLocation/CoreLocation.h>
@interface AnalySDKDemoTests : XCTestCase

@end

@implementation AnalySDKDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*  云端版单元测试  */

- (void)testTrack_Nomal_cloud
{
    [AnalySDK trackEvent:@"unit_text" eventParams:@{@"time":@"123"}];
}

- (void)testTrack_Nil_Params_cloud
{
    [AnalySDK trackEvent:@"unit_text_np" eventParams:nil];
}

- (void)testTrack_Nil_EventName_cloud
{
    [AnalySDK trackEvent:nil eventParams:@{@"time":@"123"}];
}

- (void)testUserRegist_cloud
{
    ALSDKUser *user = [ALSDKUser userWithId:@"unittest-userId" regType:@"regType" regChannel:@"regChannel" ];
    user.nickName = @"unit test";
    
    [AnalySDK userRegist:user];
    
}

- (void)testUserLogin_cloud
{
    ALSDKUser *user = [ALSDKUser userWithId:@"unittest-userId" loginType:@"loginType" loginChannel:@"loginChannel"];
    user.nickName = @"unit test";
    
    [AnalySDK userLogin:user];
    
}

- (void)testUserUpdate_cloud
{
    ALSDKUser *user = [ALSDKUser userWithId:@"unittest-userId"];
    user.nickName = @"update unit test name";
    
    [AnalySDK userUpdate:user];
}

- (void)testRoleCreate_cloud
{
    
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid" roleId:@"roleid"];
    
    role.roName = @"IM UNIT TEST";
    
    [AnalySDK roleCreate:role];
}

- (void)testRoleLogin_cloud
{
    
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid" roleId:@"roleid"];
    
    role.roName = @"IM UNIT TEST";
    
    [AnalySDK roleLogin:role];
}

- (void)testRoleUpdate_cloud
{
    ALSDKRole *role = [ALSDKRole roleWithUserId:@"userid" roleId:@"roleid"];
    
    role.roName = @"IM UNIT TEST update";
    role.roCareer = @"iOS";
    
    [AnalySDK roleUpdate:role];
}

- (void)testPay_cloud
{
    ALSDKPayEvent *pay = [[ALSDKPayEvent alloc] init];
    pay.payMoney = 1000;
    pay.payContent = @"vip";
    
    [AnalySDK trackPayEvent:pay];
}

- (void)testSetLocation_cloud
{
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:31.22 longitude:121.48];
    [AnalySDK setLocation:cl];
}

- (void)testSetLocation_Nil_cloud
{
    [AnalySDK setLocation:nil];
}

- (void)testSetLocation_Invalid_cloud
{
    [AnalySDK setLocation:[[CLLocation alloc] init]];
}

- (void)testEventDuration
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"模拟延迟3秒"];
    [AnalySDK behaviorStart:@"unit_text"  eventParams:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AnalySDK behaviorEnd:@"unit_text" eventParams:nil];
        [expectation fulfill];
    });
    
    // 等待 5s 期望预期达成
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
