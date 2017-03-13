//
//  NSArray+DNChange.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DNChange)

/**
  数组转JSON

 @return JSON字符串
 */
- (NSString *)JSONString;

/**
 *  数组转字符串
 *
 *  @return 转换后的字符串
 */
- (NSString *)string;

/**
 *  数组比较
 */
- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;


/**
 *  数组计算交集
 */
- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/**
 *  数据计算差集
 */
- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end
