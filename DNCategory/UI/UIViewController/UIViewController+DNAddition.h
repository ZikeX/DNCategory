//
//  UIViewController+DNAddition.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewControllerPresentOrientation) {
    UIViewControllerPresentOrientationLeft = 0,
    UIViewControllerPresentOrientationRight,
    UIViewControllerPresentOrientationTop,
    UIViewControllerPresentOrientationBottom
};

typedef void (^ControllerBlock)();


@interface UIViewController (DNAddition)

/**
 *  类的字符串名字
 *
 *  @return 字符串
 */
- (NSString *)toString;

/**
 *  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)recursiveDescription;

/**
 *  关闭所有model
 *
 *  @param flag 是否动画
 */
- (void)dismissAllModalControllerWithAnimated:(BOOL)flag completion:(ControllerBlock)completion;

@end
