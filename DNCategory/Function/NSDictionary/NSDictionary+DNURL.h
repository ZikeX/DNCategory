//
//  NSDictionary+DNURL.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DNURL)

/**
 *  将url参数转换成字典
 */
+ (NSDictionary *)dictionaryWithUrlQuery:(NSString *)query;

/**
 *  将字典转换成url参数字符串
 */
- (NSString *)urlQueryString;

@end
