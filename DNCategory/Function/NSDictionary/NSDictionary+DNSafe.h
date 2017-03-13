//
//  NSDictionary+DNSafe.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DNSafe)

/**
 *  安全取出字典中的元素
 */
- (id)safeObjectForKey:(id)key;

/**
 *  从本地json文件中获取信息
 *
 *  @param jsonName json名称
 *
 *  @return 字典信息
 */
+ (NSDictionary *)dictionaryWithJson:(NSString *)jsonName;

/**
 *  从plist中读取字典
 *
 *  @param plist plist名字
 *
 *  @return 字典信息
 */
+ (NSDictionary *)dictionaryWithPlistString:(NSString *)plist;

@end


@interface NSMutableDictionary (DNSafe)

- (void)setSafeValue:(id)value forKey:(NSString *)key;

@end