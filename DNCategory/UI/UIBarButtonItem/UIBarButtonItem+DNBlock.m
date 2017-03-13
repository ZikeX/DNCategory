//
//  UIBarButtonItem+DNBlock.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIBarButtonItem+DNBlock.h"
#import <objc/runtime.h>

static NSString *const DNActionBlocksArray = @"DNActionBlocksArray";

@interface DNActionBlockWrapper : NSObject

@property (nonatomic, copy) DNActionBlock actionBlock;
@property (nonatomic, assign) UIControlEvents controlEvents;

- (void)invokeBlock:(id)sender;

@end

@implementation DNActionBlockWrapper

- (void)invokeBlock:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

@end


@implementation UIBarButtonItem (DNBlock)

+ (UIBarButtonItem *)itemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(DNActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithBarButtonSystemItem:systemItem target:nil action:nil];
    [barButtonItem setItemBlock:actionBlock];
    return barButtonItem;
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:nil action:nil];
    [barButtonItem setItemBlock:actionBlock];
    return barButtonItem;
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image style:style target:nil action:nil];
    [barButtonItem setItemBlock:actionBlock];
    return barButtonItem;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithTitle:title style:style target:nil action:nil];
    [barButtonItem setItemBlock:actionBlock];
    return barButtonItem;
}

- (void)setItemBlock:(DNActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    DNActionBlockWrapper *blockActionWrapper = [[DNActionBlockWrapper alloc] init];
    blockActionWrapper.actionBlock = actionBlock;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self setTarget:blockActionWrapper];
    [self setAction:@selector(invokeBlock:)];
}

- (NSMutableArray *)actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, &DNActionBlocksArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &DNActionBlocksArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}

@end
