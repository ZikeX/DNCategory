//
//  NSUserDefaults+DNSafe.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (DNSafe)

/**
 *  安全的存入一个键值对
 *
 *  @param value   value
 *  @param key key
 */
-(void)setSafeValue:(id)value forKey:(NSString*)key;

@end
