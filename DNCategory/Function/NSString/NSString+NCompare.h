//
//  NSString+NCompare.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum{
    NSStringScoreOptionNone                         = 1 << 0,
    NSStringScoreOptionFavorSmallerWords            = 1 << 1,
    NSStringScoreOptionReducedLongStringPenalty     = 1 << 2
};
typedef NSUInteger NSStringScoreOption;

@interface NSString (NCompare)

/**
 *  //模糊匹配字符串 查找某两个字符串的相似程度
 */
- (CGFloat)scoreAgainst:(NSString *)otherString;

@end
