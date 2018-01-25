//
//  ALSDKUser.h
//  AnalySDK
//
//  Created by 陈剑东 on 2017/5/24.
//  Copyright © 2017年 Mob. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ALSDKGender)
{
    /**
     *  保密或未知
     */
    ALSDKGenderUnknown      = 0,
    /**
     *  男性
     */
    ALSDKGenderMale          = 1,
    /**
     *  女性
     */
    ALSDKGenderFemale       = 2,
};

@interface ALSDKUser : NSObject

/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  生日
 */
@property (nonatomic, strong) NSDate *birthday;

/**
 *  性别
 */
@property (nonatomic) ALSDKGender gender;

/**
 *  首次访问时间
 */
@property (nonatomic, strong) NSDate *firstAccessTime;

/**
 *  注册渠道
 */
@property (nonatomic, copy) NSString *retistryChannel;

/**
 *  国家
 */
@property (nonatomic, copy) NSString *country;

/**
 *  省份
 */
@property (nonatomic, copy) NSString *province;

/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;

/**
 *  用户注册时间戳 (毫秒为单位,如1496289659821,其实际对应时间为2017/6/1 12:0:59)
 */
@property (nonatomic) NSInteger registryTime;

/**
 *  自定义属性
 */
@property (nonatomic, strong) NSDictionary *customProperties;

@end
