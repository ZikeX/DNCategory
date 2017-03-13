//
//  NSObject+DNPassWord.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  密码强度级别枚举，从0到6
 */
typedef NS_ENUM(NSInteger, PasswordStrengthLevel)
{
    PasswordStrengthLevelVeryWeak = 0,
    PasswordStrengthLevelWeak,
    PasswordStrengthLevelAverage,
    PasswordStrengthLevelStrong,
    PasswordStrengthLevelVeryStrong,
    PasswordStrengthLevelSecure,
    PasswordStrengthLevelVerySecure
};

@interface NSObject (DNPassWord)

/**
 *  检查密码强度级别
 */
+ (PasswordStrengthLevel)passwordCheckStrength:(NSString *)password;

@end
