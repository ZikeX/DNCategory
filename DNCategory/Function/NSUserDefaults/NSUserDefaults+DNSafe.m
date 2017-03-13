//
//  NSUserDefaults+DNSafe.m
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSUserDefaults+DNSafe.h"

@implementation NSUserDefaults (DNSafe)

-(void)setSafeValue:(id)value forKey:(NSString*)key {
    if (value != nil && ![value isEqual:[NSNull null]]) {
        [self setObject:value forKey:key];
    }
}

@end
