//
//  NSObject+DNCopy.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DNCopy)

/**
 *  浅拷贝目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return YES成功 NO失败
 */
- (BOOL)easyShallowCopy:(NSObject *)instance;

/**
 *   深拷贝目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return YES成功 NO失败
 */
- (BOOL)easyDeepCopy:(NSObject *)instance;

@end
