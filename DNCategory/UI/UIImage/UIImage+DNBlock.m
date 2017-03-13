//
//  UIImage+DNBlock.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIImage+DNBlock.h"
#import <objc/runtime.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@implementation UIImage (DNBlock)

- (void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock {
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(error == nil){
        if(self.CompleteBlock != nil) self.CompleteBlock();
    }else{
        if(self.FailBlock !=nil) self.FailBlock();
    }
}

/*
 *  模拟成员变量
 */
- (void (^)())FailBlock {
    return objc_getAssociatedObject(self, FailBlockKey);
}
- (void)setFailBlock:(void (^)())FailBlock {
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())CompleteBlock {
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

- (void)setCompleteBlock:(void (^)())CompleteBlock {
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
