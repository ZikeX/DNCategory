//
//  NSString+DNChange.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface NSString (DNChange)

/**
 *  字符串转Unicode
 */
- (NSString *)utf8String;

/**
 *  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryValue;

/**
 *  base64编码
 */
- (NSString *)base64EncodedString;

/**
 *  base64解码
 */
- (NSString *)base64DecodedString;

/**
 *  base64解码转data
 */
- (NSData *)base64DecodedData;

/**
 *  Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;

/**
 *  xml字符串转换成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryFromXML;

/**
 *  网址拼接
 *
 *  @param urlString  网址
 *  @param parameters 参数
 *
 *  @return 完整网址
 */
+ (NSString *)URLString:(NSString *)urlString appendParameters:(NSDictionary *)parameters;

/**
 *  将字符串进行Url编码
 */
- (NSString *)encodeURL;

/**
 *  将字符串进行Hash
 */
- (NSString *)hmacSha1WithKey:(NSString *)key;

/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;


// 播放器_时间转换
+ (NSString *)convertTime:(CGFloat)second;


@end
