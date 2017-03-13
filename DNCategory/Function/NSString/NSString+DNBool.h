//
//  NSString+DNBool.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DNBool)

/**
 *  判断URL中是否包含中文
 */
- (BOOL)isContainChinese;

/**
 *  是否包含空格
 */
- (BOOL)isContainBlank;

/**
 *  是否包含字符串
 */
- (BOOL)hasString:(NSString *)string;

/**
 *  是否为正确格式邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  密码有效性检测检测(6-16位不是纯字母或者数字)
 */
- (BOOL)isValiratePassWord;

/**
 *  是否为正确格式手机号
 */
- (BOOL)isValidateMobile;

/**
 *  身份证号码有效性检测
 */
+ (BOOL)isAccurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  银行卡的有效性
 */
- (BOOL)isBankCardluhmCheck;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

@end
