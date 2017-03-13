//
//  NSArray+DNChange.m
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSArray+DNChange.h"

@implementation NSArray (DNChange)

- (NSString *)JSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSString *)string {
    if(self==nil || self.count==0) return @"";
    NSMutableString *str=[NSMutableString string];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,",obj];
    }];
    //删除最后一个','
    NSString *strForRight = [str substringWithRange:NSMakeRange(0, str.length-1)];
    return strForRight;
}

- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array {
    NSSet *set1=[NSSet setWithArray:self];
    NSSet *set2=[NSSet setWithArray:array];
    return [set1 isEqualToSet:set2];
}


- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray {
    NSMutableArray *intersectionArray=[NSMutableArray array];
    if(self.count==0) return nil;
    if(otherArray==nil) return nil;
    //遍历
    for (id obj in self) {
        if(![otherArray containsObject:obj]) continue;
        //添加
        [intersectionArray addObject:obj];
    }
    return intersectionArray;
}

- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray {
    if(self==nil) return nil;
    if(otherArray==nil) return self;
    NSMutableArray *minusArray=[NSMutableArray arrayWithArray:self];
    //遍历
    for (id obj in otherArray) {
        if(![self containsObject:obj]) continue;
        //添加
        [minusArray removeObject:obj];
    }
    return minusArray;
}

@end
