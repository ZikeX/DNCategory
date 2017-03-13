//
//  NSArray+DNSafe.m
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSArray+DNSafe.h"

@implementation NSArray (DNSafe)

-(id)safeObjectWithIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    } else {
        return nil;
    }
}

+ (NSArray *)dictionaryWithPlist:(NSString *)plistName {
    if (!plistName) return nil;
    NSData* data = [plistName dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithPlistData:data];
}

+ (NSArray *)arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

@end

@implementation NSMutableArray (DNSafe)

- (void)safeAddObject:(id)obj {
    if (obj != nil) {
        [self addObject:obj];
    }
}

@end