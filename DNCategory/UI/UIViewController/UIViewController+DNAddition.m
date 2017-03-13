//
//  UIViewController+DNAddition.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIViewController+DNAddition.h"

@implementation UIViewController (DNAddition)

- (NSString *)toString {
    return NSStringFromClass([self class]);
}

-(NSString*)recursiveDescription {
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel {
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];
    for (UIViewController *childController in self.childViewControllers) {
        [string appendFormat:@"\n%@>",padding];
        [childController addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

- (void)dismissAllModalControllerWithAnimated:(BOOL)flag completion:(ControllerBlock)completion {
    UIViewController *presentViewController = [self presentingViewController];
    UIViewController *lastViewController = self;
    while (presentViewController) {
        id temp = presentViewController;
        presentViewController = [presentViewController presentingViewController];
        lastViewController = temp;
    }
    [lastViewController dismissViewControllerAnimated:flag completion:^{
        if (completion != nil) {
            completion();
        }
    }];
}

@end
