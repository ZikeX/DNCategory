//
//  NSObject+DNKVOBlock.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KVOBlock)(NSDictionary *change, void *context);

@interface NSObject (DNKVOBlock)

- (void)addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(KVOBlock)block;

- (void)removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

- (void)addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(KVOBlock)block;

- (void)removeBlockObserverForKeyPath:(NSString *)keyPath;



@end
