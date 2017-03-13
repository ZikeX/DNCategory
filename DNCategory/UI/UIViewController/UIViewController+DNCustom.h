//
//  UIViewController+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DNBackButtonHandler)(UIViewController *vc);


@protocol DNBackButtonItemTitleProtocol <NSObject>

@optional
- (NSString *)setNavigationItemBackBarButtonTitle;

@end

@interface UIViewController (DNCustom) <DNBackButtonItemTitleProtocol>


- (void)backButtonTouched:(DNBackButtonHandler)backButtonHandler;


@end
