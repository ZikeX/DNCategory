//
//  NSArray+DNSafe.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DNSafe)

/**
 *  安全的去除数组中的元素
 *
 *  @param index 数组下标
 *
 *  @return 元素
 */
- (id)safeObjectWithIndex:(NSUInteger)index;

/**
 *  从plist文件中读取其中的数组信息
 *
 *  @param plistName plist文件名(不用加后缀)
 *
 *  @return 数组
 */
+ (NSArray *)dictionaryWithPlist:(NSString *)plistName;

@end

@interface NSMutableArray (DNSafe)

/**
 *  安全的存入元素
 *
 *  @param obj 要存入的元素
 */
- (void)safeAddObject:(id)obj;

@end