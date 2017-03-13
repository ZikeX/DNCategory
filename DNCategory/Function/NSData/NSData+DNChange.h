//
//  NSData+DNChange.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DNChange)

/**
 *  token 由 NSData类型 -> String类型
 */
- (NSString *)APNSToken;

/**
 *  data转String
 */
- (NSString *)base64EncodedString;

/**
 *  data转UTF8字符串
 */
- (NSString *)UTF8String;

/**
 *  字符串base64转data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

@end
