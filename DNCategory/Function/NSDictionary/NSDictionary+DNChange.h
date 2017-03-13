//
//  NSDictionary+DNChange.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DNChange)

/**
 *  字典转json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)XMLString;

/**
 *  合并两个字典
 *
 *  @param dict1 字典1
 *  @param dict2 字典2
 *
 *  @return 合并后的字典
 */
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;

/**
 *  一个字典合并进另一个字典
 *
 *  @param dict 要合并进来的字典
 *
 *  @return 合并后的字典
 */
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;



@end
