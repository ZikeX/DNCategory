//
//  NSObject+DNThread.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DNThread)

/**
 *  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)performAsynchronous:(void(^)(void))block;

/**
 *  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否异步加载
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  延迟执行代码块
 *
 *  @param seconds 延迟时间
 *  @param block   代码块
 */
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

@end
