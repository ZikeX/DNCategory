//
//  NSNumber+DNAddition.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (DNAddition)

/**
 *  四舍五入
 *
 *  @param digit 限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)doRoundWithDigit:(NSUInteger)digit;

/**
 *  取上整
 *
 *  @param digit 限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)doCeilWithDigit:(NSUInteger)digit;

/**
 *  取下整
 *
 *  @param digit 限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)doFloorWithDigit:(NSUInteger)digit;

@end
