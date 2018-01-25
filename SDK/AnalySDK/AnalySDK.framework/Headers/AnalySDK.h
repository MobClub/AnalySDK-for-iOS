//
//  AnalySDK.h
//  AnalySDK
//
//  Created by 陈剑东 on 2017/5/12.
//  Copyright © 2017年 Mob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSDKUser.h"

@class CLLocation;

@interface AnalySDK : NSObject

/**
 *  初始化SDK
 *
 *  @param appKey    应用标识
 *  @param appSecret 应用密钥
 *  @param channel   应用发布渠道(选填,默认为"App Store")
 *  @param url       服务器地址
 */
+ (void)initSDKWithAppKey:(NSString *)appKey
                appSecret:(NSString *)appSecret
                  channel:(NSString *)channel
                 severUrl:(NSString *)url;

/**
 *  事件追踪
 *
 *  @param eventName 事件名称
 *  @param params    事件属性
 */
+ (void)trackEvent:(NSString *)eventName eventParams:(NSDictionary *)params;

/**
 *  标记用户
 *
 *  @param userId 用户标识
 *  @param user   用户对象
 */
+ (void)identifyUser:(NSString *)userId userEntity:(ALSDKUser *)user;

/**
 *  设置地理位置信息(一旦设置,则事件的追踪均带上此地理信息;否则不带)
 *
 *  @param location 地理位置
 */
+ (void)setLocation:(CLLocation *)location;

@end
