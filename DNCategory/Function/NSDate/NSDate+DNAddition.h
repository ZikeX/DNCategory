//
//  NSDate+DNAddition.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DNAddition)

- (NSInteger)getYear;
- (NSInteger)getMonth;
- (NSInteger)getDay;
- (NSString *)getWeek;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  字符串转日期
 */
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 *  将NSDate对象转换成时间戳
 *
 *  @return 时间戳
 */
- (NSString *)toTimeStamp;

/**
 *  将时间戳转换成NSDate对象
 *
 *  @param timeStamp 时间戳（如：1461724426.016034）
 *
 *  @return date对象
 */
+ (NSDate *)toDateWithTimeStamp:(NSString *)timeStamp;

/**
 *  计算时间差 如刚刚,几分钟前,几小时前,几天前
 */
+ (NSString *)returnUploadTime:(NSString *)timeStr;


@end
