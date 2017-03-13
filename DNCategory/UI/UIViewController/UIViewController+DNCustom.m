//
//  UIViewController+DNCustom.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIViewController+DNCustom.h"
#import <objc/runtime.h>

static const void *DNBackButtonHandlerKey = &DNBackButtonHandlerKey;


@implementation UIViewController (DNCustom)

- (void)backButtonTouched:(DNBackButtonHandler)backButtonHandler {
    objc_setAssociatedObject(self, DNBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}

- (DNBackButtonHandler)backButtonTouched {
    return objc_getAssociatedObject(self, DNBackButtonHandlerKey);
}

@end

@implementation UINavigationController (ShouldPopItem)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
   	UIViewController* vc = [self topViewController];
    DNBackButtonHandler handler = [vc backButtonTouched];
    if (handler) {
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    
    return NO;
}
@end
